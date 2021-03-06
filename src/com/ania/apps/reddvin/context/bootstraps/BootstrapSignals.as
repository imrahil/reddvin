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
    import com.ania.apps.reddvin.controller.fetchdata.*;
    import com.ania.apps.reddvin.signals.*;

    import org.robotlegs.core.ISignalCommandMap;

    public class BootstrapSignals
    {
        public function BootstrapSignals(signalCommandMap:ISignalCommandMap)
        {
            signalCommandMap.mapSignalClass(StartupSignal, StartupCommand);

            // request signals
            signalCommandMap.mapSignalClass(SetCurrentViewStateSignal, SetCurrentViewStateCommand);
            signalCommandMap.mapSignalClass(GetCurrentAppStateSignal, GetCurrentAppStateCommand);

            signalCommandMap.mapSignalClass(RefreshSignal, RefreshCommand);
            signalCommandMap.mapSignalClass(ManualRefreshSignal, ManualRefreshCommand);
            signalCommandMap.mapSignalClass(ChangeSortSignal, ChangeSortCommand);
            signalCommandMap.mapSignalClass(ChangeScreenSignal, ChangeScreenCommand);
//
            signalCommandMap.mapSignalClass(ChangeSectionSignal, ChangeSectionCommand);
            signalCommandMap.mapSignalClass(GetItemSignal, GetItemCommand);

            signalCommandMap.mapSignalClass(GetUserInfoSignal, GetUserInfoCommand);
            signalCommandMap.mapSignalClass(GetUserSubredditsSignal, GetUserSubredditsCommand);

            signalCommandMap.mapSignalClass(LoginSignal, LoginCommand);
            signalCommandMap.mapSignalClass(LogoutSignal, LogoutCommand);
//            signalCommandMap.mapSignalClass(VoteSignal, VoteCommand);

            // response signals
            signalCommandMap.mapSignalClass(SectionLoadedSignal, SectionLoadedCommand);
            signalCommandMap.mapSignalClass(ItemLoadedSignal, ItemLoadedCommand);
            signalCommandMap.mapSignalClass(SubredditsLoadedSignal, SubredditsLoadedCommand);

            signalCommandMap.mapSignalClass(LoginSuccessfulSignal, LoginSuccessfulCommand);

        }
    }
}
