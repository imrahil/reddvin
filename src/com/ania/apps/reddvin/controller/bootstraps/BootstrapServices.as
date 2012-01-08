package com.ania.apps.reddvin.controller.bootstraps
{
	import com.ania.apps.reddvin.services.*;
	import com.ania.apps.reddvin.services.helpers.ISearchResultParser;
	import com.ania.apps.reddvin.services.helpers.RedditJSONResultParser;
	
	import org.robotlegs.core.IInjector;

	public class BootstrapServices
	{
		public function BootstrapServices(injector:IInjector)
		{
			injector.mapSingletonOf(IRedditService, RedditServiceMock);
			injector.mapSingletonOf(ISearchResultParser, RedditJSONResultParser);
		}
	}
}