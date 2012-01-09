/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.view.mediators
{
	import com.ania.apps.reddvin.signals.StartupSignal;
	import com.ania.apps.reddvin.signals.signaltons.DisplayLoginForm;
	import com.ania.apps.reddvin.signals.signaltons.DisplayPopupMenuSignal;
	import com.ania.apps.reddvin.signals.signaltons.HidePopupMenuSignal;
	import com.ania.apps.reddvin.utils.LogUtil;
	import com.ania.apps.reddvin.view.LoginForm;
	import com.ania.apps.reddvin.view.MainView;
	
	import mx.events.FlexEvent;
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.Button;
	
	public class MainViewMediator extends Mediator
	{
		/**
		 * VIEW
		 */
		[Inject]
		public var view:MainView;		

		/**
		 * SIGNALTONS
		 */
		[Inject]
		public var displayPopupMenuSignal:DisplayPopupMenuSignal;
		
		[Inject]
		public var hidePopupMenuSignal:HidePopupMenuSignal;
		
		[Inject]
		public var displayLoginForm:DisplayLoginForm;
		
		[Inject]
		public var startupSignal:StartupSignal;
		
		/** variables **/
		private var logger:ILogger;

		/** 
		 * CONSTRUCTOR 
		 */		
		public function MainViewMediator()
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
			
			displayPopupMenuSignal.add(displayPopupMenu);
			hidePopupMenuSignal.add(hidePopupMenu);
			
			displayLoginForm.add(onDisplayLoginForm);
	
			startupSignal.dispatch();
		}			
		
		/** methods **/		
		private function displayPopupMenu(owner:Button):void
		{
			view.showFirstViewNavigatorInPopUp(owner);
		}
		
		private function hidePopupMenu():void
		{
			view.hideViewNavigatorPopUp();
		}
		
		private function onDisplayLoginForm(show:Boolean):void
		{
			if (show)
			{
				view.contentNavigator.pushView(LoginForm);
			}
			else
			{
				view.contentNavigator.popView();
			}
		}
	}
}