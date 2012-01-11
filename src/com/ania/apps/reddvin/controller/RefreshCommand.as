/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/

package com.ania.apps.reddvin.controller 
{
	import com.ania.apps.reddvin.constants.ApplicationConstants;
	import com.ania.apps.reddvin.model.RedditModel;
	import com.ania.apps.reddvin.services.IRedditService;
	import com.ania.apps.reddvin.signals.signaltons.DisplayActivityIndicatorSignal;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public final class RefreshCommand extends SignalCommand 
	{
		/** PARAMETERS **/
		
		/** INJECTIONS **/
		[Inject]
		public var redditModel:RedditModel;
		
		[Inject]
		public var redditService:IRedditService;

		[Inject]
		public var displayActivityIndicator:DisplayActivityIndicatorSignal;        

		/** variables **/
		private var logger:ILogger;

		/** 
		 * CONSTRUCTOR 
		 */		
		public function RefreshCommand()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}

		/**
		 * Method handle the logic for <code>RefreshCommand</code>
		 */        
		override public function execute():void    
		{
			logger.debug(": execute");
	
			if (redditModel.initialized)
			{
				displayActivityIndicator.dispatch(true);
	
				switch (redditModel.currentScreen)
				{
					case ApplicationConstants.SECTION_VIEW:
						updateSection();
					break;
					
					case ApplicationConstants.ITEM_VIEW:
						updateItem();
						updateSection();
					break;
				}
			}
		}
		
		private function updateSection():void
		{
			if (redditModel.loggedIn)
			{
				redditService.getSection(redditModel.selectedSubreddit, redditModel.sortOrder, redditModel.session.cookie);
			}
			else
			{
				redditService.getSection(redditModel.selectedSubreddit, redditModel.sortOrder);
			}
		}
		
		private function updateItem():void
		{
			if (redditModel.item)
			{
				if (redditModel.loggedIn)
				{
					redditService.getReddit(redditModel.item.id, redditModel.session.cookie);
				}
				else
				{
					redditService.getReddit(redditModel.item.id);
				}
			}
		}
	}
}