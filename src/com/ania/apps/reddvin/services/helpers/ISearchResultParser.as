/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.services.helpers
{
	import com.ania.apps.reddvin.model.vo.RedditVO;
	
	import mx.collections.ArrayList;

	public interface ISearchResultParser
	{
		function parseSearchResults(results:Object):ArrayList; 
		function parseSingleItem(results:Object):RedditVO; 
		function checkLoginResult(result:String):String; 
	}
}