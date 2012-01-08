/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.services
{
	import com.ania.apps.reddvin.model.vo.SessionVO;
	import com.ania.apps.reddvin.model.vo.UserVO;
	import com.ania.apps.reddvin.model.vo.VoteVO;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.rpc.events.ResultEvent;
	
	public class RedditServiceMock extends RedditServiceBase
	{
		public function RedditServiceMock()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}
		
		/**
		 * GET SECTION 
		 */
		override public function getSection(path:String="", cookie:String = ""):void
		{
			logger.debug(": getSection - path: " + path);
			
			var loader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest();
			
			var url:String;
			if (path != "")
			{
				url = "assets/data/wtf_page.json";
			}
			else
			{
				url = "assets/data/main_page.json";
			}
			urlRequest.url = url;
			
			loader.addEventListener(Event.COMPLETE, handleMockSectionLoadComplete);
			addLoaderListeners(loader);
			
			loader.load(urlRequest);
		}
		
		private function handleMockSectionLoadComplete(event:Event):void
		{
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
				function ():void
				{
					handleSectionLoadComplete(event);
				});
			timer.start();
		}
		
		/**
		 * GET REDDIT 
		 */
		override public function getReddit(id:String, cookie:String = ""):void
		{
			logger.debug(" : getReddit");

			var loader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest();
		
			var url:String;
			
			switch (id)
			{
				case "g3tfr":
					url = "assets/data/item_self3.json"; 
					break;
				case "g3tnq":
					url = "assets/data/item_self2.json"; 
					break;
				case "g3pmx":
					url = "assets/data/item_regular2.json"; 
					break;
				default:
					url = "assets/data/item_regular.json"; 
					break;
			}
			urlRequest.url = url;
			
			loader.addEventListener(Event.COMPLETE, handleMockItemLoadComplete);
			addLoaderListeners(loader);
			
			loader.load(urlRequest);
		}
		
		private function handleMockItemLoadComplete(event:Event):void
		{
//			var timer:Timer = new Timer(1000, 1);
//			timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
//				function ():void
//				{
//					handleRedditLoadComplete(event);
//				});
//			timer.start();
		}
		
		/**
		 * LOGIN 
		 */
		override public function login(userVO:UserVO):void
		{
			logger.debug(" : login - username: " + userVO.username + ", pass: " + userVO.password);
			
			this.userVO = userVO;
			
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onMockLoginTimerComplete);
			timer.start();
		}
		
		private function onMockLoginTimerComplete(event:TimerEvent):void
		{
			var sessionVO:SessionVO = new SessionVO();
			sessionVO.userVO = userVO;
			sessionVO.cookie = "cookie monster!";
			
//			loginSuccessful.dispatch(sessionVO);
		}
		
		/**
		 * VOTE 
		 */
		override public function vote(vote:VoteVO, cookie:String):void
		{
			logger.debug(" : vote - id: " + vote.itemId + ", dir: " + vote.direction);

			var loader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest();
			
			var url:String = "assets/data/item_self3.json";
			
			urlRequest.url = url;
			
			loader.addEventListener(Event.COMPLETE, handleMockVoteLoadComplete);
			addLoaderListeners(loader);
			
			loader.load(urlRequest);
		}
		
		private function handleMockVoteLoadComplete(event:Event):void
		{
//			var timer:Timer = new Timer(1000, 1);
//			timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
//				function ():void
//				{
//					handleVoteComplete(event);
//				});
//			timer.start();
		}
	}
}