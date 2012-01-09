/*
Copyright (c) 2012 Anna Dabrowska, All Rights Reserved 
@author   Anna Dabrowska
@contact  dabrowskaanna@wp.pl
@project  Reddvin
@internal 
*/
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayActivityIndicatorSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayPopupMenuSignal;
    import com.ania.apps.reddvin.signals.signaltons.SectionChangedSignal;
    import com.ania.apps.reddvin.utils.LogUtil;
    import com.ania.apps.reddvin.view.SectionView;
    
    import mx.collections.ArrayList;
    import mx.logging.ILogger;
    
    import org.robotlegs.mvcs.Mediator;
    
    import spark.components.Button;
    
    public class SectionMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:SectionView;		
        
        /**
         * SIGNALTONS
         */
		[Inject]
		public var sectionChanged:SectionChangedSignal;        
  
		[Inject]
		public var displayPopupMenuSignal:DisplayPopupMenuSignal;

		[Inject]
		public var displayActivityIndicator:DisplayActivityIndicatorSignal;        

        /**
         * SIGNAL -> COMMAND
         */
		[Inject]
		public var refreshSignal:RefreshSignal;        
		
	

//		[Inject]
//		public var getItem:GetItemSignal;
        
//		[Inject]
//		public var displayUrl:DisplayUrlSignal;
 
//		[Inject]
//		public var voteSignal:VoteSignal;

		
        /** variables **/
		private var logger:ILogger;
		private var showLink:Boolean = false;
		private var placeVote:Boolean = false;
	
		/** 
		 * CONSTRUCTOR 
		 */		
		public function SectionMediator()
		{
			super();
			
			logger = LogUtil.getLogger(this);
			logger.debug(": constructor");
		}

		/** 
         * onRegister 
         * Override the invoked of the <code>IMediator</code> and allow you to place your own initialization. 
         */		
        override public function onRegister():void
        {
			logger.debug(": onRegister");
			
			view.menuButtonClicked.add(onMenuButtonClicked);
			view.sortChanged.add(onSortChanged);
			
//			eventMap.mapListener(view.sectionList, MouseEvent.MOUSE_UP, onMouseUp); 
//			eventMap.mapListener(view.sectionList, ListEvent.ITEM_CLICKED, onItemClick); 
			sectionChanged.add(onSectionChanged);

			displayActivityIndicator.add(displayBusyIndicator);
	
			logger.debug(": sending refresh signal");
			refreshSignal.dispatch();
		}
		
		override public function onRemove():void
		{
			sectionChanged.removeAll();	
		}
		
        /** methods **/		

		/**
		 * Menu button handler - in portrait mode only 
		 * @param owner
		 * 
		 */
		private function onMenuButtonClicked(owner:Button):void
		{
			displayPopupMenuSignal.dispatch(owner);
		}
		
		/**
		 * Sort button handler 
		 * 
		 */
		private function onSortChanged(sortOrder:String):void
		{
			// TODO - add call to change/refresh section
			logger.debug("Sort: " + sortOrder);
		}
		
//		private function onMouseUp(event:MouseEvent):void
//		{
//			var temp:* = event.target;
//			
//			if (temp is ThumbnailImageContainer || temp is ThumbnailImage)
//			{
//				showLink = true;
//				view.sectionList.dispatchEvent(event);
//			}
//			
//			if (temp is VoteAreaBtn)
//			{
//				placeVote = true;
//				view.sectionList.dispatchEvent(event);
//			}
//		}

//		private function onItemClick(event:ListEvent):void
//		{
//			logger.debug(": onItemClick");
//
//			if (event.currentTarget)
//			{
//				var clickedList:List = event.currentTarget as List;
//				
//				if (clickedList.selectedItem)
//				{
//					var item:RedditVO = clickedList.selectedItem as RedditVO;
//
//					if (showLink && !item.is_self)
//					{
//						showLink = false;
//						displayUrl.dispatch(item.url, item.title);
//					}
//					else if (placeVote)
//					{
//						placeVote = false;
//						
//						var voteVO:VoteVO = new VoteVO();
//						voteVO.itemId = item.name;
//						voteVO.direction = "1";
//						voteSignal.dispatch(voteVO);
//					}
//					else
//					{
//						showLink = false;
//						getItem.dispatch(item);
//						displayActivityIndicator.dispatch(true);
//					}
//				}
//			}
//		}
		
		private function onSectionChanged(items:ArrayList):void 
		{
			logger.debug(": onSectionChanged");

			view.busyIndicator.visible = false;;      

			view.sectionList.dataProvider = items;
		}
		
		private function displayBusyIndicator(state:Boolean):void
		{
			view.busyIndicator.visible = state;
		}
    }
}
