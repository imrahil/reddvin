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