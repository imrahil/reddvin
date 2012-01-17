/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.signals
{
    import org.osflash.signals.Signal;

    public class GetCurrentAppStateSignal extends Signal
    {
        public function GetCurrentAppStateSignal()
        {
            super(Boolean);
        }
    }
}
