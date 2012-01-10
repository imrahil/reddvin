/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.signals.signaltons
{
	import org.osflash.signals.Signal;
	
	public class ErrorSignal extends Signal
	{
		public function ErrorSignal()
		{
			super(String);
		}
	}
}
