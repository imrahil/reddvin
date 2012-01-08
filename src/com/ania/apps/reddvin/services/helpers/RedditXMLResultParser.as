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
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import mx.logging.ILogger;

	public class RedditXMLResultParser implements ISearchResultParser
	{
		private var logger:ILogger; 
		
		public function RedditXMLResultParser()
		{
			logger = LogUtil.getLogger(this);
			
			logger.debug(": constructor");
		}
		
		public function parseSearchResults(results:Object):Array
		{
			logger.debug(": parseSearchResults");
			
			var data:XML = XML(results);
			
			var output:Array = [];
			
			for each (var item:XML in data.channel.item)
			{
				var redditVO:RedditVO = new RedditVO();
				redditVO.title = item.title;
				redditVO.permalink = item.link;
				
				output.push(redditVO);
			}
			
			return output;
		}
		
		public function parseSingleItem(results:Object):Array
		{
			logger.debug(": parseSingleItem");
			
			return null;
		}
	}
}