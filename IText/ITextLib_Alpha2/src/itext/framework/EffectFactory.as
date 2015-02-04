package itext.framework
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    import itext.constants.EffectTypeConstant;
    import com.jing.utils.TextAreaUtil;
    import itext.framework.effects.ExtrusionEffect;
    import itext.framework.effects.FlashingEffect;
    import itext.framework.effects.HaloEffect;
    import itext.vo.EffectVO;

    import mx.core.UIComponent;

    import spark.components.TextArea;

    /**
     *特效效果工厂
     * @author Jing
     *
     */
    public class EffectFactory
    {
        static public function getEffect(effectVO:EffectVO, ta:TextArea):UIComponent
        {
            var effect:UIComponent = null;

            switch (effectVO.effectType)
            {
                case EffectTypeConstant.CHANGE_COLOR:
                    effect = getHaloEffect(effectVO.beginIndex, effectVO.endIndex, ta, getBitmapCut(effectVO.beginIndex, effectVO.endIndex, ta));
                    break;
                case EffectTypeConstant.DISTORTION:
                    effect = getExtrusionEffect(effectVO.beginIndex, effectVO.endIndex, ta, getBitmapCut(effectVO.beginIndex, effectVO.endIndex, ta));
                    break;
                case EffectTypeConstant.FLASH:
                    effect = getFlashingEffect(effectVO.beginIndex, effectVO.endIndex, ta, getBitmapCut(effectVO.beginIndex, effectVO.endIndex, ta));
                    break;
            }
            return effect;
        }

        /**
         *得到文字的切片
         * @param beginIndex
         * @param endIndex
         * @param ta
         * @return
         *
         */
        static public function getBitmapCut(beginIndex:int, endIndex:int, ta:TextArea):Bitmap
        {
            var rectStart:Rectangle = TextAreaUtil.getBoundRectOfIndex(beginIndex, ta);
            var rectEnd:Rectangle = TextAreaUtil.getBoundRectOfIndex(endIndex - 1, ta);

            //起始行数
            var startLineIndex:int = ta.textFlow.flowComposer.findLineIndexAtPosition(beginIndex);
            //结束行数
            var endLineIndex:int = ta.textFlow.flowComposer.findLineIndexAtPosition(endIndex - 1);

            var bmd:BitmapData = new BitmapData(ta.width, rectEnd.y + rectEnd.height - rectStart.y, true, 0x00FFFFFF);

            var matrix:Matrix = new Matrix();

            matrix.ty = -rectStart.y;
            bmd.draw(ta, matrix);

            var i:int = 0;
            var j:int = 0;

            //delete a part no need to use at the front			
            for (i = 0; i < rectStart.x; i++)
            {
                for (j = 0; j < rectStart.height; j++)
                {
                    bmd.setPixel32(i, j, 0x00FFFFFF);
                }
            }

            for (i = rectEnd.x + rectEnd.width; i < bmd.width; i++)
            {
                for (j = rectEnd.y - rectStart.y; j < rectEnd.y - rectStart.y + rectEnd.height; j++)
                {
                    bmd.setPixel32(i, j, 0x00FFFFFF);
                }
            }

            var backgroundColor:uint = ta.getStyle("contentBackgroundColor");

            for (i = 0; i < bmd.width; i++)
            {
                for (j = 0; j < bmd.height; j++)
                {
                    if (bmd.getPixel(i, j) == backgroundColor)
                    {
                        bmd.setPixel32(i, j, 0x00FFFFFF);
                    }
                }
            }

            var bm:Bitmap = new Bitmap(bmd);

            return bm;
        }


        static private function getHaloEffect(beginIndex:int, endIndex:int, ta:TextArea, bm:Bitmap):UIComponent
        {
            return new HaloEffect(beginIndex, endIndex, ta, bm);
        }

        static private function getExtrusionEffect(beginIndex:int, endIndex:int, ta:TextArea, bm:Bitmap):UIComponent
        {
            return new ExtrusionEffect(beginIndex, endIndex, ta, bm);
        }

        static private function getFlashingEffect(beginIndex:int, endIndex:int, ta:TextArea, bm:Bitmap):UIComponent
        {
            return new FlashingEffect(beginIndex, endIndex, ta, bm);
        }
    }
}