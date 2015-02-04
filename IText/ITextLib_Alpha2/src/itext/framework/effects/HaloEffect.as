package itext.framework.effects
{
    import com.greensock.TweenMax;
    import com.greensock.easing.Bounce;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    import com.jing.utils.TextAreaUtil;

    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    import spark.components.Application;
    import spark.components.TextArea;

    /**
     *光晕效果特效
     * @data 2010-07-06
     * @author Jing
     *
     */
    public class HaloEffect extends UIComponent
    {
        /**
         *光晕特效构造函数
         * @param beginIndex 文本开始索引
         * @param endIndex 文本结束索引
         * @param ta 文本框
         * @param bm 文本框截图
         *
         */
        public function HaloEffect(beginIndex:int, endIndex:int, ta:TextArea, bm:Bitmap)
        {
            super();

            this.mouseEnabled = false;

            this.addChild(bm);
            bm.filters = [new GlowFilter()];

            TweenMax.to(bm, 1, {glowFilter: {color: 0x91e600, alpha: 1, blurX: 30, blurY: 30}, onComplete: onTweenOver});


            var rectStart:Rectangle = TextAreaUtil.getBoundRectOfIndex(beginIndex, ta);
            var rectEnd:Rectangle = TextAreaUtil.getBoundRectOfIndex(endIndex - 1, ta);

            this.x = ta.x;
            this.y = rectStart.y + ta.y;
        }

        private function onTweenOver():void
        {
            while (this.numChildren > 0)
            {
                this.removeChildAt(0);
            }
            PopUpManager.removePopUp(this);
        }
    }
}