/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.context
{

    import com.ania.apps.reddvin.context.bootstraps.*;
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.view.MainView;

    import flash.display.DisplayObjectContainer;

    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IMediatorMap;
    import org.robotlegs.mvcs.SignalContext;

    import spark.components.SkinnableContainer;

    public class ReddvinContext extends SignalContext
    {
        public function ReddvinContext(contextView:DisplayObjectContainer = null)
        {
            super(contextView);
        }

        /**
         *  The Startup Hook
         */
        override public function startup():void
        {
            // Add Commands
            new BootstrapSignals(signalCommandMap);

            // Add Model
            injector.mapSingleton(RedditModel);

            // Add Services
            new BootstrapServices(injector as IInjector);

            // Add Singleton
            new BootstrapSignaltons(injector as IInjector);

            // Add View + View Mediators
            new BootstrapViewMediators(mediatorMap as IMediatorMap);

            var mainView:MainView = new MainView();
            (contextView as SkinnableContainer).addElement(mainView);

            super.startup();
        }
    }
}
