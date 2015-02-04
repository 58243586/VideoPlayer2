package itext.views.elements
{
    import com.greensock.TweenLite;

    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    import spark.components.Label;

    public class AnswerTip extends UIComponent
    {
        private var background:AnswerTipUI = new AnswerTipUI();

        private var label:TextField = new TextField();

        public function AnswerTip(isAnswerOver:Boolean = false)
        {
            super();
            this.addChild(background);
            label.text = (isAnswerOver == false) ? "选中了一个正确答案" : "选中了所有的答案";
            this.addChild(label);
            label.autoSize = TextFieldAutoSize.LEFT;

            background.width = label.width + 20;
            background.height = label.height + 10;
            label.x = (background.width - label.width) / 2;
            label.y = (background.height - label.height) / 2;

            this.height = background.height;
            this.width = background.width;
        }

        public function show():void
        {
            TweenLite.to(this, 5, {y: "-20", alpha: 0, onComplete: onShow});
        }

        private function onShow():void
        {
            PopUpManager.removePopUp(this);
        }


    }
}