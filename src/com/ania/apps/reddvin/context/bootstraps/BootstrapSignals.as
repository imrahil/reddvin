/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.context.bootstraps
{
    import com.ania.apps.reddvin.controller.*;
    import com.ania.apps.reddvin.signals.*;

    import org.robotlegs.core.ISignalCommandMap;

    public class BootstrapSignals
    {
        public function BootstrapSignals(signalCommandMap:ISignalCommandMap)
        {
            signalCommandMap.mapSignalClass(StartupSignal, StartupCommand);

            // request signals
            signalCommandMap.mapSignalClass(RefreshSignal, RefreshCommand);
            signalCommandMap.mapSignalClass(ChangeSortSignal, ChangeSortCommand);
            signalCommandMap.mapSignalClass(ChangeScreenSignal, ChangeScreenCommand);
//
            signalCommandMap.mapSignalClass(GetSectionSignal, GetSectionCommand);
            signalCommandMap.mapSignalClass(GetItemSignal, GetItemCommand);
            signalCommandMap.mapSignalClass(LoginSignal, LoginCommand);
            signalCommandMap.mapSignalClass(LogoutSignal, LogoutCommand);
//            signalCommandMap.mapSignalClass(VoteSignal, VoteCommand);

            // response signals
            signalCommandMap.mapSignalClass(SectionLoadedSignal, SectionLoadedCommand);
            signalCommandMap.mapSignalClass(ItemLoadedSignal, ItemLoadedCommand);

            signalCommandMap.mapSignalClass(LoginSuccessfulSignal, LoginSuccessfulCommand);

        }
    }
}
