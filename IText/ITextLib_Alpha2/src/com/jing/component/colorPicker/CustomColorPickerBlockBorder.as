package com.jing.component.colorPicker
{
    import flash.display.CapsStyle;
    import flash.display.Shape;
	
	/**
	 * 
	 * @author Jing
	 * 
	 */
    internal class CustomColorPickerBlockBorder extends Shape
    {
        public function CustomColorPickerBlockBorder()
        {
            super();
            update(12, 12);
        }

        public function update(width:int, height:int):void
        {
            this.graphics.moveTo(-1, -1);
            this.graphics.lineStyle(1, 0xef4810, 1);
            this.graphics.lineTo(width + 1, -1);
            this.graphics.lineTo(width + 1, height + 1);
            this.graphics.lineTo(-1, height + 1);
            this.graphics.lineTo(-1, -1);
            this.graphics.moveTo(0, 0);
            this.graphics.lineStyle(1, 0xffe294, 1)
            this.graphics.lineTo(width, 0);
            this.graphics.lineTo(width, height);
            this.graphics.lineTo(0, height);
            this.graphics.lineTo(0, 0);
        }
    }
}