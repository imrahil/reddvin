/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/

package com.ania.apps.reddvin.controller 
{
	import com.ania.apps.reddvin.model.vo.UserVO;
	import com.ania.apps.reddvin.services.IRedditService;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public final class LoginCommand extends SignalCommand 
	{
		/** PARAMETERS **/
		[Inject]
		public var userVO:UserVO;

		/** INJECTIONS **/
		[Inject]
		public var redditService:IRedditService;

		/** variables **/
		private var logger:ILogger;
		
		/** 
		 * CONSTRUCTOR 
		 */		
		public function LoginCommand()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}
		
		/**
		 * Method handle the logic for <code>LoginCommand</code>
		 */        
		override public function execute():void    
		{
			logger.debug(": execute - username: " + userVO.username + ", pass: " + userVO.password);

			redditService.login(userVO);
		}
	}
}