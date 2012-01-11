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
    import com.ania.apps.reddvin.model.vo.RedditVO;
    import com.ania.apps.reddvin.services.IRedditService;

    import org.robotlegs.mvcs.SignalCommand;

    public final class GetItemCommand extends SignalCommand
    {
        /** PARAMETERS **/
        [Inject]
        public var selectedItem:RedditVO;

        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var redditService:IRedditService;

        /**
         * Method handle the logic for <code>GetItemCommand</code>
         */
        override public function execute():void
        {
            if (selectedItem)
            {
                if (redditModel.loggedIn)
                {
                    redditService.getReddit(selectedItem.id, redditModel.session.cookie);
                }
                else
                {
                    redditService.getReddit(selectedItem.id);
                }
            }
        }
    }
}
