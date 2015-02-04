package itext.framework.keywordBorders
{
    import com.jing.utils.TextAreaUtil;
    
    import flash.geom.Rectangle;
    
    import mx.core.UIComponent;
    
    import spark.components.TextArea;

    public class KeywordRectBorder extends UIComponent
    {
        public function KeywordRectBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea, isFill:Boolean = false)
        {
            super();

            this.mouseEnabled = false;

            var rectStart:Rectangle = TextAreaUtil.getBoundRectOfIndex(beginIndex, ta);
            var rectEnd:Rectangle = TextAreaUtil.getBoundRectOfIndex(endIndex - 1, ta);

            //起始行数
            var startLineIndex:int = ta.textFlow.flowComposer.findLineIndexAtPosition(beginIndex);
            //结束行数
            var endLineIndex:int = ta.textFlow.flowComposer.findLineIndexAtPosition(endIndex - 1);
			
			//起始行字符总数
			var startLineTextLength:int = ta.textFlow.flowComposer.getLineAt(startLineIndex).textLength;
			
			//起始行的第一个字符索引
			var startLineFirstIndex:int = ta.textFlow.flowComposer.getLineAt(startLineIndex).absoluteStart;
			//起始行的最后一个字符索引
			var startLineLastIndex:int = startLineFirstIndex + startLineTextLength - 1;			
			
			//结束行的第一个字符索引
			var endLineFirstIndex:int = ta.textFlow.flowComposer.getLineAt(endLineIndex).absoluteStart;
			
			var startLineLastIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(startLineLastIndex, ta);
			var endLineFirstIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(endLineFirstIndex, ta);


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
                this.graphics.drawRect(0, 0 - offsetY, rectEnd.x + rectEnd.width - rectStart.x, rectStart.height + offsetY * 5);
            }
            else if (distance == 1)
            {
				this.graphics.moveTo(startLineLastIndexRect.x + startLineLastIndexRect.width - rectStart.x, 0 - offsetY);
				this.graphics.lineTo(0, 0 - offsetY);
				this.graphics.lineTo(0, rectStart.height + offsetY * 4);
				this.graphics.lineTo(startLineLastIndexRect.x + startLineLastIndexRect.width - rectStart.x, rectStart.height + offsetY * 4);
				
				this.graphics.moveTo(endLineFirstIndexRect.x - rectStart.x, rectEnd.y - rectStart.y - offsetY);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y - rectStart.y - offsetY);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY * 4);
				this.graphics.lineTo(endLineFirstIndexRect.x - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY * 4);

            }
            else if (distance > 1)
            {
				var maxRightXPos:Number = rectEnd.x + rectEnd.width;
				var minLeftXPos:Number = rectStart.x;;
				var i:int;
				
				for (i = startLineIndex + 1; i < endLineIndex; i++)
				{
					//不包括起始行和结束行的各行的第一个字符索引
					var lineFirstIndex:int = ta.textFlow.flowComposer.getLineAt(i).absoluteStart;
					
					//各行的字符总数
					var lineTextLength:int = ta.textFlow.flowComposer.getLineAt(i).textLength;
					
					//各行的最后一个字符索引
					var lineLastIndex:int = lineFirstIndex + lineTextLength - 1;
					
					var lineFirstIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineFirstIndex, ta);
					var lineLastIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineLastIndex, ta);
					
					if (lineFirstIndexRect.x < minLeftXPos)
						minLeftXPos = lineFirstIndexRect.x;
					if ((lineLastIndexRect.x + lineLastIndexRect.width) > maxRightXPos)
						maxRightXPos = lineLastIndexRect.x + lineLastIndexRect.width;
				}
				if (endLineFirstIndexRect.x < minLeftXPos)
					minLeftXPos = endLineFirstIndexRect.x;
				if (startLineLastIndexRect.x + startLineLastIndexRect.width> maxRightXPos)
					maxRightXPos = startLineLastIndexRect.x + startLineLastIndexRect.width;
							
				this.graphics.moveTo(0, 0 - offsetY);
				this.graphics.lineTo(maxRightXPos - rectStart.x, 0 - offsetY);
				this.graphics.lineTo(maxRightXPos - rectStart.x, rectEnd.y - rectStart.y - offsetY * 12);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y - rectStart.y - offsetY * 12);
				this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y - rectStart.y + rectEnd.height + offsetY * 4);
				this.graphics.lineTo(minLeftXPos -rectStart.x, rectEnd.y - rectStart.y + rectEnd.height + offsetY * 4);
				this.graphics.lineTo(minLeftXPos -rectStart.x, rectStart.height + offsetY * 12);
				this.graphics.lineTo(0, rectStart.height + offsetY * 12);
				this.graphics.lineTo(0, 0 - offsetY);
				
            }
            this.graphics.endFill();

            this.x = rectStart.x + ta.x;
            this.y = rectStart.y + ta.y;

        }
    }
}