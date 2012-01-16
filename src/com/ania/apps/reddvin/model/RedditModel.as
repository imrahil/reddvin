/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.model
{
    import com.ania.apps.reddvin.constants.ApplicationConstants;
    import com.ania.apps.reddvin.model.vo.RedditVO;
    import com.ania.apps.reddvin.model.vo.SessionVO;
    import com.ania.apps.reddvin.utils.LogUtil;

    import mx.collections.ArrayList;
    import mx.logging.ILogger;

    import org.robotlegs.mvcs.*;

    public class RedditModel extends Actor
    {
        /** variables **/

        private var _sectionItems:ArrayList;
        private var _singleReddit:RedditVO;
        private var _subredditsList:ArrayList;

        private var _session:SessionVO;
        private var _selectedSubreddit:String = "";

        private var _sortOrder:String = "";

        private var _needReload:Boolean = false;

        private var _currentScreen:String = ApplicationConstants.SECTION_VIEW;
        private var _viewState:String = "";
        private var _appState:String = "";

        private var _loggedIn:Boolean = false;

        private var _initialized:Boolean = false;

        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function RedditModel()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }


        /**
         * List of all Reddits in section
         */
        public function get sectionItems():ArrayList
        {
            return _sectionItems;
        }

        public function set sectionItems(value:ArrayList):void
        {
            logger.debug(": set items");

            _sectionItems = value;
        }

        /**
         * Single Reddit
         */
        public function get singleReddit():RedditVO
        {
            return _singleReddit;
        }

        public function set singleReddit(value:RedditVO):void
        {
            logger.debug(": set item");

            _singleReddit = value;
        }

        /**
         * List of subscribed/top/etc subreddits
         */
        public function get subredditsList():ArrayList
        {
            return _subredditsList;
        }

        public function set subredditsList(value:ArrayList):void
        {
            _subredditsList = value;
        }

        /**
         * Session variable
         */
        public function get session():SessionVO
        {
            return _session;
        }

        public function set session(value:SessionVO):void
        {
            logger.debug(": set session");

            _session = value;
        }

        /**
         * Current subreddit
         */
        public function get selectedSubreddit():String
        {
            return _selectedSubreddit;
        }

        public function set selectedSubreddit(value:String):void
        {
            logger.debug(": set selectedSubreddit");

            _selectedSubreddit = value;
        }

        /**
         * Sort order for current subreddit
         */
        public function get sortOrder():String
        {
            return _sortOrder;
        }

        public function set sortOrder(value:String):void
        {
            logger.debug(": set sortOrder");

            _sortOrder = value;
        }

        /**
         * Refresh flag
         */
        public function get needReload():Boolean
        {
            return _needReload;
        }

        public function set needReload(value:Boolean):void
        {
            _needReload = value;
        }

        /**
         * Current section of application
         */
        public function get currentScreen():String
        {
            return _currentScreen;
        }

        public function set currentScreen(value:String):void
        {
            logger.debug(": set currentScreen");

            _currentScreen = value;
        }

        /**
         * Current view state (landscape or portrait)
         */
        public function get viewState():String
        {
            return _viewState;
        }

        public function set viewState(value:String):void
        {
            _viewState = value;
        }

        /**
         * Current state for whole app
         */
        public function get appState():String
        {
            return _appState;
        }

        public function set appState(value:String):void
        {
            _appState = value;
        }

        /**
         * Logged in or not
         */
        public function get loggedIn():Boolean
        {
            return _loggedIn;
        }

        public function set loggedIn(value:Boolean):void
        {
            logger.debug(": set loggedIn - " + value);

            _loggedIn = value;
        }

        /**
         *    Check if application is fully initialized
         */
        public function get initialized():Boolean
        {
            return _initialized;
        }

        public function set initialized(value:Boolean):void
        {
            logger.debug(": set initialized - " + value);

            _initialized = value;
        }
    }
}
