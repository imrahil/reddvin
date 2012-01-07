/*
Copyright (c) 2011 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/

package com.ania.apps.reddvin.controller 
{
	import com.ania.apps.reddvin.model.RedditModel;
	import com.ania.apps.reddvin.services.IRedditService;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public final class GetSectionCommand extends SignalCommand 
	{
		/** PARAMETERS **/
		[Inject]
		public var sectionName:String;
		
		/** INJECTIONS **/
		[Inject]
		public var redditModel:RedditModel;

		[Inject]
		public var redditService:IRedditService;
		
		/**
		 * Method handle the logic for <code>GetSectionCommand</code>
		 */        
		override public function execute():void    
		{
			redditModel.selectedSubreddit = sectionName;
			
			if (redditModel.session && redditModel.session.cookie && redditModel.session.cookie != "")
			{
				redditService.getSection(sectionName, redditModel.session.cookie);
			}
			else
			{
				redditService.getSection(sectionName);
			}
		}
	}
}
