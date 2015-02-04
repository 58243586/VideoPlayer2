package itext.framework
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    
    import mx.core.UIComponent;

    /**
     *图标获取工厂
     * @author Jing
     *
     */
    public class IconFactory
    {

        [Bindable]
        [Embed(source="./icons/ico_jt.png")]
        /**
         *静态效果的标志ICON
         * @return
         *
         */
        static public var ICO_JT:Class;

        [Bindable]
        [Embed(source="./icons/ico_da.png")]
        /**
         *静态效果的标志ICON
         * @return
         *
         */
        static public var ICO_DA:Class;

        [Bindable]
        [Embed(source="./icons/ico_wt_nomal.png")]
        static public var ICO_WT_NOMAL:Class;

        [Bindable]
        [Embed(source="./icons/ico_wt.png")]
        static public var ICO_WT:Class;

        [Bindable]
        [Embed(source="./imgs/AnswerIcon.png")]
        static public var ANSWER_ICON_CLASS:Class;

        [Bindable]
        [Embed(source="./icons/ico_dt.png")]
        static public var ICO_DT:Class;

        [Bindable]
        [Embed(source="./icons/ico_a.gif")]
        /**
         *表示文字字符A的ICON
         * @return
         *
         */
        static public var ICO_A:Class;
		
        [Bindable]
        [Embed(source="./icons/ico_texta.gif")]
        static public var ICO_TEXTA:Class;

        [Bindable]
        [Embed(source="./icons/ico_tastyle.gif")]
        static public var ICO_TASTYLE:Class;

        [Bindable]
        [Embed(source="./icons/ico_tacolor.gif")]
        static public var ICO_TACOLOR:Class;

        [Bindable]
        [Embed(source="./icons/ico_arrow.png")]
        static public var ICO_ARROW:Class;

        [Bindable]
        [Embed(source="./icons/ico_mouse.gif")]
        static public var ICO_MOUSE:Class;

        [Bindable]
        [Embed(source="./icons/ico_motion.gif")]
        static public var ICO_MOTION:Class;


        [Bindable]
        [Embed(source="./icons/ico_delete.png")]
        static public var ICO_DELETE:Class;

        [Bindable]
        [Embed(source="./imgs/text_bold_normal.png")]
        static public var TEXT_BOLD:Class;

        [Bindable]
        [Embed(source="./imgs/text_italic_normal.png")]
        static public var TEXT_ITALIC:Class;

        [Bindable]
        [Embed(source="./imgs/text_underline_normal.png")]
        static public var TEXT_UNDERLINE:Class;
		
		[Bindable]
		[Embed(source="./icons/ico_eraser_shadow.png")]
		static public var ICO_ERASER_SHADOW:Class;





        public function IconFactory()
        {
        }

        /**
         *得到一个类的对象
         * @param classObject
         * @return
         *
         */
        static public function getObject(classObject:Class):DisplayObject
        {
            var object:DisplayObject = new classObject() as DisplayObject;
            return object;
        }

        /**
         *得到一个问题答案的ICON标记
         * @return
         *
         */
        static public function getAnswerIcon():DisplayObject
        {
            var icon:DisplayObject = new ICO_DA();
            return icon;
        }

        /**
         *得到一个问题的ICON标记
         * @return
         *
         */
        static public function getQuestionIcon():DisplayObject
        {
            var icon:DisplayObject = new ICO_WT_NOMAL();
            return icon;
        }

        /**
         *得到一个效果的ICON标记
         * @return
         *
         */
        static public function getEffectIcon():DisplayObject
        {
            var icon:DisplayObject = new ICO_DT();
            return icon;
        }
    }
}