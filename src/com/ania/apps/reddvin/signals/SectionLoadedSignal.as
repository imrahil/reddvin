/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.signals
{
	import mx.collections.ArrayList;
	
	import org.osflash.signals.Signal;
	
	public class SectionLoadedSignal extends Signal
	{
		public function SectionLoadedSignal()
		{
			super(ArrayList);
		}
	}
}