/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.signals
{
    import com.ania.apps.reddvin.model.vo.RedditVO;

    import org.osflash.signals.Signal;

    public class GetItemSignal extends Signal
    {
        public function GetItemSignal()
        {
            super(RedditVO);
        }
    }
}
