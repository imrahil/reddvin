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
    import com.ania.apps.reddvin.signals.StartupSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayLoginFormSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayPopupMenuSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplaySectionSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplaySubredditsSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayUrlSignal;
    import com.ania.apps.reddvin.signals.signaltons.DisplayUserInfoSignal;
    import com.ania.apps.reddvin.signals.signaltons.HidePopupMenuSignal;
    import com.ania.apps.reddvin.utils.LogUtil;
    import com.ania.apps.reddvin.view.BrowserView;
    import com.ania.apps.reddvin.view.LoginForm;
    import com.ania.apps.reddvin.view.MainView;
    import com.ania.apps.reddvin.view.SubredditsView;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.Mediator;

    import spark.components.Button;

    public class MainViewMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:MainView;

        /**
         * SIGNALTONS
         */
        [Inject]
        public var displayPopupMenuSignal:DisplayPopupMenuSignal;

        [Inject]
        public var hidePopupMenuSignal:HidePopupMenuSignal;

        [Inject]
        public var displaySection:DisplaySectionSignal;

        [Inject]
        public var displayLoginForm:DisplayLoginFormSignal;

        [Inject]
        public var displaySubreddits:DisplaySubredditsSignal;

        [Inject]
        public var displayUserInfo:DisplayUserInfoSignal;

        [Inject]
        public var displayUrl:DisplayUrlSignal;

        [Inject]
        public var startupSignal:StartupSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function MainViewMediator()
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

            displayPopupMenuSignal.add(displayPopupMenu);
            hidePopupMenuSignal.add(hidePopupMenu);

            displaySection.add(onDisplaySection);
            displayLoginForm.add(onDisplayLoginForm);
            displayUrl.add(onDisplayUrl);

            displaySubreddits.add(onDisplaySubreddits);
            displayUserInfo.add(onDisplayUserInfo);

            startupSignal.dispatch();
        }

        /** methods **/
        private function displayPopupMenu(owner:Button):void
        {
            view.showFirstViewNavigatorInPopUp(owner);
        }

        private function hidePopupMenu():void
        {
            view.hideViewNavigatorPopUp();
        }

        /**
         * Display section view and pop all other views
         */
        private function onDisplaySection():void
        {
            logger.debug(": onDisplaySection");

            view.contentNavigator.popToFirstView();
        }

        /**
         * Display login form
         * @param show if true show view, if not hide it
         */
        private function onDisplayLoginForm(show:Boolean):void
        {
            logger.debug(": onDisplayLoginForm - show: " + show);

            if (show)
            {
                view.contentNavigator.pushView(LoginForm);
            }
            else
            {
                view.contentNavigator.popView();
            }
        }

        /**
         * Display browser view with selected link
         * @param show
         * @param item RedditVO
         */
        private function onDisplayUrl(show:Boolean, item:RedditVO):void
        {
            if (show)
                logger.debug(": displayUrl - show: " + show + ", url: " + item.url);

            if (show)
            {
                view.contentNavigator.pushView(BrowserView, item);
            }
            else
            {
                view.contentNavigator.popView();
            }
        }

        private function onDisplaySubreddits(show:Boolean):void
        {
            logger.debug(": onDisplaySubreddits - show: " + show);

            if (show)
            {
                view.contentNavigator.pushView(SubredditsView);
            }
            else
            {
                view.contentNavigator.popView();
            }

        }

        private function onDisplayUserInfo(show:Boolean):void
        {
            logger.debug(": onDisplayUserInfo - show: " + show);
        }
    }
}
