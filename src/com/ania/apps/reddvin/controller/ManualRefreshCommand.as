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
    import com.ania.apps.reddvin.signals.RefreshSignal;

    import org.robotlegs.mvcs.SignalCommand;

    public final class ManualRefreshCommand extends SignalCommand 
    {
        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var refreshSignal:RefreshSignal;

        /**
         * Method handle the logic for <code>ManualRefreshCommand</code>
         */        
        override public function execute():void    
        {
            redditModel.needReload = true;

            refreshSignal.dispatch();
        }
    }
}
