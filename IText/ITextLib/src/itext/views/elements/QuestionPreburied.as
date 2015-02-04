package itext.views.elements
{
    import flash.display.DisplayObject;
    import flash.filters.GlowFilter;
    import flash.net.FileFilter;

    import itext.framework.IconFactory;
    import itext.vo.QuestionVO;

    import mx.core.UIComponent;

    /**
     *预埋的问题
     * @author Jing
     *
     */
    public class QuestionPreburied extends UIComponent
    {
        private var _state:String = UNACTIVATION;

        public function get state():String
        {
            return _state;
        }

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

        public function QuestionPreburied(vo:QuestionVO)
        {
            super();
            this.buttonMode = true;

            _vo = vo;
            questionIcon = IconFactory.getQuestionIcon();
            this.addChild(questionIcon);
            questionIcon.y = -questionIcon.height;
            this.width = questionIcon.width;
            this.height = questionIcon.height;
			
			changeState(UNACTIVATION);
        }

        /**
         * to change the view state of this ui
         * @param state
         *
         */
        public function changeState(state:String):void
        {
            _state = state;

            switch (state)
            {
                case UNACTIVATION:
                    this.filters = [new GlowFilter(0xFF0000)];
                    break;
                case ACTIVATION:
                    this.filters = [new GlowFilter(0xFFFF00)];
                    break;
                case TERMINATION:
                    this.filters = [new GlowFilter(0x00FF00)];
                    break;
            }
        }

        //未激活状态
        static public const UNACTIVATION:String = "unactivation";

        //激活状态
        static public const ACTIVATION:String = "activation";

        //结束状态
        static public const TERMINATION:String = "termination";
    }
}