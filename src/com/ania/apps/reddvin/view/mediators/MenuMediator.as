/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.signals.LogoutSignal;
    import com.ania.apps.reddvin.signals.ManualRefreshSignal;
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayLoginFormSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayUserInfoSignal;
    import com.ania.apps.reddvin.signals.signaltons.HidePopupMenuSignal;
    import com.ania.apps.reddvin.signals.signaltons.LoginStatusSignal;
    import com.ania.apps.reddvin.signals.signaltons.ResizeSignal;
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
        public var resizeSignal:ResizeSignal;

        [Inject]
        public var loginStatusSignal:LoginStatusSignal;

        [Inject]
        public var displayLoginForm:DisplayLoginFormSignal;

        [Inject]
        public var displayUserInfoSignal:DisplayUserInfoSignal;

        [Inject]
        public var hidePopupMenuSignal:HidePopupMenuSignal;

        /** variables **/
        private var logger:ILogger;
        private var _loggedIn:Boolean;
        private var _state:String;

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

            view.accountBtnClickSignal.add(onAccountBtnClicked);
            view.settingsBtnClickSignal.add(onSettingsBtnClicked);

            view.closePopupBtnClickSignal.add(onClosePopupBtnClicked);

            resizeSignal.add(onAppResize);
            loginStatusSignal.add(onLoginStatusChange);
        }

        /** methods **/
        private function onLoginBtnClicked():void
        {
            displayLoginForm.dispatch(true);

            if (view.currentState.indexOf("portrait") > -1)
            {
                hidePopupMenuSignal.dispatch();
            }
        }

        private function onLogoutBtnClicked():void
        {
            logoutSignal.dispatch();

            if (view.currentState.indexOf("portrait") > -1)
            {
                hidePopupMenuSignal.dispatch();
            }
        }

        private function onRefreshBtnClicked():void
        {
            manualRefreshSignal.dispatch();

            if (view.currentState.indexOf("portrait") > -1)
            {
                hidePopupMenuSignal.dispatch();
            }
        }

        private function onAccountBtnClicked():void
        {
            displayUserInfoSignal.dispatch(true);
        }

        private function onSettingsBtnClicked():void
        {
            // TODO
        }

        private function onClosePopupBtnClicked():void
        {
            hidePopupMenuSignal.dispatch();
        }

        private function onAppResize(state:String):void
        {
            logger.debug(": onAppResize - state: " + state);

            _state = state;
            checkStatusOrientation();
        }

        private function onLoginStatusChange(status:Boolean):void
        {
            logger.debug(": onLoginStatusChange - status: " + status);

            _loggedIn = status;
            checkStatusOrientation();
        }

        private function checkStatusOrientation():void
        {
            if (_state == "portrait")
            {
                if (!_loggedIn)
                    view.currentState = "portraitLoggedOut";
                else
                    view.currentState = "portraitLoggedIn";
            }
            else
            {
                if (!_loggedIn)
                    view.currentState = "landscapeLoggedOut";
                else
                    view.currentState = "landscapeLoggedIn";
            }
        }
    }
}
