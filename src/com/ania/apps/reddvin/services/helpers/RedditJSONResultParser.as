/*
Copyright (c) 2011 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/

package com.ania.apps.reddvin.services.helpers
{
	import com.ania.apps.reddvin.model.vo.BaseVO;
	import com.ania.apps.reddvin.model.vo.CommentVO;
	import com.ania.apps.reddvin.model.vo.RedditVO;
	import com.ania.apps.reddvin.utils.DateUtil;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import flash.utils.describeType;
	
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	import mx.logging.Log;

	public class RedditJSONResultParser implements ISearchResultParser
	{
		private var logger:ILogger; 

		public function RedditJSONResultParser()
		{
			logger = LogUtil.getLogger(this);
			
			logger.debug(": constructor");
		}
		
		public function parseSearchResults(results:Object):ArrayList
		{
			logger.debug(": parseSearchResults");
			
			var output:ArrayList = new ArrayList();
			var resultObject:Object;

			try {
				resultObject = JSON.parse(results as String);
			}
			catch (e:Error)
			{
				logger.error("JSON decode failed - " + e.message);
			}
			
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

		public function parseSingleItem(results:Object):RedditVO
		{
//			logger.debug(": parseSingleItem");
//			
//			var resultObject:Object;
//			
//			try {
//				resultObject = JSON.parse(results as String);
//			}
//			catch (e:Error)
//			{
//				logger.error("JSON decode failed - " + e.message);
//			}
//			
//			if (resultObject.length > 0)
//			{
//				var modhash:String = resultObject[0].data.modhash;
//				return createRedditWithComments(resultObject[0].data.children[0].data, 
//												resultObject[0].data.children[0].kind,
//												resultObject[1].data.children, modhash); 
//			}
//			else
//			{
				return null;
//			}
		}
		
		public function parseLoginResult(result:Object):Boolean
		{
//			logger.debug(": parseLoginResult");
//			
//			var resultObject:Object;
//			
//			try {
//				resultObject = JSON.decode(result as String);
//			}
//			catch (e:Error)
//			{
//				logger.error("JSON decode failed - " + e.message);
//			}
//			
//			if (resultObject && resultObject.jquery is Array && (resultObject.jquery as Array).length > 0)
//			{
//				for each (var node:Object in resultObject.jquery)
//				{
//					if (node && node is Array)
//					{
//						var nodeArray:Array = node as Array;
//						var subNodeLength:int = nodeArray.length;
//						
//						for (var x:int = 0; x < subNodeLength; x++)
//						{
//							var subNode:Object = nodeArray[x];
//							
//							if (subNode == "call" && x+1 < subNodeLength && nodeArray[x+1] == "invalid password")
//							{
//								return false;	
//							}
//						}
//					}
//				}
//			}
//
			return true;
		}
		
		private function createBase(targetObject:BaseVO, rawItem:Object, kind:String, modhash:String):void
		{
			targetObject.author 		= rawItem.author;

			targetObject.created 		= rawItem.created;
			targetObject.created_utc	= rawItem.created_utc;
			targetObject.created_string	= DateUtil.convertDateToPast(parseFloat(rawItem.created_utc));
			
			targetObject.downs 			= rawItem.downs;
			targetObject.id 			= rawItem.id;
			targetObject.levenshtein 	= rawItem.levenshtein;	//
			
			if (rawItem.likes == null)
			{
				targetObject.likes 		= -1;
			}
			else
			{
				targetObject.likes		= (rawItem.likes == true) ? 1 : 0; 	
			}
			
			targetObject.name 			= rawItem.name;
			targetObject.subreddit 		= rawItem.subreddit;
			targetObject.subreddit_id 	= rawItem.subreddit_id;
			targetObject.ups 			= rawItem.ups;
			
			targetObject.kind			= kind;
			targetObject.modhash		= modhash;
		}
		
		private function createReddit(rawItem:Object, kind:String, modhash:String):RedditVO
		{
			var redditVO:RedditVO 	= new RedditVO();
			createBase(redditVO, rawItem, kind, modhash);
			
			redditVO.clicked 		= rawItem.clicked;
			
			redditVO.domain 		= rawItem.domain;
			redditVO.hidden 		= rawItem.hidden;
			redditVO.is_self 		= rawItem.is_self;
			redditVO.media 			= rawItem.media;	//
			redditVO.media_embed 	= rawItem.media_embed;	//
			redditVO.num_comments 	= rawItem.num_comments;
			redditVO.over_18 		= rawItem.over_18;
			redditVO.permalink 		= rawItem.permalink;
			redditVO.saved 			= rawItem.saved;
			redditVO.score 			= rawItem.score;
			redditVO.selftext 		= rawItem.selftext;
			redditVO.selftext_html 	= rawItem.selftext_html;
			redditVO.thumbnail 		= rawItem.thumbnail;
			redditVO.title 			= rawItem.title;
			redditVO.url 			= rawItem.url;
			
			return redditVO;
		}

		private function createRedditWithComments(rawItem:Object, kind:String, comments:Array, modhash:String):RedditVO
		{
			var redditVO:RedditVO = createReddit(rawItem, kind, modhash);
			
			redditVO.comments = [];
			for each (var rawComment:Object in comments)
			{
				var newComment:CommentVO = new CommentVO();
				createComment(newComment, rawComment.data, rawComment.kind, modhash)
				redditVO.comments.push(newComment);	
			}
			
			return redditVO;
		}
		
		private function createComment(newCommentVO:CommentVO, rawComment:Object, kind:String, modhash:String):CommentVO
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
	}
}