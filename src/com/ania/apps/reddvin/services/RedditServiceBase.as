/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.services
{
	import com.ania.apps.reddvin.model.vo.RedditVO;
	import com.ania.apps.reddvin.model.vo.SessionVO;
	import com.ania.apps.reddvin.model.vo.UserVO;
	import com.ania.apps.reddvin.model.vo.VoteVO;
	import com.ania.apps.reddvin.services.helpers.ISearchResultParser;
	import com.ania.apps.reddvin.signals.ErrorSignal;
	import com.ania.apps.reddvin.signals.SectionLoadedSignal;
	
	import flash.desktop.NativeApplication;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.Actor;
	
	public class RedditServiceBase extends Actor implements IRedditService
	{
		private const REDDIT_USER_AGENT:String = "Reddit For Blackberry Playbook v. "; 

		protected var _parser:ISearchResultParser;
		
		protected var userAgent:String;
		protected var loginSuccess:Boolean = false;
		
		protected var cookieValue:String;
		protected var userVO:UserVO;
	
		protected var logger:ILogger;
		
		/** NOTIFICATION SIGNALS */
		[Inject]
		public var sectionLoaded:SectionLoadedSignal;
		
//		[Inject]
//		public var itemLoaded:ItemLoadedSignal;
//		
//		[Inject]
//		public var loginSuccessful:LoginSuccessfulSignal;
//		
//		[Inject]
//		public var loginStatusSignal:LoginStatusSignal;        
//		
//		[Inject]
//		public var refreshSignal:RefreshSignal;        

		[Inject]
		public var errorSignal:ErrorSignal;
		
		/** INJECTS */
		[Inject]
		public function set parser(value:ISearchResultParser):void
		{
			_parser = value;
		}
		
		public function RedditServiceBase()
		{
			super();
			
			var app_xml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = app_xml.namespace();
			var versionNumber:String = app_xml.ns::versionNumber;
			userAgent = REDDIT_USER_AGENT + versionNumber;
		}
		
		/**
		 * request for section (subreddit). Empty means front page. 
		 * @param path
		 * @param cookie
		 * 
		 */
		public function getSection(path:String="", cookie:String = ""):void
		{
			throw new Error("Override this method!");
		}
		
		/**
		 * request for one reddit specified by id 
		 * @param id
		 * @param cookie
		 * 
		 */
		public function getReddit(id:String, cookie:String = ""):void
		{
			throw new Error("Override this method!");
		}
		
		/**
		 * Login request 
		 * @param userVO
		 * 
		 */
		public function login(userVO:UserVO):void
		{
			throw new Error("Override this method!");
		}
		
		public function vote(vote:VoteVO, cookie:String):void
		{
			throw new Error("Override this method!");
		}
		
		/**
		 * HANDLERS 
		 */		
		
		protected function handleSectionLoadComplete(event:Event):void
		{
			logger.debug(": handleSectionLoadComplete");
			
			var loader:URLLoader = event.currentTarget as URLLoader; 
			
			loader.removeEventListener(Event.COMPLETE, handleSectionLoadComplete);
			removeLoaderListeners(loader);

			var results:ArrayList = _parser.parseSearchResults(loader.data);
			
			sectionLoaded.dispatch(results);
		}

//		protected function handleRedditLoadComplete(event:Event):void
//		{
//			logger.debug(": handleRedditLoadComplete");
//
//			var loader:URLLoader = event.currentTarget as URLLoader; 
//			
//			loader.removeEventListener(Event.COMPLETE, handleRedditLoadComplete);
//			removeLoaderListeners(loader);
//
//			var resultItem:RedditVO = _parser.parseSingleItem(loader.data);
//
//			itemLoaded.dispatch(resultItem);
//		}
		
//		protected function handleLoginComplete(event:Event):void
//		{
//			logger.debug(": handleLoginComplete");
//			
//			var loader:URLLoader = event.currentTarget as URLLoader; 
//			
//			loader.removeEventListener(Event.COMPLETE, handleLoginComplete);
//			removeLoaderListeners(loader);
//
//			if (cookieValue && cookieValue != "")
//			{
////				var result:Boolean = _parser.parseLoginResult(loader.data);
//				
//				// clean up user's password after successful login
//				userVO.password = "";
//				
//				var sessionVO:SessionVO = new SessionVO();
//				sessionVO.userVO = userVO;
//				sessionVO.cookie = cookieValue;
//				
//				loginSuccessful.dispatch(sessionVO);
//				loginStatusSignal.dispatch(true);
//				refreshSignal.dispatch();
//
//				logger.debug(": cookieValue: " + cookieValue);
//				cookieValue = "";
//			}
//			else
//			{
//				errorSignal.dispatch("username/password is wrong");
//			}
//		}

//		protected function handleVoteComplete(event:Event):void
//		{
//			logger.debug(": handleVoteComplete");
//			
//			var loader:URLLoader = event.currentTarget as URLLoader; 
//			
//			loader.removeEventListener(Event.COMPLETE, handleVoteComplete);
//			removeLoaderListeners(loader);
//
//			refreshSignal.dispatch();
//		}

		/**
		 * Handler for errors 
		 * @param event
		 * 
		 */
		protected function handleError(event:ErrorEvent):void
		{
			logger.error(": handleError - " + event.text);
			
			removeLoaderListeners(event.currentTarget as URLLoader);
			
			errorSignal.dispatch(event.text);
		}
		
		protected function addLoaderListeners(loader:URLLoader):void
		{
			loader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
		}
		
		protected function removeLoaderListeners(loader:URLLoader):void
		{
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handleError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
		}
	}
}