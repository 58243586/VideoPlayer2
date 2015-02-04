package itext.views.editerElements
{
    import mx.core.UIComponent;

    /**
     *答案设置按钮
     * @author Jing
     *
     */
    public class AnswerSetButton extends UIComponent
    {
        private var btnMC:AnswerSetButtonUI = null;

        public function AnswerSetButton()
        {
            super();
			btnMC = new AnswerSetButtonUI();
			this.addChild(btnMC);
        }
    }
}