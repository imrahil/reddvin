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
            if (!redditModel.loggedIn)
            {
                if (redditModel.viewState == ApplicationConstants.VIEW_STATE_PORTRAIT)
                    redditModel.appState = "portraitLoggedOut";
                else
                    redditModel.appState = "landscapeLoggedOut";
            }
            else
            {
                if (redditModel.viewState == ApplicationConstants.VIEW_STATE_PORTRAIT)
                    redditModel.appState = "portraitLoggedIn";
                else
                    redditModel.appState = "landscapeLoggedIn";
            }

            logger.debug(": loggedIn - " + redditModel.loggedIn + ", viewState - " + redditModel.viewState +", appState - " + redditModel.appState);

            appCurrentStateSignal.dispatch(redditModel.appState);
        }
    }
}
