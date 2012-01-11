/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.signals.signaltons
{
    import mx.collections.ArrayList;

    import org.osflash.signals.Signal;

    public class SectionChangedSignal extends Signal
    {
        public function SectionChangedSignal()
        {
            super(ArrayList);
        }
    }
}
