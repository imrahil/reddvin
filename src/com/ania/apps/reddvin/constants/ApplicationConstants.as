/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.constants
{
	import mx.collections.ArrayCollection;

	public class ApplicationConstants
	{
		public static const REDDVIN_APP_VERSION:String 	= "0.3.0"; 

		public static const REDDIT_API_ENDPOINT:String 	= "http://www.reddit.com"; 
		public static const REDDIT_API_EXTENSION:String = ".json"; 
		public static const REDDIT_API_PREFIX:String 	= "t3_"; 
		public static const REDDIT_API_LIMIT:int 		= 50; 

		public static const REDDIT_SO_NAME:String 		= "reddvinSessionData"; 

		public static const SECTION_SCREEN:String 		= "sectionScreen"; 
		public static const ITEM_SCREEN:String 			= "itemScreen"; 

		public static const SORT_FRONT:String			= "what's hot";
		public static const SORT_NEW:String				= "new";
		public static const SORT_CONTROVERSIAL:String	= "controversial";
		public static const SORT_TOP:String				= "top";
		public static const SORT_SAVED:String			= "saved";
		
		public static const SORT_ORDER:ArrayCollection	= new ArrayCollection([
			SORT_FRONT, SORT_NEW, SORT_CONTROVERSIAL, SORT_TOP, SORT_SAVED
		]);
		public function ApplicationConstants()
		{
		}
	}
}