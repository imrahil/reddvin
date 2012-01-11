/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.model.vo
{
    [Bindable]
    /**
     *
     * Defines the <code>RedditVO<code> Value Object implementation
     *
     */
    public class RedditVO extends BaseVO
    {
        public function RedditVO()
        {
            super();
        }

        public var clicked:Boolean;
        public var domain:String;
        public var hidden:Boolean;
        public var is_self:Boolean;
        public var media:*;				//
        public var media_embed:*;		//
        public var num_comments:int;
        public var over_18:Boolean;
        public var permalink:String;
        public var saved:Boolean;
        public var score:int;
        public var selftext:String;
        public var selftext_html:String;
        public var thumbnail:String;
        public var title:String;
        public var url:String;

        public var comments:Array;
    }
}
