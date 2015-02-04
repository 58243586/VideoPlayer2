package itext.framework
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;

	import mx.core.UIComponent;

	public class IconFactory
	{

		[Embed(source="./imgs/KeywordIcon.png")]
		static public var KEYWORD_ICON_CLASS:Class;

		[Embed(source="./imgs/QuestionIcon.png")]
		static public var QUESTION_ICON_CLASS:Class;

		[Embed(source="./imgs/AnswerIcon.png")]
		static public var ANSWER_ICON_CLASS:Class;

		[Embed(source="./imgs/EffectIcon.png")]
		static public var EFFECT_ICON_CLASS:Class;

		public function IconFactory()
		{
		}

		/**
		 *得到一个关键词句的ICON标记 
		 * @return 
		 * 
		 */		
		static public function getKeywordIcon():DisplayObject
		{
			var icon:DisplayObject = new KEYWORD_ICON_CLASS();
			return icon;
		}

		/**
		 *得到一个问题答案的ICON标记 
		 * @return 
		 * 
		 */		
		static public function getAnswerIcon():DisplayObject
		{
			var icon:DisplayObject = new ANSWER_ICON_CLASS();
			return icon;
		}

		/**
		 *得到一个问题的ICON标记 
		 * @return 
		 * 
		 */		
		static public function getQuestionIcon():DisplayObject
		{
			var icon:DisplayObject = new QUESTION_ICON_CLASS();
			return icon;
		}

		/**
		 *得到一个效果的ICON标记 
		 * @return 
		 * 
		 */		
		static public function getEffectIcon():DisplayObject
		{
			var icon:DisplayObject = new EFFECT_ICON_CLASS();
			return icon;
		}
	}
}