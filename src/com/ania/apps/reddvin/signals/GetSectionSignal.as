/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.signals
{
	import org.osflash.signals.Signal;
	
	public class GetSectionSignal extends Signal
	{
		public function GetSectionSignal()
		{
			super(String);
		}
	}
}