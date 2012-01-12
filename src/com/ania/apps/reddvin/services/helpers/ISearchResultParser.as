/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.services.helpers
{
    import com.ania.apps.reddvin.model.vo.RedditVO;
    import com.ania.apps.reddvin.model.vo.UserVO;
    import com.ania.apps.reddvin.model.vo.UserVO;

    import mx.collections.ArrayList;

    public interface ISearchResultParser
    {
        function parseSearchResults(results:String):ArrayList;

        function parseSingleItem(result:String):RedditVO;

        function parseUserDetails(currentUser:UserVO, result:String):void;

        function parseUserSubreddits(results:String):ArrayList;

        function checkLoginResult(result:String):String;
    }
}
