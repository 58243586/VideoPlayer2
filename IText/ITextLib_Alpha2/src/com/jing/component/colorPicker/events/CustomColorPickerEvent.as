package com.jing.component.colorPicker.events
{
    import flash.events.Event;

    /**
     *自定义颜色拾取器的事件
     * @author Jing
     *
     */
    public class CustomColorPickerEvent extends Event
    {
        private var _color:uint = 0;

        public function get color():uint
        {
            return _color;
        }

        public function CustomColorPickerEvent(type:String, color:uint)
        {
			_color = color;
            super(type);
        }

		/**
		 *颜色改变 
		 */		
        static public const CHANGE_COLOR:String = "changeColor";
    }
}