/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.signals.SetCurrentViewStateSignal;
    import com.ania.apps.reddvin.utils.LogUtil;

    import mx.events.ResizeEvent;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.logging.LogEventLevel;
    import mx.logging.targets.TraceTarget;

    import org.robotlegs.mvcs.Mediator;

    public class ReddvinMediator extends Mediator
    {
        /**
         * VIEW
         */
        [Inject]
        public var view:Reddvin;

        [Inject]
        public var setCurrentViewStateSignal:SetCurrentViewStateSignal;

        /** variables **/
        private var logger:ILogger;

        public function ReddvinMediator()
        {
            super();

            logger = LogUtil.getLogger(this);
            logger.debug(": constructor");
        }

        override public function onRegister():void
        {
            logger.debug(": onRegister");

            addViewListener(ResizeEvent.RESIZE, onResize);

            CONFIG::debugMode
            {
                var logTarget:TraceTarget = new TraceTarget();
                logTarget.level = LogEventLevel.ALL;
                logTarget.includeDate = true;
                logTarget.includeTime = true;
                logTarget.includeCategory = true;
                logTarget.includeLevel = true;
                Log.addTarget(logTarget);
            }

            onResize(null);
        }

        protected function onResize(event:ResizeEvent):void
        {
            view.currentState = view.aspectRatio;

            setCurrentViewStateSignal.dispatch(view.aspectRatio);
        }
    }
}