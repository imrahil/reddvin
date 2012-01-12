/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.signals.signaltons
{
    import org.osflash.signals.Signal;

    public class DisplayLoginFormSignal extends Signal
    {
        public function DisplayLoginFormSignal()
        {
            super(Boolean);
        }
    }
}