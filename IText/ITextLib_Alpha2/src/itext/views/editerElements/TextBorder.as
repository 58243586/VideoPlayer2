package itext.views.editerElements
{
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.filters.DropShadowFilter;
    import flash.geom.ColorTransform;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import mx.core.UIComponent;
    import mx.skins.Border;

    public class TextBorder extends UIComponent
    {
        private var border1:BorderOneUI;

        private var border2:BorderTwoUI;

        private var border3:BorderThreeUI;
		
		private var previewBorder1:PreviewBorderOneUI;
		
		private var previewBorder2:PreviewBorderTwoUI;
		
		private var rpeviewBorder3:PreviewBorderThreeUI;

        private var _border:DisplayObject = null;

        private var _borderName:String = "";

        public function get borderName():String
        {
            return _borderName;
        }

        private var _borderColor:uint = 0xFFFFFF;

        public function get borderColor():uint
        {
            return _borderColor;
        }


        public function TextBorder()
        {
            super();
        }

        public function updateBorder(borderName:String, width:Number, height:Number):void
        {
            if (_border != null && _borderName == borderName)
            {
                _border.width = width;
                _border.height = height;
                return;
            }
            else
            {
                this._borderName = borderName;

                if (_border != null && this.contains(_border))
                {
                    this.removeChild(_border);
                }

                var borderClass:Class = getDefinitionByName(borderName) as Class;

                _border = new borderClass() as DisplayObject;

                this.addChild(_border);
                _border.width = width;
                _border.height = height;

                _border.filters = [new DropShadowFilter()];
            }
        }

        public function changeColor(color:uint):void
        {
            if (_border == null)
            {
                return;
            }

			_borderColor = color;
			
            var colorBlock:DisplayObject = DisplayObjectContainer(_border).getChildByName("colorBlock") as DisplayObject;

            if (colorBlock != null)
            {
                var ct:ColorTransform = new ColorTransform();
                ct.color = color;
                colorBlock.transform.colorTransform = ct;
            }
        }
		
		public function getGraphicColor():uint
		{
			var result:uint = 0;
			var colorBlock:DisplayObject = DisplayObjectContainer(_border).getChildByName("colorBlock") as DisplayObject;
			
			var bd:BitmapData = new BitmapData(10,10);
			bd.draw(colorBlock);
			result = bd.getPixel(5,5);
			
			return result;
		}
    }
}