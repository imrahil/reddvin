/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */

package com.ania.apps.reddvin.services.helpers
{
    import com.ania.apps.reddvin.constants.ApplicationConstants;
    import com.ania.apps.reddvin.model.vo.BaseVO;
    import com.ania.apps.reddvin.model.vo.CommentVO;
    import com.ania.apps.reddvin.model.vo.RedditVO;
    import com.ania.apps.reddvin.model.vo.SubredditVO;
    import com.ania.apps.reddvin.model.vo.UserVO;
    import com.ania.apps.reddvin.utils.DateUtil;
    import com.ania.apps.reddvin.utils.LogUtil;

    import flash.utils.describeType;

    import mx.collections.ArrayList;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.events.ResultEvent;

    public class RedditJSONResultParser implements ISearchResultParser
    {
        private var logger:ILogger;

        public function RedditJSONResultParser()
        {
            logger = LogUtil.getLogger(this);

            logger.debug(": constructor");
        }

        public function parseSearchResults(results:String):ArrayList
        {
            logger.debug(": parseSearchResults");

            var output:ArrayList = new ArrayList();
            var resultObject:Object = JSON.parse(results);

            if (resultObject && resultObject.data)
            {
                var modhash:String = resultObject.data.modhash;

                for each (var item:Object in resultObject.data.children)
                {
                    if (item && item.data)
                    {
                        output.addItem(createReddit(item.data, item.kind, modhash));
                    }
                }
            }

            return output;
        }

        public function parseSingleItem(result:String):RedditVO
        {
            logger.debug(": parseSingleItem");

            var resultObject:Object = JSON.parse(result);

            if (resultObject.length > 0)
            {
                var modhash:String = resultObject[0].data.modhash;
                return createRedditWithComments(resultObject[0].data.children[0].data,
                        resultObject[0].data.children[0].kind,
                        resultObject[1].data.children, modhash);
            }
            else
            {
                return null;
            }
        }

        public function parseUserDetails(currentUser:UserVO, result:String):void
        {
            logger.debug(": parseUserDetails");

            var rawResultUser:Object = JSON.parse(result);

            if (rawResultUser && rawResultUser.data)
            {
                currentUser.has_mail = rawResultUser.data.has_mail;
                currentUser.link_karma = rawResultUser.data.link_karma;
                currentUser.comment_karma = rawResultUser.data.comment_karma;
                currentUser.is_gold = rawResultUser.data.is_gold;
                currentUser.is_mod = rawResultUser.data.is_mod;
                currentUser.has_mod_mail = rawResultUser.data.has_mod_mail;
            }
        }

        public function parseUserSubreddits(results:String):ArrayList
        {
            logger.debug(": parseUserSubreddits");

            var output:ArrayList = new ArrayList();
            var resultObject:Object = JSON.parse(results);

            if (resultObject && resultObject.data)
            {
                for each (var item:Object in resultObject.data.children)
                {
                    if (item && item.data)
                    {
                        output.addItem(createSubReddit(item.data));
                    }
                }
            }

            return output;
        }

        public function checkLoginResult(result:String):String
        {
            logger.debug(": checkLoginResult");

            var resultObject:Object = JSON.parse(result);

            if (resultObject && resultObject.json.errors && (resultObject.json.errors as Array).length > 0)
            {
                return ApplicationConstants.LOGIN_ERROR;
            }
            else
            {
                return resultObject.json.data.cookie as String;
            }
        }


        //
        //  STATIC HELPERS
        //

        private static function createBase(targetObject:BaseVO, rawItem:Object, kind:String, modhash:String):void
        {
            targetObject.author = rawItem.author;

            targetObject.created = rawItem.created;
            targetObject.created_utc = rawItem.created_utc;
            targetObject.created_string = DateUtil.convertDateToPast(parseFloat(rawItem.created_utc));

            targetObject.downs = rawItem.downs;
            targetObject.id = rawItem.id;
            targetObject.levenshtein = rawItem.levenshtein;	//

            if (rawItem.likes == null)
            {
                targetObject.likes = -1;
            }
            else
            {
                targetObject.likes = (rawItem.likes == true) ? 1 : 0;
            }

            targetObject.name = rawItem.name;
            targetObject.subreddit = rawItem.subreddit;
            targetObject.subreddit_id = rawItem.subreddit_id;
            targetObject.ups = rawItem.ups;

            targetObject.kind = kind;
            targetObject.modhash = modhash;
        }

        private static function createReddit(rawItem:Object, kind:String, modhash:String):RedditVO
        {
            var redditVO:RedditVO = new RedditVO();
            createBase(redditVO, rawItem, kind, modhash);

            redditVO.clicked = rawItem.clicked;

            redditVO.domain = rawItem.domain;
            redditVO.hidden = rawItem.hidden;
            redditVO.is_self = rawItem.is_self;
            redditVO.media = rawItem.media;	//
            redditVO.media_embed = rawItem.media_embed;	//
            redditVO.num_comments = rawItem.num_comments;
            redditVO.over_18 = rawItem.over_18;
            redditVO.permalink = rawItem.permalink;
            redditVO.saved = rawItem.saved;
            redditVO.score = rawItem.score;
            redditVO.selftext = rawItem.selftext;
            redditVO.selftext_html = rawItem.selftext_html;
            redditVO.thumbnail = rawItem.thumbnail;
            redditVO.title = rawItem.title;
            redditVO.url = rawItem.url;

            return redditVO;
        }

        private static function createRedditWithComments(rawItem:Object, kind:String, comments:Array, modhash:String):RedditVO
        {
            var redditVO:RedditVO = createReddit(rawItem, kind, modhash);

            redditVO.comments = [];
            for each (var rawComment:Object in comments)
            {
                var newComment:CommentVO = new CommentVO();
                createComment(newComment, rawComment.data, rawComment.kind, modhash);
                redditVO.comments.push(newComment);
            }

            return redditVO;
        }

        private static function createComment(newCommentVO:CommentVO, rawComment:Object, kind:String, modhash:String):CommentVO
        {
            createBase(newCommentVO, rawComment, kind, modhash);

            newCommentVO.body = rawComment.body;
            newCommentVO.body_html = rawComment.body_html;
            newCommentVO.link_id = rawComment.link_id;
            newCommentVO.parent_id = rawComment.parent_id;

            if (rawComment.replies && rawComment.replies.data &&
                    rawComment.replies.data.children && (rawComment.replies.data.children as Array).length > 0)
            {
                newCommentVO.replies = [];
                for each (var rawReply:Object in rawComment.replies.data.children)
                {
                    var replyVO:CommentVO;
                    if (rawReply.kind != "more")
                    {
                        replyVO = new CommentVO();
                        createComment(replyVO, rawReply.data, rawReply.kind, modhash);
                        newCommentVO.replies.push(replyVO);
                    }
                    else
                    {
                        replyVO = new CommentVO();
                        replyVO.body = "TODO: Load more comments...";
                        newCommentVO.replies.push(replyVO);
                    }
                }
            }

            return newCommentVO;
        }

        private static function createSubReddit(rawItem:Object):SubredditVO
        {
            var subReddit:SubredditVO = new SubredditVO();

            subReddit.display_name = rawItem.display_name;
            subReddit.name = rawItem.name;
            subReddit.title = rawItem.title;
            subReddit.url = rawItem.url;
            subReddit.created = rawItem.created;
            subReddit.created_utc = rawItem.created_utc;
            subReddit.over18 = rawItem.over18;
            subReddit.subscribers = rawItem.subscribers;
            subReddit.description = rawItem.description;

            return subReddit;
        }
    }
}
