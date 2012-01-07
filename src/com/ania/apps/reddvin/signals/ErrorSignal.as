/*
Copyright (c) 2011 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.signals
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