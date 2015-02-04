package itext.views.elements.keywordBorders
{
	import itext.components.TextArea;

	import flash.geom.Rectangle;

	import mx.core.UIComponent;

	public class KeywordUnderLineBorder extends UIComponent
	{
		public function KeywordUnderLineBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea)
		{
			super();
			this.mouseEnabled = false;

			var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
			var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

			//起始行数
			var startLineIndex:int = ta.getTextField().getLineIndexOfChar(beginIndex);
			//结束行数
			var endLineIndex:int = ta.getTextField().getLineIndexOfChar(endIndex - 1);


			this.graphics.beginFill(color);
			this.graphics.lineStyle(2, color);

			var distance:int = endLineIndex - startLineIndex;

			var offsetY:int = 2;

			if (distance == 0)
			{
				this.graphics.moveTo(0, rectStart.height + offsetY);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectStart.height + offsetY);
			}
			else
			{
				this.graphics.moveTo(0, rectStart.height + offsetY);
				this.graphics.lineTo(ta.width - rectStart.x, rectStart.height + offsetY);

				for (var i:int = startLineIndex + 1; i < endLineIndex; i++)
				{
					var lineFirstRect:Rectangle = ta.getTextField().getCharBoundaries(ta.getTextField().getLineOffset(i));
					this.graphics.moveTo(-rectStart.x, lineFirstRect.y + lineFirstRect.height - rectStart.y + offsetY);
					this.graphics.lineTo(ta.width - rectStart.x, lineFirstRect.y + lineFirstRect.height - rectStart.y + offsetY);
				}
				this.graphics.moveTo(-rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
			}


			this.graphics.endFill();

			this.x = rectStart.x + ta.x;
			this.y = rectStart.y + ta.y;
		}
	}
}