/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.context.bootstraps
{
    import com.ania.apps.reddvin.view.*;
    import com.ania.apps.reddvin.view.mediators.*;

    import org.robotlegs.core.IMediatorMap;

    public class BootstrapViewMediators extends Object
    {
        public function BootstrapViewMediators(mediatorMap:IMediatorMap)
        {
            mediatorMap.mapView(Reddvin, ReddvinMediator);
            mediatorMap.mapView(MainView, MainViewMediator);
            mediatorMap.mapView(MenuView, MenuMediator);
            mediatorMap.mapView(SectionView, SectionMediator);

            mediatorMap.mapView(LoginForm, LoginFormMediator);
            mediatorMap.mapView(BrowserView, BrowserViewMediator);
            mediatorMap.mapView(UserInfoView, UserInfoMediator);
            mediatorMap.mapView(SubredditsView, SubredditsMediator);

//            mediatorMap.mapView(SingleItemView, SingleItemMediator);
        }
    }
}
