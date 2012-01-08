package com.ania.apps.reddvin.signals
{
	import org.osflash.signals.Signal;
	
	import spark.components.Button;
	
	public class DisplayPopupMenuSignal extends Signal
	{
		public function DisplayPopupMenuSignal()
		{
			super(Button);
		}
	}
}