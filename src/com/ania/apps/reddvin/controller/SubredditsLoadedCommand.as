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
    import com.ania.apps.reddvin.signals.signaltons.SubredditsChangedSignal;

    import mx.collections.ArrayList;

    import org.robotlegs.mvcs.SignalCommand;

    public final class SubredditsLoadedCommand extends SignalCommand 
    {
        /** PARAMETERS **/
        [Inject]
        public var items:ArrayList;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var subredditsChanged:SubredditsChangedSignal;

        /**
         * Method handle the logic for <code>SubredditsLoadedCommand</code>
         */        
        override public function execute():void    
        {
            redditModel.subredditsList = items;

            subredditsChanged.dispatch(items)
        }
    }
}
