/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.view.mediators
{
    import com.ania.apps.reddvin.utils.LogUtil;

    import mx.logging.ILogger;
    
    import com.ania.apps.reddvin.view.SubredditsView;
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


        /**
         * SIGNAL -> COMMAND
         */

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
            
        }

        /** methods **/

        /** eventHandlers **/

    }
}
