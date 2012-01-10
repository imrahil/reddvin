/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.signals
{
	import com.ania.apps.reddvin.model.vo.SessionVO;
	
	import org.osflash.signals.Signal;
	
	public class LoginSuccessfulSignal extends Signal
	{
		public function LoginSuccessfulSignal()
		{
			super(SessionVO);
		}
	}
}
