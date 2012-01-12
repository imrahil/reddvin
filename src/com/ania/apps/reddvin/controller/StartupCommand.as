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
    import com.ania.apps.reddvin.signals.GetUserInfoSignal;
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayActivityIndicatorSignal;
    import com.ania.apps.reddvin.signals.signaltons.LoginStatusSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import flash.net.SharedObject;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.SignalCommand;

    public final class StartupCommand extends SignalCommand
    {
        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var displayActivityIndicator:DisplayActivityIndicatorSignal;

        [Inject]
        public var getUserInfoSignal:GetUserInfoSignal;

        [Inject]
        public var loginStatusSignal:LoginStatusSignal;

        [Inject]
        public var refreshSignal:RefreshSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function StartupCommand()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * Method handle the logic for <code>StartupCommand</code>
         */
        override public function execute():void
        {
            logger.debug(": execute");

            var sessionSO:SharedObject = SharedObject.getLocal(ApplicationConstants.REDDIT_SO_NAME);

            if (sessionSO.data.cookie != undefined)
            {
                logger.debug(": SharedObject exist");

                redditModel.session = new SessionVO();
                redditModel.session.cookie = String(sessionSO.data.cookie);

                redditModel.loggedIn = true;

                // dispatch GetUserInfoSignal to retrieve user's details
                getUserInfoSignal.dispatch();

                loginStatusSignal.dispatch(true);
            }
            else
            {
                logger.debug(": logged out");

                redditModel.loggedIn = false;

                loginStatusSignal.dispatch(false);
            }

            redditModel.initialized = true;
            refreshSignal.dispatch();
        }
    }
}
