/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.signals
{
    import com.ania.apps.reddvin.model.vo.RedditVO;

    import org.osflash.signals.Signal;

    public class ItemLoadedSignal extends Signal
	{
		public function ItemLoadedSignal()
		{
			super(RedditVO);
		}
	}
}