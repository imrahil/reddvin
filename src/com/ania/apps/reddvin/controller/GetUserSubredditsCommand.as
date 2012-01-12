/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.controller 
{
    import com.ania.apps.reddvin.services.IRedditService;

    import org.robotlegs.mvcs.SignalCommand;

    public final class GetUserSubredditsCommand extends SignalCommand 
    {
        /** INJECTIONS **/
        [Inject]
        public var redditService:IRedditService;

        /**
         * Method handle the logic for <code>GetUserSubredditsCommand</code>
         */        
        override public function execute():void    
        {
            redditService.getUserSubreddits();
        }
    }
}
