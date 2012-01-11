/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  dabrowskaanna@wp.pl
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.controller
{
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.signals.signaltons.SectionChangedSignal;

    import mx.collections.ArrayList;

    import org.robotlegs.mvcs.SignalCommand;

    public final class SectionLoadedCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var items:ArrayList;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var sectionChanged:SectionChangedSignal;

        /**
         * Method handle the logic for <code>SectionLoadedCommand</code>
         */
        override public function execute():void
        {
            redditModel.items = items;

            sectionChanged.dispatch(items)
        }
    }
}
