/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
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
        function login(userVO:UserVO):void;

        function getSection(path:String = "", sortOrder:String = "", cookie:String = ""):void;

        function getReddit(id:String, cookie:String = ""):void;


        function getUserInfo():void;

        function getUserSubreddits():void;

        function vote(vote:VoteVO, cookie:String):void;


        // inject
        function set parser(value:ISearchResultParser):void;
    }
}
