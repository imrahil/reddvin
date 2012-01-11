/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.controller
{
    import com.ania.apps.reddvin.constants.ApplicationConstants;
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.model.vo.SessionVO;
    import com.ania.apps.reddvin.signals.signaltons.DisplayLoginForm;
    import com.ania.apps.reddvin.signals.signaltons.LoginStatusSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import flash.net.SharedObject;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.SignalCommand;

    public final class LoginSuccessfulCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var sessionVO:SessionVO;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var loginStatusSignal:LoginStatusSignal;

        [Inject]
        public var displayLoginForm:DisplayLoginForm;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function LoginSuccessfulCommand()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * Method handle the logic for <code>LoginSuccessfulCommand</code>
         */
        override public function execute():void
        {
            logger.debug(": execute");

            redditModel.session = sessionVO;
            redditModel.loggedIn = true;

            if (sessionVO.userVO.rememberMe)
            {
                logger.debug(": userVO.rememberMe - true");

                var sessionSO:SharedObject = SharedObject.getLocal(ApplicationConstants.REDDIT_SO_NAME);
                sessionSO.data.cookie = sessionVO.cookie;
                sessionSO.flush();
            }

            loginStatusSignal.dispatch(true);
            displayLoginForm.dispatch(false);
        }
    }
}
