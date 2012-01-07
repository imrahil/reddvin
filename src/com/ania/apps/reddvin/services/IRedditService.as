/*
Copyright (c) 2011 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.services
{
	import com.ania.apps.reddvin.model.vo.UserVO;
	import com.ania.apps.reddvin.model.vo.VoteVO;
	import com.ania.apps.reddvin.services.helpers.ISearchResultParser;

	public interface IRedditService
	{
		function getSection(path:String = "", cookie:String = ""):void;
		function getReddit(id:String, cookie:String = ""):void;
		
		function login(userVO:UserVO):void;

		function vote(vote:VoteVO, cookie:String):void;
		
		function set parser(value:ISearchResultParser):void; 
	}
}