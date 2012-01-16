/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.context.bootstraps
{
    import com.ania.apps.reddvin.signals.signaltons.*;

    import org.robotlegs.core.IInjector;

    public class BootstrapSignaltons extends Object
    {
        public function BootstrapSignaltons(injector:IInjector)
        {
            injector.mapSingleton(ErrorSignal);

            injector.mapSingleton(SectionChangedSignal);
            injector.mapSingleton(SubredditsChangedSignal);

            injector.mapSingleton(DisplaySectionSignal);
            injector.mapSingleton(DisplayItemSignal);
            injector.mapSingleton(DisplayActivityIndicatorSignal);
            injector.mapSingleton(DisplayLoginFormSignal);
            injector.mapSingleton(DisplayUrlSignal);

            injector.mapSingleton(DisplaySubredditsSignal);
            injector.mapSingleton(DisplayUserInfoSignal);

            injector.mapSingleton(DisplayPopupMenuSignal);
            injector.mapSingleton(HidePopupMenuSignal);
            injector.mapSingleton(AppCurrentStateSignal);
        }
    }
}
