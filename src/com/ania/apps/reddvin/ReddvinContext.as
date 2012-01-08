/*
Copyright (c) 2011 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin
{
    
    import com.ania.apps.reddvin.controller.*;
    import com.ania.apps.reddvin.controller.bootstraps.BootstrapServices;
    import com.ania.apps.reddvin.controller.bootstraps.BootstrapSignaltons;
    import com.ania.apps.reddvin.controller.bootstraps.BootstrapViewMediators;
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.services.*;
    import com.ania.apps.reddvin.services.helpers.*;
    import com.ania.apps.reddvin.signals.*;
    import com.ania.apps.reddvin.signals.signaltons.*;
    import com.ania.apps.reddvin.view.SectionView;
    import com.ania.apps.reddvin.view.mediators.SectionMediator;
    
    import flash.display.DisplayObjectContainer;
    
    import org.robotlegs.mvcs.SignalContext;
    
    public class ReddvinContext extends SignalContext
    {
        public function ReddvinContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
        {
            super(contextView, autoStartup);
        }
        
        /**
         *  The Startup Hook
         */		
        override public function startup():void
        {
            // Add Commands
            signalCommandMap.mapSignalClass(StartupSignal, StartupCommand);

//            // request signals
//            signalCommandMap.mapSignalClass(CheckLoginStatusSignal, CheckLoginStatusCommand);
//            signalCommandMap.mapSignalClass(RefreshSignal, RefreshCommand);
//            signalCommandMap.mapSignalClass(ChangeScreenSignal, ChangeScreenCommand);
//
            signalCommandMap.mapSignalClass(GetSectionSignal, GetSectionCommand);
//            signalCommandMap.mapSignalClass(GetItemSignal, GetItemCommand);
//            signalCommandMap.mapSignalClass(LoginSignal, LoginCommand);
//            signalCommandMap.mapSignalClass(LogoutSignal, LogoutCommand);
//            signalCommandMap.mapSignalClass(VoteSignal, VoteCommand);
            
            // response signals
            signalCommandMap.mapSignalClass(SectionLoadedSignal, SectionLoadedCommand);
//            signalCommandMap.mapSignalClass(ItemLoadedSignal, ItemLoadedCommand);
//            signalCommandMap.mapSignalClass(LoginSuccessfulSignal, LoginSuccessfulCommand);
            
          
            // Add Model
            injector.mapSingleton(RedditModel);
            
            // Add Services
			new BootstrapServices(injector); 
            
			// Add Singleton
			new BootstrapSignaltons(injector); 
			
			// Add View + View Mediators
			new BootstrapViewMediators(mediatorMap); 
			
			super.startup(); 
        }
    }
}