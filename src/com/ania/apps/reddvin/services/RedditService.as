/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.services
{
	import com.ania.apps.reddvin.constants.ApplicationConstants;
	import com.ania.apps.reddvin.model.vo.UserVO;
	import com.ania.apps.reddvin.model.vo.VoteVO;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.core.mx_internal;
	
	public class RedditService extends RedditServiceBase
	{
		/** Constructor */
		public function RedditService()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}

		/**
		 * GET SECTION 
		 */
		override public function getSection(path:String = "", cookie:String = ""):void
		{
			logger.debug(": getSection - path: " + path);
			
			var loader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.userAgent = userAgent;
			urlRequest.manageCookies = false;
		
			var url:String;
			if (path != "")
			{
				url = ApplicationConstants.REDDIT_API_ENDPOINT + "/r/" + path + ApplicationConstants.REDDIT_API_EXTENSION;;
			}
			else
			{
				url = ApplicationConstants.REDDIT_API_ENDPOINT + "/" + path + ApplicationConstants.REDDIT_API_EXTENSION;;
			}

			urlRequest.url = url;

			logger.debug(": url: " + url);

			if (cookie != "")
			{
				logger.debug(": cookie: " + cookie);

				var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", "reddit_session=" + cookie);
				urlRequest.requestHeaders = [cookieHeader];
			}

			loader.addEventListener(Event.COMPLETE, handleSectionLoadComplete);
			addLoaderListeners(loader);
			
			loader.load(urlRequest);
		}

		/**
		 * GET REDDIT 
		 */
		override public function getReddit(id:String, cookie:String = ""):void
		{
//			logger.debug(" : getReddit");
//
//			var loader:URLLoader = new URLLoader();
//			var urlRequest:URLRequest = new URLRequest();
//			urlRequest.userAgent = userAgent;
//			urlRequest.manageCookies = false;
//
//			var url:String = ApplicationConstants.REDDIT_API_ENDPOINT + "/comments/" + id + ApplicationConstants.REDDIT_API_EXTENSION + "?limit=" + ApplicationConstants.REDDIT_API_LIMIT;
//			urlRequest.url = url;
//
//			if (cookie != "")
//			{
//				logger.debug(": cookie: " + cookie);
//
//				var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", "reddit_session=" + cookie);
//				urlRequest.requestHeaders = [cookieHeader];
//			}
//			
//			loader.addEventListener(Event.COMPLETE, handleRedditLoadComplete);
//			addLoaderListeners(loader);
//			
//			loader.load(urlRequest);
		}
		
		/**
		 * LOGIN 
		 */
		override public function login(userVO:UserVO):void
		{
//			logger.debug(" : login - username: " + userVO.username + ", pass: " + userVO.password);
//			
//			loginSuccess = false;
//			this.userVO = userVO;
//			
//			var loader:URLLoader = new URLLoader();
//			var urlRequest:URLRequest = new URLRequest();
//			urlRequest.userAgent = userAgent;
//			urlRequest.manageCookies = false;
//		
//			var url:String = ApplicationConstants.REDDIT_API_ENDPOINT + "/api/login";
//			urlRequest.url = url;
//			urlRequest.method = URLRequestMethod.POST;
//			
//			var variables:URLVariables = new URLVariables();
//			variables.user = userVO.username;
//			variables.passwd = userVO.password;
//			urlRequest.data = variables;
//
//			loader.addEventListener(Event.COMPLETE, handleLoginComplete);
//			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onLoginResponseStatus);
//			addLoaderListeners(loader);
//			
//			loader.load(urlRequest);
		}

		private function onLoginResponseStatus(event:HTTPStatusEvent):void  
		{
			var loader:URLLoader = event.currentTarget as URLLoader;
			
			loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onLoginResponseStatus);
			
			for each (var item:URLRequestHeader in event.responseHeaders) 
			{
				if (item.name == "Set-Cookie")
				{
					loginSuccess = true;
					var rawCookieValue:String = item.value;
					
					cookieValue = rawCookieValue.substring(rawCookieValue.indexOf("=")+1, rawCookieValue.indexOf(";"));
					break;
				}
			}
		}
		
		/**
		 * VOTE 
		 */
		override public function vote(vote:VoteVO, cookie:String):void
		{
//			logger.debug(" : vote - itemId: " + vote.itemId + ", dir: " + vote.direction + ", modhash: " + vote.modhash);
//
//			var loader:URLLoader = new URLLoader();
//			var urlRequest:URLRequest = new URLRequest();
//			urlRequest.userAgent = userAgent;
//			urlRequest.manageCookies = false;
//			
//			var url:String = ApplicationConstants.REDDIT_API_ENDPOINT + "/api/vote";
//			urlRequest.url = url;
//			urlRequest.method = URLRequestMethod.POST;
//			
//			var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", "reddit_session=" + cookie);
//			urlRequest.requestHeaders = [cookieHeader];
//			
//			var variables:URLVariables = new URLVariables();
//			variables.id = vote.itemId;
//			variables.dir = vote.direction;
//			variables.uh = vote.modhash;
//			urlRequest.data = variables;
//			
//			loader.addEventListener(Event.COMPLETE, handleVoteComplete);
//			addLoaderListeners(loader);
//			
//			loader.load(urlRequest);
		}
	}
}