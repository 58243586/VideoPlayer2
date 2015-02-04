package itext.framework
{
    import flash.geom.Rectangle;

    import itext.framework.keywordBorders.KeywordDottedLineBorder;
    import itext.framework.keywordBorders.KeywordDoubleUnderLineBorder;
    import itext.framework.keywordBorders.KeywordRectBorder;
    import itext.framework.keywordBorders.KeywordUnderLineBorder;
    import itext.framework.keywordBorders.KeywordWavyLineBorder;

    import mx.core.UIComponent;

    import spark.components.TextArea;

    /**
     *关键词句边框工厂
     * @author jing
     *
     */
    public class KeywordBorderFactory
    {
        public function KeywordBorderFactory()
        {
        }

        /**
         *得到关键词的边框
         * @param type 边框类型
         * @param color 边框颜色
         * @param beginIndex 开始的字符索引
         * @param endIndex 结束的字符索引
         * @param textArea 文本框
         * @return
         *
         */
        static public function getKeywordBorder(type:String, color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            var border:UIComponent = null;

            switch (type)
            {
                case UNDERLINE:
                    border = getUnderLine(color, beginIndex, endIndex, textArea);
                    break;
                case DOUBLE_UNDERLINE:
                    border = getDoubleUnderline(color, beginIndex, endIndex, textArea);
                    break;
                case BORDER:
                    border = getBorder(color, beginIndex, endIndex, textArea);
                    break;
                case BACKGROUND:
                    border = getBackground(color, beginIndex, endIndex, textArea);
                    break;
                case WAVELINE:
                    border = getWaveline(color, beginIndex, endIndex, textArea);
                    break;
                case DOTTED_LINE:
                    border = getDottedLine(color, beginIndex, endIndex, textArea);
                    break;
            }
            return border;
        }

        static private function getUnderLine(color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            return new KeywordUnderLineBorder(color, beginIndex, endIndex, textArea);
        }

        static private function getDoubleUnderline(color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            return new KeywordDoubleUnderLineBorder(color, beginIndex, endIndex, textArea);
        }

        static private function getBorder(color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            return new KeywordRectBorder(color, beginIndex, endIndex, textArea);
        }

        static private function getBackground(color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            return new KeywordRectBorder(color, beginIndex, endIndex, textArea, true);
        }

        static private function getWaveline(color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            return new KeywordWavyLineBorder(color, beginIndex, endIndex, textArea);
        }

        static private function getDottedLine(color:uint, beginIndex:int, endIndex:int, textArea:TextArea):UIComponent
        {
            return new KeywordDottedLineBorder(color, beginIndex, endIndex, textArea);
        }

        /**
         *下划线
         */
        static public const UNDERLINE:String = "Underline";

        /**
         *双下划线
         */
        static public const DOUBLE_UNDERLINE:String = "DoubleUnderline";

        /**
         *边框
         */
        static public const BORDER:String = "Border";

        /**
         *背景框
         */
        static public const BACKGROUND:String = "Background";

        /**
         *波浪线
         */
        static public const WAVELINE:String = "waveline";

        /**
         *虚线
         */
        static public const DOTTED_LINE:String = "dottedLine";
    }
}