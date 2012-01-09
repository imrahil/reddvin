/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.view.components
{
	import spark.skins.mobile.ToggleSwitchSkin;
	
	public class MyToggleSwitchSkin extends ToggleSwitchSkin
	{
		public function MyToggleSwitchSkin()
		{
			super();
			
			selectedLabel = "Yes";
			unselectedLabel = "No"; 
		}
	}
}