package itext.views.elements
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    import itext.components.TextArea;

    import mx.controls.Alert;
    import mx.controls.Button;
    import mx.controls.LinkButton;
    import mx.core.UIComponent;
    import mx.events.CloseEvent;

    import spark.components.Button;

    public class NoteBorder extends UIComponent
    {
        private var _ui:NoteBorderUI = new NoteBorderUI();

        private var _textField:TextArea = new TextArea();

        private var _btnHide:LinkButton = new LinkButton();

        private var _noteMenu:NoteBorderMenuUI = new NoteBorderMenuUI();

        public function set value(input:String):void
        {
            _textField.text = input;
        }

        public function get value():String
        {
            return _textField.text;
        }

        public function NoteBorder(borderColor:uint)
        {
            super();

            this.addChild(_ui);
            _ui.width = 230;
            _ui.height = 120;
            _textField.width = 200;
            _textField.height = 80;

            this.addChild(_textField);

            _textField.x = (_ui.width - _textField.width) / 2 + 5;
            _textField.y = _ui.height - _textField.height - 15;
            _textField.text = "输入注释内容";

            initMenuButtonEffect(_noteMenu.frameClose);
            initMenuButtonEffect(_noteMenu.frameDel);

            _noteMenu.frameClose.addEventListener(MouseEvent.CLICK, frameClose_clickHandler);
            _noteMenu.frameDel.addEventListener(MouseEvent.CLICK, frameDel_clickHandler);

            this.addChild(_noteMenu);
            _noteMenu.x = _ui.width - _noteMenu.width - 5;
            _noteMenu.y = 5;
        }

        private function initMenuButtonEffect(spr:Sprite):void
        {
            spr.alpha = 0;
            spr.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            spr.buttonMode = true;
        }

        private function rollOverHandler(e:MouseEvent):void
        {
            var spr:Sprite = e.currentTarget as Sprite;
            spr.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);

            TweenLite.to(spr, 0.3, {alpha: 1});
        }

        private function rollOutHandler(e:MouseEvent):void
        {
            var spr:Sprite = e.currentTarget as Sprite;
            spr.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);

            TweenLite.to(spr, 0.5, {alpha: 0});
        }



        private function frameClose_clickHandler(e:MouseEvent):void
        {
            this.parent.addChild(this);
            TweenLite.to(this, 0.2, {scaleY: 0, scaleX: 0, onComplete: close});
//            close();
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
                _noteMenu.frameClose.removeEventListener(MouseEvent.CLICK, frameClose_clickHandler);
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