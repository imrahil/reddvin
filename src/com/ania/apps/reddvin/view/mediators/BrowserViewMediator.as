/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
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
         * SIGNALTONS
         */
        [Inject]
        public var displayUrl:DisplayUrlSignal;


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


    }
}
