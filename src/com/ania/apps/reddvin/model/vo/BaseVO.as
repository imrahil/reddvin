/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.model.vo
{
    public class BaseVO
    {
        public function BaseVO()
        {
        }

        public var kind:String;
        public var modhash:String;

        public var author:String;
        public var created:String;
        public var created_utc:String;
        public var created_string:String;
        public var downs:int;
        public var id:String;
        public var levenshtein:String; 	//
        public var likes:int = -1;
        public var name:String;
        public var subreddit:String;
        public var subreddit_id:String;
        public var ups:int;
    }
}
