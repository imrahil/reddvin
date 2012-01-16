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
    import com.ania.apps.reddvin.signals.LogoutSignal;
    import com.ania.apps.reddvin.signals.ManualRefreshSignal;
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.signals.signaltons.AppCurrentStateSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayLoginFormSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplaySubredditsSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayUserInfoSignal;
    import com.ania.apps.reddvin.signals.signaltons.HidePopupMenuSignal;
    import com.ania.apps.reddvin.utils.LogUtil;
    import com.ania.apps.reddvin.view.MenuView;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.Mediator;

    public class MenuMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:MenuView;

        /**
         * SIGNAL -> COMMAND
         */
        [Inject]
        public var logoutSignal:LogoutSignal;

        [Inject]
        public var refreshSignal:RefreshSignal;

        [Inject]
        public var manualRefreshSignal:ManualRefreshSignal;

        /**
         * SIGNALTONS
         */
        [Inject]
        public var appCurrentStateSignal:AppCurrentStateSignal;

        [Inject]
        public var displayLoginForm:DisplayLoginFormSignal;

        [Inject]
        public var displaySubredditsSignal:DisplaySubredditsSignal;

        [Inject]
        public var displayUserInfoSignal:DisplayUserInfoSignal;

        [Inject]
        public var hidePopupMenuSignal:HidePopupMenuSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function MenuMediator()
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

            view.loginBtnClickSignal.add(onLoginBtnClicked);
            view.logoutBtnClickSignal.add(onLogoutBtnClicked);
            view.refreshBtnClickSignal.add(onRefreshBtnClicked);

            view.subredditsBtnClickSignal.add(onSubredditsBtnClicked);
            view.accountBtnClickSignal.add(onAccountBtnClicked);
            view.settingsBtnClickSignal.add(onSettingsBtnClicked);

            view.closePopupBtnClickSignal.add(onClosePopupBtnClicked);

            appCurrentStateSignal.add(onAppCurrentStateSignal);
        }

        /** methods **/
        private function onLoginBtnClicked():void
        {
            displayLoginForm.dispatch(true);
            hidePopupMenu();
        }

        private function onLogoutBtnClicked():void
        {
            logoutSignal.dispatch();
            hidePopupMenu();
        }

        private function onRefreshBtnClicked():void
        {
            manualRefreshSignal.dispatch();
            hidePopupMenu();
        }

        private function onSubredditsBtnClicked():void
        {
            displaySubredditsSignal.dispatch(true);
            hidePopupMenu();
        }

        private function onAccountBtnClicked():void
        {
            displayUserInfoSignal.dispatch(true);
            hidePopupMenu();
        }

        private function onSettingsBtnClicked():void
        {
            // TODO
        }

        private function hidePopupMenu():void
        {
            if (view.currentState.indexOf(ApplicationConstants.VIEW_STATE_PORTRAIT) > -1)
            {
                hidePopupMenuSignal.dispatch();
            }
        }

        private function onClosePopupBtnClicked():void
        {
            hidePopupMenuSignal.dispatch();
        }

        /**
         * Handle view state (portrait/landscape) or app state changes (logged in/logged out)
         * @param state
         */
        private function onAppCurrentStateSignal(state:String):void
        {
            logger.debug(": onAppCurrentStateSignal - state: " + state);

            view.currentState = state;
        }
    }
}
