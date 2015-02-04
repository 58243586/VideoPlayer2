package itext.views.editerElements.marks
{
    import com.jing.utils.TextAreaUtil;
    
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import flash.text.engine.TextLine;
    
    import flashx.textLayout.compose.IFlowComposer;
    import flashx.textLayout.compose.TextFlowLine;
    
    import itext.framework.IconFactory;
    import itext.tools.RectBlock;
    import itext.vo.KeywordVO;
    
    import mx.controls.Image;
    import mx.core.FlexSprite;
    import mx.core.UIComponent;
    
    import spark.components.TextArea;

    /**
     *绘制显示关键词标注的可视元件
     * @author Jing
     *
     */
    public class KeywordMark extends UIComponent
    {
        //表示为关键词的ICON显示对象
        private var keywordIcon:DisplayObject = null;

        private var flexSprite:FlexSprite = new FlexSprite();

        //色块的集合
        private var rectBlocks:Vector.<RectBlock> = new Vector.<RectBlock>();

        //关键词的VO对象
        private var _vo:KeywordVO = null;

        public function get vo():KeywordVO
        {
            return _vo;
        }

        public function set vo(value:KeywordVO):void
        {
            _vo = value;
        }


        public function KeywordMark(vo:KeywordVO)
        {
            super();

            _vo = vo;

            this.mouseEnabled = false;
            this.mouseChildren = true;
            flexSprite.buttonMode = true;
            keywordIcon = IconFactory.getObject(IconFactory.ICO_JT);
            flexSprite.addChild(keywordIcon);
            this.addChild(flexSprite);

            //让坐标的原点是ICON的左下角
            flexSprite.y = -flexSprite.height;

            this.width = keywordIcon.width;
            this.height = keywordIcon.height;
        }

        /**
         * 根据传递的数据更新显示的形态
         * @param beginIndex 开始字符的索引
         * @param endIndex 结束字符的索引
         * @param ta TextArea对象
         *
         */
        public function update(beginIndex:int, endIndex:int, ta:TextArea):void
        {
            for (var i:int = 0; i < rectBlocks.length; i++)
            {
                this.removeChild(rectBlocks[i]);
            }
            rectBlocks.length = 0;
			
			var beginRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(beginIndex, ta);
			var endRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(endIndex - 1, ta);

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
			
			
			this.x = beginRect.x + ta.x;
			this.y = beginRect.y + ta.y;
			
			var rectBlock1:RectBlock = null;
			var rectBlock2:RectBlock = null;
			var rectBlock3:RectBlock = null;
			
			var distance:int = endLineIndex - startLineIndex;
			
			if (distance == 0)
			{
				rectBlock1 = new RectBlock();
				rectBlock1.update(endRect.x + endRect.width - beginRect.x, beginRect.height, 0x22abff, 0.3);
				rectBlocks.push(rectBlock1);
				this.addChild(rectBlock1);
			}
			else if (distance == 1)
			{
				//顶层
				rectBlock1 = new RectBlock();
				//底层
				rectBlock2 = new RectBlock();
				
				rectBlock1.update(startLineLastIndexRect.x + startLineLastIndexRect.width - beginRect.x, beginRect.height, 0x22abff, 0.3);
				this.addChild(rectBlock1);
				
				rectBlock2.update(endRect.x + endRect.width - endLineFirstIndexRect.x, endRect.height, 0x22abff, 0.3);
				rectBlock2.x = endLineFirstIndexRect.x - beginRect.x;
				rectBlock2.y = endRect.y - beginRect.y;
				this.addChild(rectBlock2);
				
				rectBlocks.push(rectBlock1, rectBlock2);
			}
			else if (distance > 1)
			{
				//顶层
				rectBlock1 = new RectBlock();
				//底层
				rectBlock2 = new RectBlock();
				
				rectBlock1.update(startLineLastIndexRect.x + startLineLastIndexRect.width - beginRect.x, beginRect.height, 0x22abff, 0.3);
				this.addChild(rectBlock1);
				
				rectBlock2.update(endRect.x + endRect.width - endLineFirstIndexRect.x, endRect.height, 0x22abff, 0.3);
				rectBlock2.x = endLineFirstIndexRect.x - beginRect.x;
				rectBlock2.y = endRect.y - beginRect.y;
				this.addChild(rectBlock2);
				
				rectBlocks.push(rectBlock1, rectBlock2);
				
				for (var j:int = startLineIndex + 1; j < endLineIndex; j++)
				{
					//中间各层
					rectBlock3 = new RectBlock();
					
					//不包括起始行和结束行的各行的第一个字符索引
					var lineFirstIndex:int = ta.textFlow.flowComposer.getLineAt(j).absoluteStart;
					
					//各行的字符总数
					var lineTextLength:int = ta.textFlow.flowComposer.getLineAt(j).textLength;
					
					//各行的最后一个字符索引
					var lineLastIndex:int = lineFirstIndex + lineTextLength - 1;
					
					var lineFirstIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineFirstIndex, ta);
					var lineLastIndexRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(lineLastIndex, ta);
					
					rectBlock3.update(lineLastIndexRect.x + lineLastIndexRect.width - lineFirstIndexRect.x, lineLastIndexRect.height, 0x22abff, 0.3);
					rectBlock3.x = lineFirstIndexRect.x - beginRect.x;
					rectBlock3.y = lineLastIndexRect.y - beginRect.y;
					this.addChild(rectBlock3);
					
					rectBlocks.push(rectBlock3);
				}              
			}
        }
    }
}