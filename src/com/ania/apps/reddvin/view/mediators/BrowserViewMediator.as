/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.constants.ApplicationConstants;
    import com.ania.apps.reddvin.signals.GetCurrentAppStateSignal;
    import com.ania.apps.reddvin.signals.signaltons.AppCurrentStateSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayUrlSignal;
    import com.ania.apps.reddvin.utils.LogUtil;
    import com.ania.apps.reddvin.view.BrowserView;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.Mediator;

    public class BrowserViewMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:BrowserView;

        /**
         * SIGNAL -> COMMAND
         */
        [Inject]
        public var getCurrentAppStateSignal:GetCurrentAppStateSignal;
        
        /**
         * SIGNALTONS
         */
        [Inject]
        public var displayUrl:DisplayUrlSignal;

        [Inject]
        public var appCurrentStateSignal:AppCurrentStateSignal;
        

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function BrowserViewMediator()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * onRegister
         * Override the invoked of the <code>IMediator</code> and allow you to place your own initialization.
         */
        override public function onRegister():void
        {
            logger.debug(": onRegister");

            view.backBtnClicked.add(onBackBtnClicked);

            view.upVoteClicked.add(onUpVoteClicked);
            view.downVoteClicked.add(onDownVoteClicked);
            view.showCommentsClicked.add(onShowCommentsClicked);

            appCurrentStateSignal.add(onAppCurrentStateSignal);

            getCurrentAppStateSignal.dispatch(false);
        }

        /**
         * Remove all listeners from sectionChange signal when removing from stage
         */
        override public function onRemove():void
        {
            logger.debug(": onRemove");

            appCurrentStateSignal.remove(onAppCurrentStateSignal);
        }

        /** methods **/

        private function onBackBtnClicked():void
        {
            logger.debug(": onBackBtnClicked");

            view.stageWebViewContainer.hideWebView();
            displayUrl.dispatch(false, null);
        }

        private function onUpVoteClicked():void
        {

        }

        private function onDownVoteClicked():void
        {

        }

        private function onShowCommentsClicked():void
        {

        }

        /**
         * Handle view state (portrait/landscape) or app state changes (logged in/logged out)
         * @param viewState
         * @param appState
         */
        private function onAppCurrentStateSignal(viewState:String, appState:String):void
        {
            logger.debug(": onAppCurrentStateSignal - viewState: " + viewState + ", appState: " + appState);

            if (appState == ApplicationConstants.APP_STATE_LOGGED_OUT)
            {
                view.voteUpBtn.enabled = false;
                view.voteDownBtn.enabled = false;
            }
        }
    }
}
