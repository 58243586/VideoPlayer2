package itext.views.elements
{
	import flash.display.DisplayObject;
	
	import itext.framework.IconFactory;
	
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	
	import itext.vo.AnswerVO;

	public class AnswerMark extends UIComponent
	{
		private var flexSprite:FlexSprite = new FlexSprite();

		private var answerIcon:DisplayObject = null;

		private var _vo:AnswerVO = null;

		public function get vo():AnswerVO
		{
			return _vo;
		}

		public function set vo(value:AnswerVO):void
		{
			_vo = value;
		}


		public function AnswerMark(vo:AnswerVO)
		{
			super();
			
			answerIcon = IconFactory.getAnswerIcon();
			flexSprite.buttonMode = true;
			flexSprite.addChild(answerIcon);
			this.addChild(flexSprite);
			flexSprite.y = -flexSprite.height;
			_vo = vo;
			
			this.width = flexSprite.width;
			this.height = flexSprite.height;
		}
	}
}