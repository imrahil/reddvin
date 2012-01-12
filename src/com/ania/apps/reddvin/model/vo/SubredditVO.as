/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.model.vo
{
    /**
     *
     * Defines the <code>SubredditVO<code> Value Object implementation
     *
     */
    [Bindable]
    public class SubredditVO
    {
        public function SubredditVO() 
        {
        }

        public var display_name:String;
        public var name:String;
        public var title:String;
        public var url:String;
        public var created:String;
        public var created_utc:String;
        public var over18:Boolean;
        public var subscribers:int;
        public var description:String;
    }
}
