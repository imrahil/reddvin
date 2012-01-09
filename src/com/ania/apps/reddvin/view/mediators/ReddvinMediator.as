/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.view.mediators
{
	import com.ania.apps.reddvin.signals.signaltons.ResizeSignal;
	
	import mx.events.ResizeEvent;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ReddvinMediator extends Mediator
	{
		/**
		 * VIEW
		 */
		[Inject]
		public var view:Reddvin;	
		
		[Inject]
		public var resizeSignal:ResizeSignal;
		
		public function ReddvinMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addViewListener(ResizeEvent.RESIZE, onResize);

			CONFIG::debugMode
			{
				var logTarget:TraceTarget = new TraceTarget();
				logTarget.level = LogEventLevel.ALL;
				logTarget.includeDate = true;
				logTarget.includeTime = true;
				logTarget.includeCategory = true;
				logTarget.includeLevel = true;
				Log.addTarget(logTarget);
			}
		}
		
		protected function onResize(event:ResizeEvent):void 
		{
			view.currentState = view.aspectRatio;
			
			resizeSignal.dispatch(view.aspectRatio);
		}
	}
}