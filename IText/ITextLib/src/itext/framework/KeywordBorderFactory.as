package itext.framework
{
	import itext.components.TextArea;

	import flash.geom.Rectangle;

	import mx.core.UIComponent;

	import itext.views.elements.keywordBorders.KeywordDoubleUnderLineBorder;
	import itext.views.elements.keywordBorders.KeywordRectBorder;
	import itext.views.elements.keywordBorders.KeywordUnderLineBorder;

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

		//下划线
		static public const UNDERLINE:String = "Underline";

		//下划双线
		static public const DOUBLE_UNDERLINE:String = "DoubleUnderline";

		//边框
		static public const BORDER:String = "Border";

		//背景框
		static public const BACKGROUND:String = "Background";
	}
}