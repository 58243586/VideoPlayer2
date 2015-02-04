package itext.tools
{
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import itext.components.TextArea;
    import itext.views.elements.RectBlock;

    /**
     *用来挡住文本的色块，根据属性生成挡住指定文字的颜色块
     * @author Jing
     *
     */
    public class TextShadeBlock extends Sprite
    {
        private var rectBlocks:Vector.<RectBlock> = new Vector.<RectBlock>();

        public function TextShadeBlock(color:uint, alpha:Number, ta:TextArea, beginIndex:int, endIndex:int)
        {
            super();
            update(beginIndex, endIndex, ta, color, alpha);
        }

        /**
         *
         * @param beginIndex
         * @param endIndex
         * @param ta
         *
         */
        public function update(beginIndex:int, endIndex:int, ta:TextArea, color:uint, alpha:Number):void
        {
            for (var i:int = 0; i < rectBlocks.length; i++)
            {
                this.removeChild(rectBlocks[i]);
            }
            rectBlocks.length = 0;

            var beginRect:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
            var endRect:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

            //起始行数
            var startLineIndex:int = ta.getTextField().getLineIndexOfChar(beginIndex);
            //结束行数
            var endLineIndex:int = ta.getTextField().getLineIndexOfChar(endIndex - 1);

            var rectBlock1:RectBlock = null;
            var rectBlock2:RectBlock = null;
            var rectBlock3:RectBlock = null;

            var distance:int = endLineIndex - startLineIndex;

            if (distance == 0)
            {
                rectBlock1 = new RectBlock();
                rectBlock1.update(endRect.x + endRect.width - beginRect.x, beginRect.height, color, alpha);
                rectBlocks.push(rectBlock1);
                this.addChild(rectBlock1);
            }
            else if (distance == 1)
            {
                //顶层
                rectBlock1 = new RectBlock();
                //底层
                rectBlock2 = new RectBlock();

                rectBlock1.update(ta.width - beginRect.x, beginRect.height, color, alpha);
                this.addChild(rectBlock1);

                rectBlock2.update(endRect.x + endRect.width, endRect.height, color, alpha);
                rectBlock2.x = -beginRect.x;
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
                //中层
                rectBlock3 = new RectBlock();

                rectBlock1.update(ta.width - beginRect.x, beginRect.height, color, alpha);
                this.addChild(rectBlock1);

                rectBlock2.update(endRect.x + endRect.width, endRect.height, color, alpha);
                rectBlock2.x = -beginRect.x;
                rectBlock2.y = endRect.y - beginRect.y;
                this.addChild(rectBlock2);

                rectBlock3.update(ta.width, endRect.y - (beginRect.y + beginRect.height), color, alpha);
                rectBlock3.x = -beginRect.x;
                rectBlock3.y = beginRect.height;
                this.addChild(rectBlock3);

                rectBlocks.push(rectBlock1, rectBlock2, rectBlock3);
            }
        }

    }
}