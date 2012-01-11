/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.controller
{
    import com.ania.apps.reddvin.model.RedditModel;

    import org.robotlegs.mvcs.SignalCommand;

    public final class ChangeScreenCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var currentScreen:String;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        /**
         * Method handle the logic for <code>ChangeScreenCommand</code>
         */
        override public function execute():void
        {
            redditModel.currentScreen = currentScreen;
        }
    }
}
