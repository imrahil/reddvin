/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.controller
{
    import com.ania.apps.reddvin.constants.ApplicationConstants;
    import com.ania.apps.reddvin.model.RedditModel;
    import com.ania.apps.reddvin.services.IRedditService;
    import com.ania.apps.reddvin.signals.signaltons.DisplayActivityIndicatorSignal;
    import com.ania.apps.reddvin.signals.signaltons.SectionChangedSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import mx.logging.ILogger;

    import org.robotlegs.mvcs.SignalCommand;

    public final class RefreshCommand extends SignalCommand
    {
        /** INJECTIONS **/
        [Inject]
        public var redditModel:RedditModel;

        [Inject]
        public var redditService:IRedditService;

        [Inject]
        public var displayActivityIndicator:DisplayActivityIndicatorSignal;

        [Inject]
        public var sectionChanged:SectionChangedSignal;

        /** variables **/
        private var logger:ILogger;

        /**
         * CONSTRUCTOR
         */
        public function RefreshCommand()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        /**
         * Method handle the logic for <code>RefreshCommand</code>
         */
        override public function execute():void
        {
            logger.debug(": execute");

            if (redditModel.initialized)
            {
                logger.debug(": all system initialized");

                if (redditModel.needReload)
                {
                    logger.debug(": need reload data");

                    redditModel.needReload = false;
                    displayActivityIndicator.dispatch(true);

                    switch (redditModel.currentScreen)
                    {
                        case ApplicationConstants.SECTION_VIEW:
                            updateSection();
                            break;

                        case ApplicationConstants.ITEM_VIEW:
                            updateItem();
                            updateSection();
                            break;
                    }
                }
                else if (redditModel.sectionItems && redditModel.sectionItems)
                {
                    logger.debug(": using local data");

                    sectionChanged.dispatch(redditModel.sectionItems);
                }
            }
        }

        private function updateSection():void
        {
            redditService.getSection(redditModel.selectedSubreddit, redditModel.sortOrder);
        }

        private function updateItem():void
        {
            if (redditModel.singleReddit)
            {
                redditService.getReddit(redditModel.singleReddit.id);
            }
        }
    }
}
