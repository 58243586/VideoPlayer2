package itext.views.elements
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import mx.core.UIComponent;

	/**
	 *程序中使用的色块 
	 * @author Jing
	 * 
	 */	
	public class RectBlock extends Shape
	{
		public function RectBlock()
		{
			super();
		}

		public function update(width:Number, height:Number, color:uint, alpha:Number):void
		{
			this.graphics.clear();
			this.graphics.beginFill(color, alpha);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
			this.width = width;
			this.height = height;
		}

	}
}