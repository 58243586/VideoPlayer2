package itext.framework.keywordBorders
{
    import flash.geom.Rectangle;

    import com.jing.utils.TextAreaUtil;

    import mx.core.UIComponent;

    import spark.components.TextArea;

	/**
	 *关键词的下划线边框
	 * @data 2010-07-06 
	 * @author Jing
	 * 
	 */	
    public class KeywordUnderLineBorder extends UIComponent
    {
		/**
		 * 关键词下划线构造函数
		 * @param color 下划线颜色
		 * @param beginIndex 在文本中开始的字符索引
		 * @param endIndex 在文本中结束的字符索引
		 * @param ta 文本框
		 * 
		 */		
        public function KeywordUnderLineBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea)
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

            this.graphics.beginFill(color);
            this.graphics.lineStyle(2, color);

            var distance:int = endLineIndex - startLineIndex;

            var offsetY:int = 3;

            if (distance == 0)
            {
                this.graphics.moveTo(0, rectStart.height + offsetY);
                this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectStart.height + offsetY);
            }
            else
            {
                this.graphics.moveTo(0, rectStart.height + offsetY);
                this.graphics.lineTo(startLineLastIndexRect.x +startLineLastIndexRect.width - rectStart.x, rectStart.height + offsetY);

                for (var i:int = startLineIndex + 1; i < endLineIndex; i++)
                {
					//非起始行和结束行的中间各行的第一个字符索引
					var lineFirstIndex:int = ta.textFlow.flowComposer.getLineAt(i).absoluteStart;
					
					//中间各行的字符总数
					var lineTextLength:int = ta.textFlow.flowComposer.getLineAt(i).textLength;
					
					//中间各行的最后一个字符索引
					var lineLastIndex:int = lineFirstIndex + lineTextLength - 1;
					
					var lineFirstIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineFirstIndex, ta);
					var lineLastIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineLastIndex, ta);

                    this.graphics.moveTo(lineFirstIndexRect.x - rectStart.x, lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY);
                    this.graphics.lineTo(lineLastIndexRect.x + lineLastIndexRect.width - rectStart.x, lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY);
                }
                this.graphics.moveTo(endLineFirstIndexRect.x - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
                this.graphics.lineTo(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
            }


            this.graphics.endFill();

            this.x = rectStart.x + ta.x;
            this.y = rectStart.y + ta.y;

        }
    }
}