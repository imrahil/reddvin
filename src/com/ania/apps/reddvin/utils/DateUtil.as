package com.ania.apps.reddvin.utils
{
	

	public class DateUtil
	{
		public function DateUtil()
		{
		}
		
		public static function convertDateToPast(utcTimeSeconds:Number):String
		{
			var output:String = "";
			
			var currentTime:Number = new Date().getTime() / 1000;
			var diff:Number = Math.floor(currentTime - utcTimeSeconds);
			
			if (diff <= 0)
				return "very recently";
			else if (diff < 60) 
			{
				if (diff == 1)
					return "1 second ago";
				else
					return diff + " seconds ago";
			}
			else if (diff < 3600) 
			{
				if ((diff / 60) == 1)
					return "1 minute ago";
				else
					return Math.floor(diff / 60) + " minutes ago";
			}
			else if (diff < 86400)  // 86400 seconds in a day 
			{
				if ((diff / 3600) == 1)
					return "1 hour ago";
				else
					return Math.floor(diff / 3600) + " hours ago";
			}
			else if (diff < 604800) // 86400 * 7
			{ 
				if ((diff / 86400) == 1)
					return "1 day ago";
				else
					return Math.floor(diff / 86400) + " days ago";
			}
			else if (diff < 2592000) // 86400 * 30
			{ 
				if ((diff / 604800) == 1)
					return "1 week ago";
				else
					return Math.floor(diff / 604800) + " weeks ago";
			}
			else if (diff < 31536000) // 86400 * 365 
			{ 
				if ((diff / 2592000) == 1)
					return "1 month ago";
				else
					return Math.floor(diff / 2592000) + " months ago";
			}
			else 
			{
				if ((diff / 31536000) == 1)
					return "1 year ago";
				else
					return Math.floor(diff / 31536000) + " years ago";
			}
		}
	}
}