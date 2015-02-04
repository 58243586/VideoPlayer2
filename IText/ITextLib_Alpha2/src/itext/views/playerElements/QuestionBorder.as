package itext.views.playerElements
{
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    import mx.core.UIComponent;

    /**
     *问题框
     * @author Jing
     *
     */
    public class QuestionBorder extends UIComponent
    {
        private var _ui:QuestionShowBorderUI = new QuestionShowBorderUI();

        private var textField:TextField = new TextField();

        public function QuestionBorder()
        {
            super();
            init();
        }

        private function init():void
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this.addChild(_ui);
            this.addChild(textField);
            textField.autoSize = TextFieldAutoSize.LEFT;
        }

        public function get content():String
        {
            return textField.text;
        }

        public function set content(value:String):void
        {
            textField.text = value;
            update();
        }

        public function update():void
        {
            _ui.width = textField.width + 20;
            _ui.height = textField.height + 10;

            _ui.x = 0;
            _ui.y = 0;

            textField.x = (_ui.width - textField.width) / 2;
            textField.y = (_ui.height - textField.height) / 2;
        }

    }
}