/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.model.vo.SubredditVO;
    import com.ania.apps.reddvin.signals.ChangeSectionSignal;
    import com.ania.apps.reddvin.signals.GetUserSubredditsSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplaySubredditsSignal;
    import com.ania.apps.reddvin.signals.signaltons.SubredditsChangedSignal;
    import com.ania.apps.reddvin.utils.LogUtil;
    import com.ania.apps.reddvin.view.SubredditsView;

    import mx.collections.ArrayList;
    import mx.logging.ILogger;

    import org.robotlegs.mvcs.Mediator;

    public class SubredditsMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:SubredditsView;

        /**
         * SIGNALTONS
         */
        [Inject]
        public var subredditsChanged:SubredditsChangedSignal;

        [Inject]
        public var displaySubredditsSignal:DisplaySubredditsSignal;

        /**
         * SIGNAL -> COMMAND
         */
        [Inject]
        public var getUserSubredditsSignal:GetUserSubredditsSignal;

        [Inject]
        public var changeSectionSignal:ChangeSectionSignal;

        /** variables **/
        private var logger:ILogger;

        /** 
         * CONSTRUCTOR 
         */
        public function SubredditsMediator()
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

            subredditsChanged.add(onSubredditsChanged);

            view.backBtnClicked.add(onBackBtnClicked);
            view.itemClicked.add(onItemClicked);

            view.busyIndicator.visible = true;
            getUserSubredditsSignal.dispatch();
        }

        /**
         * Remove all listeners from sectionChange signal when removing from stage
         */
        override public function onRemove():void
        {
            logger.debug(": onRemove");

            subredditsChanged.removeAll();
        }


        /** methods **/
        private function onBackBtnClicked():void
        {
            logger.debug(": onBackBtnClicked");

            displaySubredditsSignal.dispatch(false);
        }

        private function onItemClicked():void
        {
            logger.debug(": onItemClicked");

            var newSubreddit:String = (view.subredditsList.selectedItem as SubredditVO).display_name;

            changeSectionSignal.dispatch(newSubreddit)
        }

        private function onSubredditsChanged(items:ArrayList):void
        {
            logger.debug(": onSubredditsChanged");

            view.busyIndicator.visible = false;
            view.subredditsList.dataProvider = items;
        }
    }
}
