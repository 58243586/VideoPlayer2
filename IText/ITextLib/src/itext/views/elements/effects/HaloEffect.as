package itext.views.elements.effects
{
    import com.greensock.TweenMax;
    import com.greensock.easing.Bounce;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    import itext.components.TextArea;
    
    import mx.core.UIComponent;
    import mx.managers.PopUpManager;
    
    import spark.components.Application;

	/**
	 *光晕效果特效 
	 * @author Jing
	 * 
	 */	
    public class HaloEffect extends UIComponent
    {
        public function HaloEffect(beginIndex:int, endIndex:int, ta:TextArea,bm:Bitmap)
        {
            super();

            this.mouseEnabled = false;

            this.addChild(bm);
            bm.filters = [new GlowFilter()];

            TweenMax.to(bm, 1, {glowFilter: {color: 0x91e600, alpha: 1, blurX: 30, blurY: 30}, onComplete: onTweenOver});

            var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
            var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

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