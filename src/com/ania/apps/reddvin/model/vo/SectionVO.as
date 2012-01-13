package com.ania.apps.reddvin.model.vo
{
    import mx.collections.ArrayList;

    [Bindable]
    public class SectionVO
    {
        public function SectionVO()
        {
        }
        
        public var sectionList:ArrayList;
        public var sectionRect:Number;
        public var sortIndex:int = 0;
    }
}
