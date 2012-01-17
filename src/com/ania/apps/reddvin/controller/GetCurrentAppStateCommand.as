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
    import com.ania.apps.reddvin.signals.signaltons.AppCurrentStateSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.SignalCommand;

    public final class GetCurrentAppStateCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var saveState:Boolean;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var appCurrentStateSignal:AppCurrentStateSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function GetCurrentAppStateCommand()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * Method handle the logic for <code>GetCurrentStateCommand</code>
         */        
        override public function execute():void    
        {
            logger.debug(": execute");

            if (saveState)
            {
                logger.debug(": saving new app state");

                if (!redditModel.loggedIn)
                {
                    redditModel.appState = ApplicationConstants.APP_STATE_LOGGED_OUT;
                }
                else
                {
                    redditModel.appState = ApplicationConstants.APP_STATE_LOGGED_IN;
                }
            }

            logger.debug(": loggedIn - " + redditModel.loggedIn + ", viewState - " + redditModel.viewState +", appState - " + redditModel.appState);

            appCurrentStateSignal.dispatch(redditModel.viewState, redditModel.appState);
        }
    }
}
