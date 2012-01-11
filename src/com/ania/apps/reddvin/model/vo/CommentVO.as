/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.model.vo
{
    public class CommentVO extends BaseVO
    {
        public function CommentVO()
        {
            super();
        }

        public var body:String;
        public var body_html:String;
        public var link_id:String;
        public var parent_id:String;
        public var replies:Array;
    }
}
