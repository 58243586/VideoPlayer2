package itext.views.elements
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;
    
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    
    import itext.components.TextArea;
    import itext.events.NoteSignEvent;
    import itext.views.InTextPlayer;
    import itext.vo.NoteVO;
    
    import mx.core.UIComponent;
    
    import spark.components.Group;

    public class NoteSign extends UIComponent
    {
        private var _ui:NoteSignUI = new NoteSignUI();

        private var _vo:NoteVO = null;

        public function get vo():NoteVO
        {
            return _vo;
        }


        private var _color:uint = 0;

        public function get color():uint
        {
            return _color;
        }

        public function set color(value:uint):void
        {
            var ct:ColorTransform = new ColorTransform();
            ct.color = value;
            _ui.flag.transform.colorTransform = ct;

            _color = value;
        }

        private var noteBorder:NoteBorder = null;


        public function NoteSign(vo:NoteVO)
        {
            super();
            this._vo = vo;
            color = _vo.color;
            this.addChild(_ui);

            this.mouseEnabled = false;
            _ui.buttonMode = true;
            _ui.addEventListener(MouseEvent.CLICK, clickHandler);
            clickHandler(null);
        }

        private function clickHandler(e:MouseEvent):void
        {
            if (this.owner != null)
            {
                (this.owner as InTextPlayer).addElement(this);
            }

            if (noteBorder == null)
            {
                noteBorder = new NoteBorder(_vo.color);
                noteBorder.value = _vo.content;
                noteBorder.addEventListener(NoteBorder.HIDDEN, noteBorder_hiddenHandler);
                noteBorder.addEventListener(NoteBorder.DEL, noteBorder_delHandler);
                this.addChild(noteBorder);
                noteBorder.x = _ui.width;

                TweenLite.from(noteBorder, 0.3, {scaleY: 0, scaleX: 0, ease: Back.easeOut});
            }
            else
            {
                noteBorder.close();
            }
        }

        /**
         *打开注释框
         *
         */
        public function openNoteBorder():void
        {
            if (noteBorder == null)
            {
                noteBorder = new NoteBorder(_vo.color);
                noteBorder.value = _vo.content;
                noteBorder.addEventListener(NoteBorder.HIDDEN, noteBorder_hiddenHandler);
                noteBorder.addEventListener(NoteBorder.DEL, noteBorder_delHandler);
                this.addChild(noteBorder);
                noteBorder.x = _ui.width;
            }
        }

        private function noteBorder_delHandler(e:Event):void
        {
            this.dispatchEvent(new NoteSignEvent(NoteSignEvent.DEL_NOTE, this._vo));
        }

        private function noteBorder_hiddenHandler(e:Event):void
        {
            _vo.content = noteBorder.value;
            noteBorder = null;
        }

        public function update(ta:TextArea):void
        {
            var rect:Rectangle = ta.getTextField().getCharBoundaries(_vo.noteIndex);

            var offX:Number = 0;

            if (rect == null)
            {
                ta.getTextField().length;
                ta.getTextField().text.length;
                rect = ta.getTextField().getCharBoundaries(_vo.noteIndex - 2);

                offX = rect.width;
            }

            if (rect != null)
            {
                this.x = rect.x + offX + ta.x;
                this.y = rect.y + ta.y;
            }

        }
    }
}