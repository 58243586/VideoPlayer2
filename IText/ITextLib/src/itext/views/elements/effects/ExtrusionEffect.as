package itext.views.elements.effects
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Bounce;
    import com.greensock.easing.Circ;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import itext.components.TextArea;
    import itext.tools.TextShadeBlock;
    
    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    /**
     *挤压特效
     * @author Jing
     *
     */
    public class ExtrusionEffect extends UIComponent
    {
        private var _bm:Bitmap = null;

        public function ExtrusionEffect(beginIndex:int, endIndex:int, ta:TextArea, bm:Bitmap)
        {
            super();

            this.mouseEnabled = false;

            _bm = bm;

			var textShadeBlock:TextShadeBlock = new TextShadeBlock(0xFFFFFF, 1, ta, beginIndex, endIndex);
			this.addChild(textShadeBlock);


            this.addChild(bm);

            var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
            var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

            TweenLite.to(bm, 0.5, {scaleX: 1.2, scaleY: 1.2, onUpdate: onTweenUpdate, onComplete: onTweenSmall, ease: Circ.easeOut});

			textShadeBlock.x = rectStart.x;
            this.x = ta.x;
            this.y = rectStart.y + ta.y;
        }

        private function onTweenUpdate():void
        {
//            _bm.x = (backBitmap.width - _bm.width) / 2;
//            _bm.y = (backBitmap.height - _bm.height) / 2;
        }

        private function onTweenSmall():void
        {
            TweenLite.to(_bm, 0.5, {scaleX: 1, scaleY: 1, onUpdate: onTweenUpdate, onComplete: onTweenOver, ease: Circ.easeOut});
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