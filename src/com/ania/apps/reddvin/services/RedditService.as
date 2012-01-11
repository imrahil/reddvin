/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.services
{
    import com.ania.apps.reddvin.constants.ApplicationConstants;
    import com.ania.apps.reddvin.model.vo.UserVO;
    import com.ania.apps.reddvin.model.vo.VoteVO;
    import com.ania.apps.reddvin.utils.LogUtil;

    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    import mx.core.mx_internal;

    public class RedditService extends RedditServiceBase
    {
        /** Constructor */
        public function RedditService()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * LOGIN
         */
        override public function login(userVO:UserVO):void
        {
            logger.debug(" : login - username: " + userVO.username + ", pass: " + userVO.password);

            loginSuccess = false;
            this.userVO = userVO;

            var loader:URLLoader = new URLLoader();
            var urlRequest:URLRequest = new URLRequest();
            urlRequest.userAgent = userAgent;
            urlRequest.manageCookies = false;

            var url:String = ApplicationConstants.REDDIT_API_ENDPOINT + "/api/login/" + userVO.username;
            urlRequest.url = url;
            urlRequest.method = URLRequestMethod.POST;

            var variables:URLVariables = new URLVariables();
            variables.user = userVO.username;
            variables.passwd = userVO.password;
            variables.api_type = ApplicationConstants.REDDIT_API_TYPE;
            urlRequest.data = variables;

            loader.addEventListener(Event.COMPLETE, handleLoginComplete);
            addLoaderListeners(loader);

            loader.load(urlRequest);
        }

        /**
         * GET SECTION
         */
        override public function getSection(path:String = "", sortOrder:String = "", cookie:String = ""):void
        {
            logger.debug(": getSection - path: " + path + ", sortOrder: " + sortOrder);

            var loader:URLLoader = new URLLoader();
            var urlRequest:URLRequest = new URLRequest();
            urlRequest.userAgent = userAgent;
            urlRequest.manageCookies = false;

            var url:String = ApplicationConstants.REDDIT_API_ENDPOINT;

            // if path is not empty it means that we loading subreddit
            if (path != "")
            {
                url += "/r/" + path;
            }

            // if sort order is not empty it means that we should add sort to url :)
            if (sortOrder != "" && sortOrder != ApplicationConstants.SORT_FRONT)
            {
                url += "/" + sortOrder;
            }

            url += "/" + ApplicationConstants.REDDIT_API_EXTENSION;

            urlRequest.url = url;

            logger.debug(": url: " + url);

            if (cookie != "")
            {
                logger.debug(": cookie: " + cookie);

                var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", "reddit_session=" + cookie);
                urlRequest.requestHeaders = [cookieHeader];
            }

            loader.addEventListener(Event.COMPLETE, handleSectionLoadComplete);
            addLoaderListeners(loader);

            loader.load(urlRequest);
        }

        /**
         * GET REDDIT
         */
        override public function getReddit(id:String, cookie:String = ""):void
        {
            logger.debug(" : getReddit");

            var loader:URLLoader = new URLLoader();
            var urlRequest:URLRequest = new URLRequest();
            urlRequest.userAgent = userAgent;
            urlRequest.manageCookies = false;

            urlRequest.url = ApplicationConstants.REDDIT_API_ENDPOINT + "/comments/" + id + ApplicationConstants.REDDIT_API_EXTENSION + "?limit=" + ApplicationConstants.REDDIT_API_LIMIT;

            if (cookie != "")
            {
                logger.debug(": cookie: " + cookie);

                var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", "reddit_session=" + cookie);
                urlRequest.requestHeaders = [cookieHeader];
            }

            loader.addEventListener(Event.COMPLETE, handleRedditLoadComplete);
            addLoaderListeners(loader);

            loader.load(urlRequest);
        }

        /**
         * VOTE
         */
        override public function vote(vote:VoteVO, cookie:String):void
        {
//			logger.debug(" : vote - itemId: " + vote.itemId + ", dir: " + vote.direction + ", modhash: " + vote.modhash);
//
//			var loader:URLLoader = new URLLoader();
//			var urlRequest:URLRequest = new URLRequest();
//			urlRequest.userAgent = userAgent;
//			urlRequest.manageCookies = false;
//			
//			var url:String = ApplicationConstants.REDDIT_API_ENDPOINT + "/api/vote";
//			urlRequest.url = url;
//			urlRequest.method = URLRequestMethod.POST;
//			
//			var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", "reddit_session=" + cookie);
//			urlRequest.requestHeaders = [cookieHeader];
//			
//			var variables:URLVariables = new URLVariables();
//			variables.id = vote.itemId;
//			variables.dir = vote.direction;
//			variables.uh = vote.modhash;
//			urlRequest.data = variables;
//			
//			loader.addEventListener(Event.COMPLETE, handleVoteComplete);
//			addLoaderListeners(loader);
//			
//			loader.load(urlRequest);
        }
    }
}
