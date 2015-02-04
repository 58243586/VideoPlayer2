package itext.views.editerElements.marks
{
    import flash.display.DisplayObject;

    import itext.framework.IconFactory;

    import mx.core.FlexSprite;
    import mx.core.UIComponent;

    import itext.vo.QuestionVO;

    public class QuestionMark extends UIComponent
    {
        private var flexSprite:FlexSprite = new FlexSprite();

        private var questionIcon:DisplayObject = null;

        private var _vo:QuestionVO = null;

        public function get vo():QuestionVO
        {
            return _vo;
        }

        public function set vo(value:QuestionVO):void
        {
            _vo = value;
        }

        public function QuestionMark(vo:QuestionVO)
        {
            super();
            this.mouseEnabled = false;
			this.mouseChildren = true;
			
            questionIcon = IconFactory.getQuestionIcon();
            flexSprite.buttonMode = true;
            flexSprite.addChild(questionIcon);
            this.addChild(flexSprite);
            flexSprite.y = -flexSprite.height;
			flexSprite.x = -flexSprite.width;
            _vo = vo;

            this.width = questionIcon.width;
            this.height = questionIcon.height;
			
        }
    }
}