package itext.views.editerElements
{
    import flash.display.MovieClip;

    import mx.core.UIComponent;

    /**
     *问题提示
     * @author Jing
     *
     */
    public class QAPrompting extends UIComponent
    {
        private var tipMC:QATipUI = null;

        public function QAPrompting()
        {
            super();
            tipMC = new QATipUI();
            this.addChild(tipMC);
			tipMC.gotoAndStop(1);
            this.width = tipMC.width;
        }

        public function changeState(value:int):void
        {
            if (tipMC.currentFrame != value)
            {
                tipMC.gotoAndStop(value);
            }
        }
    }
}