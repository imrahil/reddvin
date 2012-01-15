/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.controller.fetchdata
{
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.signals.signaltons.DisplaySectionSignal;

    import org.robotlegs.mvcs.SignalCommand;

    public final class ChangeSectionCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var sectionName:String;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var displaySectionSignal:DisplaySectionSignal;

        /**
         * Method handle the logic for <code>GetSectionCommand</code>
         */
        override public function execute():void
        {
            redditModel.selectedSubreddit = sectionName;
            redditModel.needReload = true;

            displaySectionSignal.dispatch()
        }
    }
}
