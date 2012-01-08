/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/

package com.ania.apps.reddvin.model.vo
{
    [Bindable]
    /**
     *
     * Defines the <code>UserVO<code> Value Object implementation
     *
     */
	public class UserVO
	{
		public function UserVO() 
		{
		}
		
		public var username:String;
		public var password:String;
		public var rememberMe:Boolean;
	}
}