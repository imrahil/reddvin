/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.context.bootstraps
{
    import com.ania.apps.reddvin.services.*;
    import com.ania.apps.reddvin.services.helpers.ISearchResultParser;
    import com.ania.apps.reddvin.services.helpers.RedditJSONResultParser;

    import org.robotlegs.core.IInjector;

    public class BootstrapServices
    {
        public function BootstrapServices(injector:IInjector)
        {
            injector.mapSingletonOf(IRedditService, RedditService);
            injector.mapSingletonOf(ISearchResultParser, RedditJSONResultParser);
        }
    }
}
