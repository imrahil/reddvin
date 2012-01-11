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
    import com.ania.apps.reddvin.signals.signaltons.DisplayItemSignal;

    import org.robotlegs.mvcs.SignalCommand;

    public final class ItemLoadedCommand extends SignalCommand
	{
		/** PARAMETERS **/
		[Inject]
		public var item:RedditVO;
		
		/** INJECTIONS **/
		[Inject]
		public var redditModel:RedditModel;

        [Inject]
        public var displayItem:DisplayItemSignal;

		/**
		 * Method handle the logic for <code>SingleItemLoadedCommand</code>
		 */        
		override public function execute():void    
		{
			redditModel.item = item;	

            displayItem.dispatch(item);
		}
	}
}
