/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.context.bootstraps
{
	import com.ania.apps.reddvin.signals.signaltons.*;
	
	import org.robotlegs.core.IInjector;

	public class BootstrapSignaltons extends Object
	{
		public function BootstrapSignaltons(injector:IInjector)
		{
			injector.mapSingleton(ErrorSignal);
            injector.mapSingleton(LoginStatusSignal);
			
			injector.mapSingleton(SectionChangedSignal);

			injector.mapSingleton(DisplayItemSignal);
            injector.mapSingleton(DisplayActivityIndicatorSignal);
            injector.mapSingleton(DisplayLoginForm);
            injector.mapSingleton(DisplayUrlSignal);
			
			injector.mapSingleton(DisplayPopupMenuSignal);
			injector.mapSingleton(HidePopupMenuSignal);
			injector.mapSingleton(ResizeSignal);
		}
	}
}
