package itext.framework.keywordBorders
{
	import com.jing.utils.TextAreaUtil;
	
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import spark.components.TextArea;
	
	/**
	 *关键词的虚线边框
	 * @data 2010-07-06 
	 * @author Jing
	 * 
	 */	
	public class KeywordDottedLineBorder extends UIComponent
	{
		/**
		 * 关键词虚线构造函数
		 * @param color 波浪线颜色
		 * @param beginIndex 在文本中开始的字符索引
		 * @param endIndex 在文本中结束的字符索引
		 * @param ta 文本框
		 * 
		 */		
		public function KeywordDottedLineBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea)
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
			
			this.graphics.lineStyle(1, color, 1.0, true);
			
			var distance:int = endLineIndex - startLineIndex;
			
			var offsetY:int = 2;
			
			var count:int = 0;			
			var i:int;			
			var sign:int;
			
			if (distance == 0)
			{
				for (i = 0; i < rectEnd.x + rectEnd.width - rectStart.x; i = i + 3)
				{
					count++;
					sign = count % 2;
					if (sign == 1)
					{						
						this.graphics.moveTo(i, rectStart.height + offsetY);
						this.graphics.lineTo(i + 3, rectStart.height + offsetY);
					}						
				}
			}
			else
			{				
				for ( i = 0; i < startLineLastIndexRect.x + startLineLastIndexRect.width - rectStart.x; i = i + 6)
				{
						this.graphics.moveTo(i, rectStart.height + offsetY);
						this.graphics.lineTo(i + 3, rectStart.height + offsetY);
				}
				
				for (var j:int = startLineIndex + 1; j < endLineIndex; j++)
				{
					//非起始行和结束行的中间各行的第一个字符索引
					var lineFirstIndex:int = ta.textFlow.flowComposer.getLineAt(j).absoluteStart;
					
					//中间各行的字符总数
					var lineTextLength:int = ta.textFlow.flowComposer.getLineAt(j).textLength;
					
					//中间各行的最后一个字符索引
					var lineLastIndex:int = lineFirstIndex + lineTextLength - 1;
					
					var lineFirstIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineFirstIndex, ta);
					var lineLastIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineLastIndex, ta);
					
					for (i = lineFirstIndexRect.x - rectStart.x; i < lineLastIndexRect.x + lineLastIndexRect.width - rectStart.x; i = i + 6)
					{
							this.graphics.moveTo(i , lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY);
							this.graphics.lineTo(i + 3, lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY);											
					}
				}				
				
				for (i = endLineFirstIndexRect.x - rectStart.x; i < rectEnd.x + rectEnd.width - rectStart.x; i = i + 6)
				{
						this.graphics.moveTo(i, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
						this.graphics.lineTo(i + 3, rectEnd.y + rectEnd.height - rectStart.y + offsetY);	
				}
			}
			
			this.x = rectStart.x + ta.x;
			this.y = rectStart.y + ta.y;
			
		}
	}
}