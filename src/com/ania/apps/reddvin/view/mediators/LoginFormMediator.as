/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.model.vo.UserVO;
    import com.ania.apps.reddvin.signals.LoginSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayLoginFormSignal;
    import com.ania.apps.reddvin.utils.LogUtil;
    import com.ania.apps.reddvin.view.LoginForm;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.Mediator;

    public class LoginFormMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:LoginForm;

        /**
         * SIGNAL -> COMMAND
         */
        [Inject]
        public var loginSignal:LoginSignal;

        /**
         * SIGNALTONS
         */
        [Inject]
        public var displayLoginForm:DisplayLoginFormSignal;


        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function LoginFormMediator()
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
            view.cancelBtnClickSignal.add(onCancelBtnClicked);
        }

        private function onLoginBtnClicked():void
        {
            logger.debug(": onLoginBtnClicked");

            var userVO:UserVO = new UserVO();
            userVO.username = view.usernameTxt.text;
            userVO.password = view.passwordTxt.text;
            userVO.rememberMe = view.rememberMeSwitch.selected;

            loginSignal.dispatch(userVO);
        }

        private function onCancelBtnClicked():void
        {
            logger.debug(": onCancelBtnClicked");

            displayLoginForm.dispatch(false);
        }
    }
}
