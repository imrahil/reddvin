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
     * Defines the <code>SessionVO<code> Value Object implementation
     *
     */
    [Bindable]
    public class SessionVO
    {
        public function SessionVO()
        {
        }

        public var userVO:UserVO;
        public var cookie:String;
    }
}
