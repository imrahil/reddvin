/*
Copyright (c) 2011 Anna Dabrowska, All Rights Reserved 
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
     * Defines the <code>SessionVO<code> Value Object implementation
     *
     */
	public class SessionVO
	{
		public function SessionVO() 
		{
		}
		
		public var userVO:UserVO;
		public var cookie:String;
	}
}