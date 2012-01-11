/*
 Copyright (c) 2012 Anna Dabrowska, All Rights Reserved
 @author   Anna Dabrowska
 @contact  ania.blackberry@gmail.com
 @project  Reddvin
 @internal
 */
package com.ania.apps.reddvin.constants
{
    import mx.collections.ArrayCollection;

    public class ApplicationConstants
    {
        public static const REDDIT_USER_AGENT:String = "Reddit For Blackberry Playbook v. ";
        public static const REDDVIN_APP_VERSION:String = "0.3.0";

        public static const REDDIT_API_ENDPOINT:String = "http://www.reddit.com";
        public static const REDDIT_API_TYPE:String = "json";
        public static const REDDIT_API_EXTENSION:String = ".json";
        public static const REDDIT_API_PREFIX:String = "t3_";
        public static const REDDIT_API_LIMIT:int = 50;

        public static const REDDIT_SO_NAME:String = "reddvinSessionData";
        public static const LOGIN_ERROR:String = "loginError";

        public static const SECTION_VIEW:String = "sectionView";
        public static const ITEM_VIEW:String = "itemView";
        public static const LOGIN_VIEW:String = "loginView";
        public static const BROWSER_VIEW:String = "browserView";

        public static const SORT_FRONT:String = "what's hot";
        public static const SORT_NEW:String = "new";
        public static const SORT_CONTROVERSIAL:String = "controversial";
        public static const SORT_TOP:String = "top";

        public static const SAVED_ITEMS:String = "saved";

        public static const SORT_ORDER:ArrayCollection = new ArrayCollection([
            SORT_FRONT, SORT_NEW, SORT_CONTROVERSIAL, SORT_TOP
        ]);

        public static const USERNAME:String = CONFIG::username;
        public static const PASSWORD:String = CONFIG::password;

        public function ApplicationConstants()
        {
        }
    }
}
