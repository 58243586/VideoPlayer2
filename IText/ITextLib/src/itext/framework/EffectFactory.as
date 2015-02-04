package itext.framework
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    import itext.components.TextArea;
    import itext.constants.EffectTypeConstant;
    import itext.views.elements.effects.ExtrusionEffect;
    import itext.views.elements.effects.FlashingEffect;
    import itext.views.elements.effects.HaloEffect;
    import itext.vo.EffectVO;
    
    import mx.core.UIComponent;

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

			switch(effectVO.effectType)
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
			
//            if (effectVO.effectType == 0)
//            {
//                switch (effectVO.effectAction)
//                {
//                    case 0:
//                        effect = getHaloEffect(effectVO.beginIndex, effectVO.endIndex, ta, getBitmapCut(effectVO.beginIndex, effectVO.endIndex, ta));
//                        break;
//                }
//            }
//            else if (effectVO.effectType == 1)
//            {
//                switch (effectVO.effectAction)
//                {
//                    case 0:
//                        effect = getExtrusionEffect(effectVO.beginIndex, effectVO.endIndex, ta, getBitmapCut(effectVO.beginIndex, effectVO.endIndex, ta));
//                        break;
//                }
//            }
//            else if (effectVO.effectType == 2)
//            {
//                switch (effectVO.effectAction)
//                {
//                    case 0:
//                        break;
//                }
//            }


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
            var rectStart:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
            var rectEnd:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);

            //起始行数
            var startLineIndex:int = ta.getTextField().getLineIndexOfChar(beginIndex);
            //结束行数
            var endLineIndex:int = ta.getTextField().getLineIndexOfChar(endIndex - 1);

            //            var bmd:BitmapData = new BitmapData(rectEnd.x + rectEnd.width - rectStart.x, rectEnd.height, true, 0x00000000);

            var bmd:BitmapData = new BitmapData(ta.width, rectEnd.y + rectEnd.height - rectStart.y, true, 0x00FFFFFF);



            var matrix:Matrix = new Matrix();
            //            matrix.tx = -rectStart.x;


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