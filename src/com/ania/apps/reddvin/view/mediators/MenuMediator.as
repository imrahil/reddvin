/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.view.mediators
{
	import com.ania.apps.reddvin.signals.LogoutSignal;
	import com.ania.apps.reddvin.signals.RefreshSignal;
	import com.ania.apps.reddvin.signals.signaltons.DisplayLoginForm;
	import com.ania.apps.reddvin.signals.signaltons.HidePopupMenuSignal;
	import com.ania.apps.reddvin.signals.signaltons.LoginStatusSignal;
	import com.ania.apps.reddvin.signals.signaltons.ResizeSignal;
	import com.ania.apps.reddvin.utils.LogUtil;
	import com.ania.apps.reddvin.view.MenuView;
	
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.Mediator;

	public class MenuMediator extends Mediator
	{
		/**
		 * VIEW
		 */
		[Inject]
		public var view:MenuView;		
		
		/**
		 * SIGNAL -> COMMAND
		 */ 
		[Inject]
		public var logoutSignal:LogoutSignal;
		
		[Inject]
		public var refreshSignal:RefreshSignal;        

		/**
		 * SIGNALTONS
		 */
		[Inject]
		public var resizeSignal:ResizeSignal;

		[Inject]
		public var loginStatusSignal:LoginStatusSignal;

		[Inject]
		public var displayLoginForm:DisplayLoginForm;

		[Inject]
		public var hidePopupMenuSignal:HidePopupMenuSignal;

		/** variables **/
		private var logger:ILogger;
		private var _loggedIn:Boolean;
		private var _state:String;
		
		/** 
		 * CONSTRUCTOR 
		 */		
		public function MenuMediator()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}
		
		/** 
		 * onRegister 
		 * Override the invoked of the <code>IMediator</code> and allow you to place your own initialization. 
		 */		
		override public function onRegister():void
		{
			logger.debug(": onRegister");

			view.loginBtnClickSignal.add(onLoginBtnClicked);
			view.logoutBtnClickSignal.add(onLogoutBtnClicked);
			view.refreshBtnClickSignal.add(onRefreshBtnClicked);

			view.closePopupBtnClickSignal.add(onClosePopupBtnClicked);

			resizeSignal.add(onAppResize);
			loginStatusSignal.add(onLoginStatusChange);
		}
		
		/** methods **/		
		private function onLoginBtnClicked():void
		{
			displayLoginForm.dispatch(true);
			
			if (view.currentState.indexOf("portrait") > -1)
			{
				hidePopupMenuSignal.dispatch();
			}
		}
		
		private function onLogoutBtnClicked():void
		{
			logoutSignal.dispatch();

			if (view.currentState.indexOf("portrait") > -1)
			{
				hidePopupMenuSignal.dispatch();
			}
		}
		
		private function onRefreshBtnClicked():void
		{
			refreshSignal.dispatch();

			if (view.currentState.indexOf("portrait") > -1)
			{
				hidePopupMenuSignal.dispatch();
			}
		}
		
		private function onClosePopupBtnClicked():void
		{
			hidePopupMenuSignal.dispatch();
		}
		
		private function onAppResize(state:String):void
		{
			logger.debug(": onAppResize - state: " + state);

			_state = state;
			checkStatusOrientation();
		}

		private function onLoginStatusChange(status:Boolean):void
		{
			logger.debug(": onLoginStatusChange - status: " + status);

			_loggedIn = status;
			checkStatusOrientation();
		}
		
		private function checkStatusOrientation():void
		{
			if (_state == "portrait")
			{
				if (!_loggedIn)
					view.currentState = "portraitLoggedOut";
				else
					view.currentState = "portraitLoggedIn";
			}
			else
			{
				if (!_loggedIn)
					view.currentState = "landscapeLoggedOut";
				else
					view.currentState = "landscapeLoggedIn";
			}
		}
	}
}