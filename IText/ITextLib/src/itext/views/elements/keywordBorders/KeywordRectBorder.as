package itext.views.elements.keywordBorders
{
	import itext.components.TextArea;

	import flash.geom.Rectangle;

	import mx.core.UIComponent;

	public class KeywordRectBorder extends UIComponent
	{
		public function KeywordRectBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea, isFill:Boolean = false)
		{
			super();
			this.mouseEnabled = false;

			var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
			var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

			//起始行数
			var startLineIndex:int = ta.getTextField().getLineIndexOfChar(beginIndex);
			//结束行数
			var endLineIndex:int = ta.getTextField().getLineIndexOfChar(endIndex - 1);


			if (isFill == false)
			{
				this.graphics.beginFill(0, 0);
				this.graphics.endFill();
				this.graphics.lineStyle(1, color);
			}
			else
			{
				this.graphics.beginFill(color, 0.3);
				this.graphics.lineStyle(0, 0, 0);
			}


			var distance:int = endLineIndex - startLineIndex;
			var offsetY:Number = 0.5;

			if (distance == 0)
			{
				this.graphics.drawRect(0, 0, rectEnd.x + rectEnd.width - rectStart.x, rectStart.height);
			}
			else if (distance == 1)
			{
				this.graphics.moveTo(ta.width - rectStart.x, 0);
				this.graphics.lineTo(0, 0);
				this.graphics.lineTo(0, rectStart.height);
				this.graphics.lineTo(ta.width - rectStart.x, rectStart.height);

				this.graphics.moveTo(-rectStart.x, rectEnd.y - rectStart.y);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y - rectStart.y);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y);
				this.graphics.lineTo(-rectStart.x, rectEnd.y + rectEnd.height - rectStart.y);

			}
			else if (distance > 1)
			{
				this.graphics.moveTo(0, 0);
				this.graphics.lineTo(ta.width - rectStart.x, 0);
				this.graphics.lineTo(ta.width - rectStart.x, rectEnd.y - rectStart.y);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y - rectStart.y);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y - rectStart.y + rectEnd.height);
				this.graphics.lineTo(-rectStart.x, rectEnd.y - rectStart.y + rectEnd.height);
				this.graphics.lineTo(-rectStart.x, rectStart.height);
				this.graphics.lineTo(0, rectStart.height);
				this.graphics.lineTo(0, 0);
			}
			this.graphics.endFill();

			this.x = rectStart.x + ta.x;
			this.y = rectStart.y + ta.y;
		}
	}
}