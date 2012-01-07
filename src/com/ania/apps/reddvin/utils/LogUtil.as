package com.ania.apps.reddvin.utils
{
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class LogUtil
	{
		public function LogUtil()
		{
		}
		
		/**
		 * Get a logger for
		 */
		public static function getLogger(obj:Object):ILogger
		{
			return Log.getLogger(getQualifiedClassName(obj).replace("::", "."));
		}
	}
}