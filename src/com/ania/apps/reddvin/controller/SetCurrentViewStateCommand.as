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
    import com.ania.apps.reddvin.signals.signaltons.AppCurrentStateSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.SignalCommand;

    public class SetCurrentViewStateCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var aspectRatio:String;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var getCurrentAppStateSignal:GetCurrentAppStateSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function SetCurrentViewStateCommand()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * Method handle the logic for <code>SetCurrentStateCommand</code>
         */
        override public function execute():void
        {
            logger.debug(": execute");

            if (aspectRatio == ApplicationConstants.VIEW_STATE_PORTRAIT)
            {
                redditModel.viewState = ApplicationConstants.VIEW_STATE_PORTRAIT;
            }
            else
            {
                redditModel.viewState = ApplicationConstants.VIEW_STATE_LANDSCAPE;
            }

            logger.debug(": viewState - " + redditModel.viewState);

            getCurrentAppStateSignal.dispatch(true);
        }
    }
}
