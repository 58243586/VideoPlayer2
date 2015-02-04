package itext.components
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Point;

    import itext.constants.PencilTypeConstant;

    import mx.core.UIComponent;
    import mx.managers.CursorManager;

    /**
     * the border for drawing
     * @author Jing
     *
     */
    public class Palette extends UIComponent
    {
//		private var pencilCursor:PencilCursorUI = new PencilCursorUI();

        private var lineAlpha:Number = 0.7;

        private var lines:Array = new Array();

        private var line:Array = null;

        private var _lineType:String = "";

        private var isDrawing:Boolean = false;

        public function get lineType():String
        {
            return _lineType;
        }

        public function set lineType(value:String):void
        {
            _lineType = value;
        }

        private var _lineColor:uint = 0xFF0000;

        public function get lineColor():uint
        {
            return _lineColor;
        }

        public function set lineColor(value:uint):void
        {
            _lineColor = value;

//			var ct:ColorTransform = new ColorTransform();
//			ct.color = value;
//			pencilCursor.cap.transform.colorTransform = ct;
//			pencilCursor.nib.transform.colorTransform = ct;
        }

        private var _lineSize:uint = 1;

        public function get lineSize():uint
        {
            return _lineSize;
        }

        public function set lineSize(value:uint):void
        {
            _lineSize = value;
        }

        private var _activation:Boolean = true;

        public function set activation(value:Boolean):void
        {
            _activation = value;
            this.mouseEnabled = value;
            this.mouseChildren = value;

            if (value == true)
            {
                this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            }
            else
            {
                cursorManager.removeAllCursors();
                this.removeEventListener(MouseEvent.ROLL_OVER, rollOutHandler);
            }
        }

        private function rollOutHandler(e:MouseEvent):void
        {
            cursorManager.removeAllCursors();
			this.endDraw();
            this.removeEventListener(MouseEvent.ROLL_OUT, rollOverHandler);
        }

        private function rollOverHandler(e:MouseEvent):void
        {
            cursorManager.setCursor(PencilCursorUI);
            this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
        }

        public function get activation():Boolean
        {
            return _activation;
        }

        public function Palette(width:int, height:int)
        {
            super();

            resize(width, height);
            init();
        }

        public function resize(width:int, height:int):void
        {
            this.width = width;
            this.height = height;

            redraw();
        }

        public function eraser():void
        {
            lines.pop();
            redraw();
        }

        //----------------内部方法---------------------

        private function redraw():void
        {
            this.graphics.clear();
            this.graphics.lineStyle(0, 0xFFFFFF, 0);
            this.graphics.beginFill(0xFFFFFF, 0);
            this.graphics.drawRect(0, 0, width, height);
            this.graphics.endFill();

            for (var i:int = 0; i < lines.length; i++)
            {
                drawLine(lines[i]);
            }
        }

        private function drawLine(line:Array):void
        {
            if (line != null)
            {
                this.graphics.moveTo(line[1].x, line[1].y);
                this.graphics.lineStyle(line[0].size, line[0].color, lineAlpha);

                for (var j:int = 2; j < line.length; j++)
                {
                    this.graphics.lineTo(line[j].x, line[j].y);
                }
            }
        }

        private function init():void
        {
            this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }

        private function mouseDownHandler(e:MouseEvent):void
        {
            beginDraw();
        }

        private function enterFrameHandler(e:Event):void
        {
            if (this.mouseX > 0 && this.mouseX < this.width && this.mouseY > 0 && this.mouseY < this.height)
            {
                var lienToX:Number = this.mouseX;
                var lineToY:Number = 0;

                if (lineType == PencilTypeConstant.STRAIGHT)
                {
                    lineToY = line[1].y;
                }
                else
                {
                    lineToY = this.mouseY
                }
                this.graphics.lineTo(lienToX, lineToY);

                line.push(new Point(lienToX, lineToY));
            }
            else
            {
                endDraw();
            }
        }

        private function mosueUpHandler(e:MouseEvent):void
        {
            endDraw();

        }

        public function beginDraw():void
        {
            isDrawing = true;
            line = new Array();
            line.push({color: _lineColor, size: _lineSize});
            line.push(new Point(this.mouseX, this.mouseY));

            this.graphics.moveTo(this.mouseX, this.mouseY);
            this.graphics.lineStyle(_lineSize, _lineColor, lineAlpha);
            this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);

            this.addEventListener(MouseEvent.MOUSE_UP, mosueUpHandler);
        }

        public function endDraw():void
        {
            if (isDrawing == true)
            {
                isDrawing = false;
                lines.push(line);
                line = null;

                this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);

//            this.removeEventListener(MouseEvent.MOUSE_UP, mosueUpHandler);

                this.graphics.endFill();
            }
        }


    }
}