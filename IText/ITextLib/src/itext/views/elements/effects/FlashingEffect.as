package itext.views.elements.effects
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;
    import com.greensock.TweenMax;
    import com.greensock.easing.Bounce;
    import com.greensock.easing.Circ;
    import com.greensock.loading.LoaderMax;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.filters.GlowFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import itext.components.TextArea;
    import itext.tools.TextShadeBlock;

    import mx.core.UIComponent;
    import mx.managers.PopUpManager;


    /**
     *
     * @author Jing
     *
     */
    public class FlashingEffect extends UIComponent
    {
        public function FlashingEffect(beginIndex:int, endIndex:int, ta:TextArea, bm:Bitmap)
        {
            super();

            this.mouseEnabled = false;
            this.mouseChildren = false;

            var textShadeBlock:TextShadeBlock = new TextShadeBlock(0xFFFFFF, 1, ta, beginIndex, endIndex);
            this.addChild(textShadeBlock);

            var timeline:TimelineLite = new TimelineLite();
            timeline.append(new TweenLite(textShadeBlock, 0.2, {alpha: 0}));
            timeline.append(new TweenLite(textShadeBlock, 0.2, {alpha: 1}));
			timeline.append(new TweenLite(textShadeBlock, 0.2, {alpha: 0}));
			timeline.append(new TweenLite(textShadeBlock, 0.2, {alpha: 1}));
            timeline.append(new TweenLite(textShadeBlock, 0.2, {alpha: 0, onComplete: onTweenOver}));

            var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
            var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

            textShadeBlock.x = rectStart.x;
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