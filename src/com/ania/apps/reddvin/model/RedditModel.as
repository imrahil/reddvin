/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.model
{
	import com.ania.apps.reddvin.constants.ApplicationConstants;
	import com.ania.apps.reddvin.model.vo.RedditVO;
	import com.ania.apps.reddvin.model.vo.SessionVO;
	import com.ania.apps.reddvin.signals.signaltons.DisplayItemSignal;
	import com.ania.apps.reddvin.signals.signaltons.SectionChangedSignal;
	import com.ania.apps.reddvin.utils.LogUtil;
	
	import mx.collections.ArrayList;
	import mx.logging.ILogger;
	
	import org.robotlegs.mvcs.*;
	
	public class RedditModel extends Actor {
		
		/**
		 * INJECT
		 */
		
		[Inject]
		public var sectionChanged:SectionChangedSignal;
		
		[Inject]
		public var displayItem:DisplayItemSignal;        

		/** variables **/

		private var _items:ArrayList;
		private var _item:RedditVO;
		private var _session:SessionVO;
		private var _selectedSubreddit:String = "";
		
		private var _sortOrder:String = "";
		
		private var _currentScreen:String = ApplicationConstants.SECTION_SCREEN
		
		private var _loggedIn:Boolean = false;
		
		private var _initialized:Boolean = false;
		
		private var logger:ILogger;
		
		/** 
		 * CONSTRUCTOR 
		 */		
		public function RedditModel()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}
		

		/**
		 * List of all Reddits in section
		 */
		public function get items():ArrayList 
		{
			return _items;
		}
		
		public function set items(value:ArrayList):void 
		{
			logger.debug(": set items");

			_items = value;
			
			if(value)
			{
				sectionChanged.dispatch(_items)
			}
		}

		/**
		 * Single Reddit
		 */
		public function get item():RedditVO
		{
			return _item;
		}
		
		public function set item(value:RedditVO):void 
		{
			logger.debug(": set item");

			_item = value;
			
			if(value)
			{
				displayItem.dispatch(_item);
			}
		}
	
		/**
		 * Session variable
		 */
		public function get session():SessionVO
		{
			return _session;
		}
		
		public function set session(value:SessionVO):void 
		{
			logger.debug(": set session");

			_session = value;
		}
	
		/**
		 * Current subreddit
		 */
		public function get selectedSubreddit():String
		{
			return _selectedSubreddit;
		}
		
		public function set selectedSubreddit(value:String):void 
		{
			logger.debug(": set selectedSubreddit");

			_selectedSubreddit = value;
		}
		
		/**
		 * Sort order for current subreddit 
		 */
		public function get sortOrder():String
		{
			return _sortOrder;
		}
		
		public function set sortOrder(value:String):void
		{
			logger.debug(": set sortOrder");
			
			_sortOrder = value;
		}
		
		/**
		 * Current section of application
		 */
		public function get currentScreen():String
		{
			return _currentScreen;
		}
		
		public function set currentScreen(value:String):void 
		{
			logger.debug(": set currentScreen");

			_currentScreen = value;
		}
		
		/**
		 * Logged in or not
		 */
		public function get loggedIn():Boolean
		{
			return _loggedIn;
		}
		
		public function set loggedIn(value:Boolean):void 
		{
			logger.debug(": set loggedIn");

			_loggedIn = value;
		}

		/**
		 *	Check if application is fully initialized 
		 */
		public function get initialized():Boolean
		{
			return _initialized;
		}

		public function set initialized(value:Boolean):void
		{
			logger.debug(": set initialized");

			_initialized = value;
		}

	}
}
