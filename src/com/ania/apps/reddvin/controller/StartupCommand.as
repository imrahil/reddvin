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
	import com.ania.apps.reddvin.model.vo.SessionVO;
	import com.ania.apps.reddvin.signals.GetSectionSignal;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import flash.net.SharedObject;
	
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public final class StartupCommand extends SignalCommand 
	{
		/** PARAMETERS **/
		
		/** INJECTIONS **/
		[Inject]
		public var redditModel:RedditModel;

		[Inject]
		public var getSectionSignal:GetSectionSignal;        
		
//		[Inject]
//		public var displayActivityIndicator:DisplayActivityIndicatorSignal;        
	
		/** variables **/
		private var logger:ILogger;
		
		/** 
		 * CONSTRUCTOR 
		 */		
		public function StartupCommand()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}

		/**
		 * Method handle the logic for <code>StartupCommand</code>
		 */        
		override public function execute():void    
		{
			logger.debug(": execute");

			var sessionSO:SharedObject = SharedObject.getLocal(ApplicationConstants.REDDIT_SO_NAME);
			
			if (sessionSO.data.cookie != undefined)
			{
				logger.debug(": SharedObject exist");

				redditModel.session = new SessionVO();
				redditModel.session.cookie = String(sessionSO.data.cookie);
				
//				displayActivityIndicator.dispatch(true);
				getSectionSignal.dispatch(redditModel.selectedSubreddit);
			}
			else
			{
				logger.debug(": logged out");

//				displayActivityIndicator.dispatch(true);
				getSectionSignal.dispatch(redditModel.selectedSubreddit);
			}
		}
	}
}
