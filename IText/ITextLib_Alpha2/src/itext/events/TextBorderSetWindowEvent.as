package itext.events
{
    import flash.events.Event;

    public class TextBorderSetWindowEvent extends Event
    {
        private var _borderName:String = "";

        public function get borderName():String
        {
            return _borderName;
        }

        public function TextBorderSetWindowEvent(type:String, borderName:String)
        {
            _borderName = borderName
            super(type);
        }

        /**
         *边框选择
         */
        static public const BORDER_SET:String = "BorderSet";
    }
}