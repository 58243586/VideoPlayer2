package com.jing.component.colorPicker
{
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;

    import mx.core.UIComponent;

    /**
     *程序中使用的色块
     * @author Jing
     *
     */
    internal class CustomColorPickerBlock extends Sprite
    {
        private var _color:uint = 0;

        public function get color():uint
        {
            return _color;
        }

        public function CustomColorPickerBlock(color:uint)
        {
            super();
            update(color);
        }

        public function update(color:uint):void
        {
            _color = color;
            this.graphics.clear();
            this.graphics.lineStyle(0, 0, 0);
            this.graphics.beginFill(color, 1);
            this.graphics.drawRect(0, 0, 13, 13);
            this.graphics.endFill();
            this.width = width;
            this.height = height;
        }

    }
}