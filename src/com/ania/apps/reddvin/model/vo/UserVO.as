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
     * Defines the <code>UserVO<code> Value Object implementation
     *
     */
    [Bindable]
    public class UserVO
    {
        public function UserVO()
        {
        }

        public var username:String;
        public var password:String;
        public var rememberMe:Boolean;

        public var has_mail:Boolean;
        public var link_karma:int;
        public var comment_karma:int;
        public var is_gold:Boolean;
        public var is_mod:Boolean;
        public var has_mod_mail:Boolean;
    }
}
