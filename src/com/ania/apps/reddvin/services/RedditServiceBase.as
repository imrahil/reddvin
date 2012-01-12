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
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.model.vo.RedditVO;
    import com.ania.apps.reddvin.model.vo.SessionVO;
    import com.ania.apps.reddvin.model.vo.UserVO;
    import com.ania.apps.reddvin.model.vo.VoteVO;
    import com.ania.apps.reddvin.services.helpers.ISearchResultParser;
    import com.ania.apps.reddvin.signals.ItemLoadedSignal;
    import com.ania.apps.reddvin.signals.LoginSuccessfulSignal;
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.signals.SectionLoadedSignal;
    import com.ania.apps.reddvin.signals.signaltons.ErrorSignal;
    import com.ania.apps.reddvin.signals.signaltons.LoginStatusSignal;

    import flash.desktop.NativeApplication;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;

    import mx.collections.ArrayList;
    import mx.logging.ILogger;

    import org.robotlegs.mvcs.Actor;

    public class RedditServiceBase extends Actor implements IRedditService
    {
        protected var _parser:ISearchResultParser;

        protected var userAgent:String;
        protected var loginSuccess:Boolean = false;

        protected var userVO:UserVO;

        protected var logger:ILogger;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        /** NOTIFICATION SIGNALS */
        [Inject]
        public var sectionLoaded:SectionLoadedSignal;

        [Inject]
        public var itemLoaded:ItemLoadedSignal;

        [Inject]
        public var loginSuccessful:LoginSuccessfulSignal;

        [Inject]
        public var loginStatusSignal:LoginStatusSignal;

        [Inject]
        public var refreshSignal:RefreshSignal;

        [Inject]
        public var errorSignal:ErrorSignal;

        /** INJECTS */
        [Inject]
        public function set parser(value:ISearchResultParser):void
        {
            _parser = value;
        }

        public function RedditServiceBase()
        {
            super();

            var app_xml:XML = NativeApplication.nativeApplication.applicationDescriptor;
            var ns:Namespace = app_xml.namespace();
            var versionNumber:String = app_xml.ns::versionNumber;
            userAgent = ApplicationConstants.REDDIT_USER_AGENT + versionNumber;
        }

        /**
         * Login request
         * @param userVO
         * http://www.reddit.com/api/login/{username}
         */
        public function login(userVO:UserVO):void
        {
            throw new Error("Override this method!");
        }

        /**
         * request for section (subreddit). Empty means front page.
         * @param path
         */
        public function getSection(path:String = "", sortOrder:String = ""):void
        {
            throw new Error("Override this method!");
        }

        /**
         * request for one reddit specified by id
         * @param id
         */
        public function getReddit(id:String):void
        {
            throw new Error("Override this method!");
        }

        /**
         * Retrieve user info
         * http://www.reddit.com/api/me.json
         */
        public function getUserInfo():void
        {
            throw new Error("Override this method!");
        }

        /**
         * Retrieve user subscribed subreddits
         * http://www.reddit.com/reddits/mine.json
         */
        public function getUserSubreddits():void
        {
            throw new Error("Override this method!");
        }

        /**
         * Place vote
         * @param vote with direction
         * http://www.reddit.com/api/vote
         */
        public function vote(vote:VoteVO):void
        {
            throw new Error("Override this method!");
        }

        /**
         * HANDLERS
         */

        protected function handleSectionLoadComplete(event:Event):void
        {
            logger.debug(": handleSectionLoadComplete");

            var loader:URLLoader = event.currentTarget as URLLoader;

            loader.removeEventListener(Event.COMPLETE, handleSectionLoadComplete);
            removeLoaderListeners(loader);

            var results:ArrayList = _parser.parseSearchResults(loader.data);

            sectionLoaded.dispatch(results);
        }

        protected function handleRedditLoadComplete(event:Event):void
        {
            logger.debug(": handleRedditLoadComplete");

            var loader:URLLoader = event.currentTarget as URLLoader;

            loader.removeEventListener(Event.COMPLETE, handleRedditLoadComplete);
            removeLoaderListeners(loader);

            var resultItem:RedditVO = _parser.parseSingleItem(loader.data);

            itemLoaded.dispatch(resultItem);
        }

        protected function handleLoginComplete(event:Event):void
        {
            logger.debug(": handleLoginComplete");

            var loader:URLLoader = event.currentTarget as URLLoader;

            loader.removeEventListener(Event.COMPLETE, handleLoginComplete);
            removeLoaderListeners(loader);

            var result:String = _parser.checkLoginResult(loader.data as String);

            if (result != ApplicationConstants.LOGIN_ERROR)
            {
                // clean up user's password after successful login
                userVO.password = "";

                var sessionVO:SessionVO = new SessionVO();
                sessionVO.userVO = userVO;
                sessionVO.cookie = result;

                loginSuccessful.dispatch(sessionVO);

                logger.debug(": cookie: " + result);
            }
            else
            {
                errorSignal.dispatch("username/password is wrong");
            }
        }

        protected function handleUserInfoLoadComplete(event:Event):void
        {
            logger.debug(": handleUserInfoLoadComplete");

            var loader:URLLoader = event.currentTarget as URLLoader;

            loader.removeEventListener(Event.COMPLETE, handleUserInfoLoadComplete);
            removeLoaderListeners(loader);

            if (!redditModel.session.userVO)
            {
                redditModel.session.userVO = new UserVO();
            }

            _parser.parseUserDetails(redditModel.session.userVO, loader.data as String);
        }

        protected function handleUserSubredditsLoadComplete(event:Event):void
        {
            logger.debug(": handleUserSubredditsLoadComplete");

            var loader:URLLoader = event.currentTarget as URLLoader;

            loader.removeEventListener(Event.COMPLETE, handleUserSubredditsLoadComplete);
            removeLoaderListeners(loader);

            var results:ArrayList = _parser.parseSearchResults(loader.data);

//            sectionLoaded.dispatch(results);
        }

//		protected function handleVoteComplete(event:Event):void
//		{
//			logger.debug(": handleVoteComplete");
//			
//			var loader:URLLoader = event.currentTarget as URLLoader; 
//			
//			loader.removeEventListener(Event.COMPLETE, handleVoteComplete);
//			removeLoaderListeners(loader);
//
//			refreshSignal.dispatch();
//		}

        /**
         * Handler for errors
         * @param event
         *
         */
        protected function handleError(event:ErrorEvent):void
        {
            logger.error(": handleError - " + event.text);

            removeLoaderListeners(event.currentTarget as URLLoader);

            errorSignal.dispatch(event.text);
        }

        protected function addLoaderListeners(loader:URLLoader):void
        {
            loader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
        }

        protected function removeLoaderListeners(loader:URLLoader):void
        {
            loader.removeEventListener(IOErrorEvent.IO_ERROR, handleError);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
        }
    }
}
