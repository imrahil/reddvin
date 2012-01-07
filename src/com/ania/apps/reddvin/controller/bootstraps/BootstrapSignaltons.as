package com.ania.apps.reddvin.controller.bootstraps
{
	import com.ania.apps.reddvin.signals.ErrorSignal;
	import com.ania.apps.reddvin.signals.signaltons.DisplayItemSignal;
	import com.ania.apps.reddvin.signals.signaltons.SectionChangedSignal;
	
	import org.robotlegs.core.IInjector;

	public class BootstrapSignaltons extends Object
	{
		public function BootstrapSignaltons(injector:IInjector)
		{
			injector.mapSingleton(ErrorSignal);
//            injector.mapSingleton(LoginStatusSignal);
			injector.mapSingleton(SectionChangedSignal);
//            injector.mapSingleton(ItemChangedSignal);
			injector.mapSingleton(DisplayItemSignal);
//            injector.mapSingleton(DisplayActivityIndicatorSignal);
//            injector.mapSingleton(DisplayUrlSignal);
		}
	}
}
