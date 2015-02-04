package itext.views.elements.keywordBorders
{
	import itext.components.TextArea;
	
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	public class KeywordDoubleUnderLineBorder extends UIComponent
	{
		
		public function KeywordDoubleUnderLineBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea)
		{
			super();
			this.mouseEnabled = false;
			
			var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
			var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);
			
			var startLineIndex:int = ta.getTextField().getLineIndexOfChar(beginIndex);
			var endLineIndex:int = ta.getTextField().getLineIndexOfChar(endIndex  -1);
			
			this.graphics.beginFill(color);
			this.graphics.lineStyle(1, color);
			
			var distance:int = endLineIndex - startLineIndex;
			
			var offsetY:int = 1;
			var offsetY1:int = 2;
			
			if (distance == 0)
			{
				this.graphics.moveTo(0, rectStart.height + offsetY);
				this.graphics.lineTo(rectEnd.right - rectStart.x, rectStart.height + offsetY);
				
				this.graphics.moveTo(0, rectStart.height + offsetY + offsetY1);
				this.graphics.lineTo(rectEnd.right - rectStart.x, rectStart.height + offsetY + offsetY1);
			}
			else
			{
				this.graphics.moveTo(0, rectStart.height + offsetY);
				this.graphics.lineTo(ta.width - rectStart.x, rectStart.height + offsetY);
				
				this.graphics.moveTo(0, rectStart.height + offsetY + offsetY1);
				this.graphics.lineTo(ta.width - rectStart.x, rectStart.height + offsetY + offsetY1);
				
				for (var i:int = startLineIndex + 1; i < endLineIndex; i++)
				{
					var lineFirstRect:Rectangle = ta.getTextField().getCharBoundaries(ta.getTextField().getLineOffset(i));
					
					this.graphics.moveTo(-rectStart.x, lineFirstRect.y + lineFirstRect.height - rectStart.y + offsetY);
					this.graphics.lineTo(ta.width - rectStart.x, lineFirstRect.y + lineFirstRect.height - rectStart.y + offsetY);
					
					this.graphics.moveTo(-rectStart.x, lineFirstRect.y + lineFirstRect.height - rectStart.y + offsetY + offsetY1);
					this.graphics.lineTo(ta.width - rectStart.x, lineFirstRect.y + lineFirstRect.height - rectStart.y + offsetY + offsetY1);
				}
				
				this.graphics.moveTo(-rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
				this.graphics.lineTo(rectEnd.right - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
				
				this.graphics.moveTo(-rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY + offsetY1);
				this.graphics.lineTo(rectEnd.right - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY + offsetY1);				
			}
			
			this.graphics.endFill();
			
			this.x = rectStart.x + ta.x;
			this.y = rectStart.y + ta.y;
		}
	}
}
