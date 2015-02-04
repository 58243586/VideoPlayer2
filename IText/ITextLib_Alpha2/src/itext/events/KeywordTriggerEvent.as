package itext.events
{
    import flash.events.Event;

    import itext.vo.KeywordVO;

    /**
     *关键词句触发事件
     * @author jing
     *
     */
    public class KeywordTriggerEvent extends Event
    {
        private var _keywordVO:KeywordVO = null;

        public function get keywordVO():KeywordVO
        {
            return _keywordVO;
        }

        public function KeywordTriggerEvent(type:String, vo:KeywordVO)
        {
            this._keywordVO = vo;
            super(type);
        }

        /**
         *关键词触发
         */
        static public const KEYWORD_TRIGGER:String = "KeywordTrigger";
    }
}