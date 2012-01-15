/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.model.vo.RedditVO;
    import com.ania.apps.reddvin.model.vo.SectionVO;
    import com.ania.apps.reddvin.signals.ChangeSortSignal;
    import com.ania.apps.reddvin.signals.GetItemSignal;
    import com.ania.apps.reddvin.signals.RefreshSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayActivityIndicatorSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayPopupMenuSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayUrlSignal;
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

        [Inject]
        public var displayUrl:DisplayUrlSignal;

        /**
         * SIGNAL -> COMMAND
         */
        [Inject]
        public var refreshSignal:RefreshSignal;

        [Inject]
        public var changeSortSignal:ChangeSortSignal;

        [Inject]
        public var getItem:GetItemSignal;


        /** variables **/
        private var logger:ILogger;
        private var showLink:Boolean = false;

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

            // view listeners
            view.menuButtonClickSignal.add(onMenuButtonClicked);
            view.sortChangeSignal.add(onSortChanged);

            view.iconClickSignal.add(onIconClicked);
            view.listItemClickSignal.add(onListItemClicked);

            // signals listeners
            sectionChanged.add(onSectionChanged);
            displayActivityIndicator.add(displayBusyIndicator);

            logger.debug(": sending refresh signal");
            refreshSignal.dispatch();
        }

        /**
         * Remove all listeners from sectionChange signal when removing from stage
         */
        override public function onRemove():void
        {
            logger.debug(": onRemove");

            sectionChanged.removeAll();
        }

        /** methods **/

        /**
         * Menu button handler - in portrait mode only
         * @param owner
         */
        private function onMenuButtonClicked(owner:Button):void
        {
            logger.debug(": onMenuButtonClicked");

            displayPopupMenuSignal.dispatch(owner);
        }

        /**
         * Sort button change handler
         */
        private function onSortChanged(sortOrder:String):void
        {
            logger.debug(": onSortChanged");

            changeSortSignal.dispatch(sortOrder);
        }

        /**
         * Icon click handler
         */
        private function onIconClicked():void
        {
            logger.debug(": onIconClicked");

            showLink = true;
        }

        /**
         * List item change handler
         */
        private function onListItemClicked():void
        {
            logger.debug(": onListItemClickedk");

            if (view.sectionList.selectedItem)
            {
                var item:RedditVO = view.sectionList.selectedItem as RedditVO;

                if (showLink && !item.is_self)
                {
                    showLink = false;
                    displayUrl.dispatch(true, item);
                }
                else
                {
                    showLink = false;
                    displayActivityIndicator.dispatch(true);
                    getItem.dispatch(item);
                }
            }
        }

        private function onSectionChanged(items:ArrayList):void
        {
            logger.debug(": onSectionChanged");

            view.busyIndicator.visible = false;
            view.sectionList.dataProvider = items;

//            var section:SectionVO = new SectionVO();
//            section.sectionList = items;
        }

        private function displayBusyIndicator(state:Boolean):void
        {
            view.busyIndicator.visible = state;
        }
    }
}
