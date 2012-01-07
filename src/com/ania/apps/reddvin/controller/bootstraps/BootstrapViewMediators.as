package com.ania.apps.reddvin.controller.bootstraps
{
	import com.ania.apps.reddvin.view.SectionView;
	import com.ania.apps.reddvin.view.mediators.SectionMediator;
	
	import org.robotlegs.core.IMediatorMap;

	public class BootstrapViewMediators extends Object
	{
		public function BootstrapViewMediators(mediatorMap:IMediatorMap)
		{
//            mediatorMap.mapView(MainAppNavigator, MainAppNavigatorMediator);
			mediatorMap.mapView(SectionView, SectionMediator);
//            mediatorMap.mapView(SingleItemView, SingleItemMediator);
//            mediatorMap.mapView(TopMenu, TopMenuMediator);
		}
	}
}