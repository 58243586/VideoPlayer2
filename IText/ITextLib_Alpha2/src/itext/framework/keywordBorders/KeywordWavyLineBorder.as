package itext.framework.keywordBorders
{
	import com.jing.utils.TextAreaUtil;
	
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import spark.components.TextArea;
	
	/**
	 *关键词的波浪线边框
	 * @data 2010-07-06 
	 * @author Jing
	 * 
	 */	
	public class KeywordWavyLineBorder extends UIComponent
	{
		/**
		 * 关键词波浪线构造函数
		 * @param color 波浪线颜色
		 * @param beginIndex 在文本中开始的字符索引
		 * @param endIndex 在文本中结束的字符索引
		 * @param ta 文本框
		 * 
		 */		
		public function KeywordWavyLineBorder(color:uint, beginIndex:int, endIndex:int, ta:TextArea)
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
			
			this.graphics.lineStyle(0.05, color);
			
			var distance:int = endLineIndex - startLineIndex;
						
			var offsetY:int = 3;
			
			var count:int = 0;			
			var i:int;			
			var sign:int;
			
			if (distance == 0)
			{
				this.graphics.moveTo(0, rectStart.height + offsetY);
				for (i = 0; i < rectEnd.x + rectEnd.width - rectStart.x; i = i + 4)
				{
					count++;
					sign = (count % 2) * 2 - 1;					
					this.graphics.curveTo(i + 2, rectStart.height + offsetY + 2 * sign, i + 4, rectStart.height + offsetY);
				}
			}
			else
			{
				this.graphics.moveTo(0, rectStart.height + offsetY);
				for ( i = 0; i < startLineLastIndexRect.x + startLineLastIndexRect.width - rectStart.x; i = i + 4)
				{
					count++;
					sign = (count % 2) * 2 - 1;	
					this.graphics.curveTo(i + 2, rectStart.height + offsetY + 2 * sign, i + 4, rectStart.height + offsetY);
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
					
					this.graphics.moveTo(lineFirstIndexRect.x -rectStart.x, lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY);
					for (i = lineFirstIndexRect.x - rectStart.x; i < lineLastIndexRect.x + lineLastIndexRect.width - rectStart.x; i = i + 4)
					{
						count++;
						sign = (count % 2) * 2 - 1;	
						this.graphics.curveTo(i + 2, lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY + 2 * sign, i + 4, lineFirstIndexRect.y + lineFirstIndexRect.height - rectStart.y + offsetY);
					}
				}
				
				this.graphics.moveTo(endLineFirstIndexRect.x -rectStart.x, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
				for (i = endLineFirstIndexRect.x - rectStart.x; i < rectEnd.x + rectEnd.width - rectStart.x; i = i + 4)
				{
					count++;
					sign = (count % 2) * 2 - 1;	
					this.graphics.curveTo(i + 2, rectEnd.y + rectEnd.height - rectStart.y + offsetY + 2 * sign, i + 4, rectEnd.y + rectEnd.height - rectStart.y + offsetY);
				}
			}
			
			this.x = rectStart.x + ta.x;
			this.y = rectStart.y + ta.y;
			
		}
	}
}