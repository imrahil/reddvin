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
    import com.ania.apps.reddvin.signals.GetCurrentAppStateSignal;
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import flash.net.SharedObject;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.SignalCommand;

    public final class LogoutCommand extends SignalCommand
    {
        /** PARAMETERS **/

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var getCurrentAppStateSignal:GetCurrentAppStateSignal;

        [Inject]
        public var refreshSignal:RefreshSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function LogoutCommand()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * Method handle the logic for <code>LoginCommand</code>
         */
        override public function execute():void
        {
            logger.debug(": execute");

            redditModel.session = null;
            redditModel.loggedIn = false;

            var sessionSO:SharedObject = SharedObject.getLocal(ApplicationConstants.REDDIT_SO_NAME);
            sessionSO.clear();

            getCurrentAppStateSignal.dispatch(true);

            redditModel.needReload = true;
            refreshSignal.dispatch();
        }
    }
}
