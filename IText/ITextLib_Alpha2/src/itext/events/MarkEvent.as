package itext.events
{
    import flash.events.Event;

    /**
     *标记产生的事件
     * @author Jing
     *
     */
    public class MarkEvent extends Event
    {
        public function MarkEvent(type:String)
        {
            super(type);
        }

        static public const MARK_CLICK:String = "MarkClick";
    }
}