package itext.views.playerElements
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    
    import mx.controls.Alert;
    import mx.controls.Button;
    import mx.controls.LinkButton;
    import mx.core.UIComponent;
    import mx.events.CloseEvent;
    
    import spark.components.Button;
    import spark.components.TextArea;

    public class NoteBorder extends UIComponent
    {
        private var _ui:NoteBoxUI = new NoteBoxUI();

        public function set value(input:String):void
        {
			_ui.textNote.text = input;
        }

        public function get value():String
        {
            return _ui.textNote.text;
        }

        public function NoteBorder(borderColor:uint)
        {
            super();

            this.addChild(_ui);

			_ui.btnClose.addEventListener(MouseEvent.CLICK, frameClose_clickHandler);
			_ui.btnDel.addEventListener(MouseEvent.CLICK, frameDel_clickHandler);
        }

        private function frameClose_clickHandler(e:MouseEvent):void
        {
            this.parent.addChild(this);
            TweenLite.to(this, 0.2, {scaleY: 0, scaleX: 0, onComplete: close});
        }

        private function frameDel_clickHandler(e:MouseEvent):void
        {
            Alert.show("是否确定删除注释！", "删除提示！", Alert.YES | Alert.NO, null, onFrameDel);
        }

        private function onFrameDel(e:CloseEvent):void
        {
            if (e.detail == Alert.YES)
            {
                del();
            }
        }

        public function close():void
        {
            if (this.parent != null)
            {
				_ui.btnClose.removeEventListener(MouseEvent.CLICK, frameClose_clickHandler);
                this.parent.removeChild(this);
            }
            this.dispatchEvent(new Event(HIDDEN));
        }

        public function del():void
        {
            this.dispatchEvent(new Event(DEL));
        }

        static public const HIDDEN:String = "hidden";

        static public const DEL:String = "del";
    }
}