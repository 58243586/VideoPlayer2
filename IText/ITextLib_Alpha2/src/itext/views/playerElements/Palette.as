package itext.views.playerElements
{
    import com.adobe.serialization.json.JSON;
    
    import flash.display.BitmapData;
    import flash.display.JointStyle;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    import itext.constants.PencilTypeConstant;
    import itext.framework.IconFactory;
    
    import mx.core.UIComponent;
    import mx.managers.CursorManager;
    
    import spark.primitives.Rect;

    /**
     * the border for drawing
     * 画板
     * @author Jing
     *
     */
    public class Palette extends UIComponent
    {
        //线条的透明度
        private var lineAlpha:Number = 0.7;

        //线条的数组集合
        private var lines:Array = new Array();

        //线条
        private var line:Array = null;

        //线条类型
        private var _lineType:String = "";		
		
		//是否正在使用橡皮擦
		private var isEarsing:Boolean = false;

        public function get lineType():String
        {
            return _lineType;
        }

        public function set lineType(value:String):void
        {
            _lineType = value;
			if (isEarsing == true)
				eraser();
        }

        //是否正在画图
        private var isDrawing:Boolean = false;	

        //线条的颜色
        private var _lineColor:uint = 0xFF0000;

        /**
         *得到线条颜色
         * @return
         *
         */
        public function get lineColor():uint
        {
            return _lineColor;
        }

        /**
         *设置线条颜色
         * @param value
         *
         */
        public function set lineColor(value:uint):void
        {
            _lineColor = value;
			if (isEarsing == true)
				eraser();
        }

        //线条的粗细
        private var _lineSize:uint = 1;

        public function get lineSize():uint
        {
            return _lineSize;
        }

        public function set lineSize(value:uint):void
        {
            _lineSize = value;
			if (isEarsing == true)
				eraser();
        }

        //画板的活动状态
        private var _activation:Boolean = true;

        public function get activation():Boolean
        {
            return _activation;
        }

        /**
         *设置画板的活动状态,用来开启或者关闭画板的画画功能
         * @param value
         *
         */
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
			
			if (isEarsing == false)
			{
				this.endDraw();
			}
            this.removeEventListener(MouseEvent.ROLL_OUT, rollOverHandler);
        }

        private function rollOverHandler(e:MouseEvent):void
        {
			if (isEarsing == false)
			{				
				cursorManager.setCursor(PencilCursorUI);
			}
			else if (isEarsing == true)
			{
				cursorManager.setCursor(IconFactory.ICO_ERASER_SHADOW);
				this.addEventListener(MouseEvent.CLICK, clickHandler);
			}
            this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
        }

        //----------------------外部接口-------------------

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
			isEarsing = !isEarsing;
			
			if (isEarsing == false)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				this.removeEventListener(MouseEvent.CLICK, clickHandler);
			}			
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			}			
        }	
		
		private function clickHandler(e:MouseEvent):void
		{
			//点击时橡皮擦的坐标范围
			var earserBeginX:Number = this.mouseX + 4;
			var earserBeginY:Number = this.mouseY + 5;
			var earserEndX:Number = this.mouseX + 19;
			var earserEndY:Number = this.mouseY + 17;
			
			var i:int;			
			
			if (lines.length == 0)
				return
				
			outer: for (i = 0; i < lines.length; i++)
			{				
				var j:int;
				var leftX:Number = 10000;
				var rightX:Number = 0;
				
				//擦直线的算法，由于直线是水平的，只需要判断直线的y坐标是否在擦子范围内以及橡皮擦是否点在直线左右两端范围内
				if (lines[i][0].lineType == PencilTypeConstant.STRAIGHT)
				{
					if (lines[i][1].y + lines[i][0].size <= earserBeginY || lines[i][1].y >= earserEndY)
						continue outer;
					else
					{
						for (j = 1; j < lines[i].length; j++)
						{
							if (leftX > lines[i][j].x)
								leftX = lines[i][j].x;
							if (rightX < lines[i][j].x)
								rightX = lines[i][j].x;
						}
							
						if (leftX > earserEndX || rightX < earserBeginX)
							continue outer;
						else
						{
							lines.splice(i, 1);
							redraw();
							i--;
							continue outer;
						}
					}					
//					
//					var myLine:Shape = new Shape();
//					myLine.graphics.moveTo(lines[i][1].x, lines[i][1].y);
//					for (j = 2; j < lines[i].length; j++)
//					{
//						myLine.graphics.lineTo(lines[i][j].x, lines[i][j].y);
//					}
//					for (var xPoint:Number = earserBeginX; xPoint < earserEndX; xPoint++)
//					{
//						for (var yPoint:Number = earserBeginY; yPoint < earserEndY; yPoint++)
//						{
//							if (myLine.hitTestPoint(xPoint, yPoint, true))
//							{
//								trace("Nice!");
//								continue outer;
//							}
//						}
//					}
//					trace("No~~~");
//					trace(lines.length);
					
				}
				
				//擦双直线的算法，原理同直线
				if (lines[i][0].lineType == PencilTypeConstant.DOUBLE)
				{
					if (lines[i][1].y + lines[i][0].size * 2 + 3 <= earserBeginY || lines[i][1].y >= earserEndY)
						continue outer;
					else
					{
						for (j = 1; j < lines[i].length; j++)
						{
							if (leftX > lines[i][j].x)
								leftX = lines[i][j].x;
							if (rightX < lines[i][j].x)
								rightX = lines[i][j].x;
						}
						
						if (leftX > earserEndX || rightX < earserBeginX)
							continue outer;
						else
						{
							lines.splice(i, 1);
							redraw();
							i--;
							continue outer;
						}
					}					
				}
				
				//擦虚线和波浪线的算法，由于点比较多、密集，简单地判断是否有点在橡皮擦范围内即可
				else if (lines[i][0].lineType == PencilTypeConstant.WAVE || lines[i][0].lineType == PencilTypeConstant.DOT)
				{
					for (j = 1; j < lines[i].length; j++)
					{
						var xPos:Number = lines[i][j].x;
						var yPos:Number = lines[i][j].y;
						
						if (earserBeginX <= xPos && earserBeginY <= yPos && earserEndX >= xPos && earserEndY >= yPos)
						{
							lines.splice(i, 1);								
							redraw();
							i--;
							continue outer;
						}
					}
				}				
				
				//采用像素碰撞检测自由曲线是否与橡皮擦的范围相交
				else
				{					
					var myLine:Shape = new Shape();
					myLine.graphics.lineStyle(lines[i][0].size);
					myLine.graphics.moveTo(lines[i][1].x, lines[i][1].y);
					this.addChild(myLine);
					for (j = 2; j < lines[i].length; j++)
					{
						myLine.graphics.lineTo(lines[i][j].x, lines[i][j].y);
					}
					
					for (var xPoint:Number = e.stageX + 4; xPoint <= e.stageX + 19; xPoint++)
					{	
						for (var yPoint:Number = e.stageY + 5; yPoint <= e.stageY + 17; yPoint++)
						{							
							if (myLine.hitTestPoint(xPoint, yPoint, true))
							{
								myLine.graphics.clear();
								this.removeChild(myLine);
								lines.splice(i, 1);
								redraw();
								i--;
								continue outer;
							}
						}
					}
					myLine.graphics.clear();
					this.removeChild(myLine);
				}
			}
		}

        public function getDataByJSON():String
        {
            return JSON.encode(lines);
        }

        public function setDataByJSON(objectString:String):void
        {
            lines = JSON.decode(objectString) as Array;
            redraw();
        }

        /*-----------------------------------------------*/

        //----------------内部方法---------------------

		
		//鼠标按下去开始画图时的鼠标位置
		private var beginX:Number;
		private var beginY:Number;
        /**
         *开始画图
         *
         */
        private function beginDraw():void
        {
            isDrawing = true;
            line = new Array();
            line.push({color: _lineColor, size: _lineSize, lineType: _lineType});
            line.push(new Point(this.mouseX, this.mouseY));	
			
			beginX = this.mouseX;
			beginY = this.mouseY;

            this.graphics.moveTo(this.mouseX, this.mouseY);
            this.graphics.lineStyle(_lineSize, _lineColor, lineAlpha);
            this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);

            this.addEventListener(MouseEvent.MOUSE_UP, mosueUpHandler);
        }

        /**
         *结束画图
         *
         */
        private function endDraw():void
        {
            if (isDrawing == true)
            {
                isDrawing = false;
                lines.push(line);
                line = null;

                this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);

                this.removeEventListener(MouseEvent.MOUSE_UP, mosueUpHandler);

                this.graphics.endFill();

            }
        }

        /**
         *重绘之前画过的部分
         *
         */
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
                this.graphics.lineStyle(line[0].size, line[0].color, lineAlpha);
				var j:int;
				if (line[0].lineType == PencilTypeConstant.DOUBLE)
				{
					if (line.length > 2)
					{
						this.graphics.moveTo(line[1].x, line[1].y);
						this.graphics.lineTo(line[2].x, line[2].y);
						for (j = 4; j < line.length; j = j + 2)
						{						
							this.graphics.lineTo(line[j].x, line[j].y);
						}
						
						this.graphics.moveTo(line[1].x, line[3].y);
						this.graphics.lineTo(line[3].x, line[3].y);
						for (j = 5; j < line.length; j = j + 2)
						{						
							this.graphics.lineTo(line[j].x, line[j].y);
						}
					}
				}
				else if (line[0].lineType == PencilTypeConstant.DOT)
				{
					for (j = 2; j < line.length; j++)
					{
						this.graphics.moveTo(line[j].x, line[j].y);
						if (line[j].x % 8 != 0)
						{
							this.graphics.lineTo(line[j].x - 3, line[j].y);
						}
						else if (line[j].x % 8 == 0)
						{
							this.graphics.lineTo(line[j].x + 3, line[j].y);
						}
					}
				}
				else
				{					
					this.graphics.moveTo(line[1].x, line[1].y);
					for (j = 2; j < line.length; j++)
					{
						this.graphics.lineTo(line[j].x, line[j].y);
					}
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
                var lineToX:Number = 0;
                var lineToY:Number = 0;

                if (lineType == PencilTypeConstant.WAVE)
                {
                    /*
                     *波浪线算法
                     */
					var sign:Number = -1.5;
					var n:Number;
					if (beginX < this.mouseX)
					{
						for(n = beginX + 3; n <= this.mouseX; n = n + 3)
						{
							lineToX = n;
							lineToY = Math.sin(n * Math.PI / 8) * sign + beginY;
							this.graphics.lineTo(lineToX, lineToY);
							line.push(new Point(lineToX, lineToY));
						}
						beginX = this.mouseX;
					}
					else if (beginX > this.mouseX)
					{
						var count1:int = 0;
						for (n = beginX - 3; n >= this.mouseX; n = n - 3)
						{
							lineToX = n;
							lineToY = Math.sin(n * Math.PI / 8) * sign + beginY;
							this.graphics.lineTo(lineToX, lineToY);
							line.push(new Point(lineToX, lineToY));
						}
						beginX = this.mouseX;
					}
                }
                else if (lineType == PencilTypeConstant.DOUBLE)
                {
                    /*
                     *双线
                     */
//					line.push(new Point(lineToX, line[1].y + 3 + line[0].size));
					
					this.graphics.moveTo(beginX, line[1].y);
					lineToX = this.mouseX;
					lineToY = line[1].y;
					this.graphics.lineTo(lineToX, lineToY);
					line.push(new Point(lineToX, lineToY));
					
					this.graphics.moveTo(beginX, line[1].y + 3 + line[0].size);
					lineToX = this.mouseX;
					lineToY = line[1].y + 3 + line[0].size;
					this.graphics.lineTo(lineToX, lineToY);
					line.push(new Point(lineToX, lineToY));
					
//					beginX = this.mouseX;
                }
                else if (lineType == PencilTypeConstant.DOT)
                {
                    /*
                     *虚线
                     */
					var i:int = (beginX + 4) / 8;
					var j:int = this.mouseX / 8;
					var k:int;
					if (i < j)
					{
						for (k = i; k <= j; k++)
						{
							this.graphics.moveTo(k * 8, beginY);
							lineToX = k * 8 + 3;
							lineToY = line[1].y;
							this.graphics.lineTo(lineToX, lineToY);
							line.push(new Point(lineToX, lineToY));
						}
						beginX = this.mouseX;
					}
					else if (i > j)
					{
						i++;
						j = j + 2;
						for (k = i; k >= j; k--)
						{
							this.graphics.moveTo(k * 8 - 5, beginY);
							lineToX = k * 8 - 8;
							lineToY = line[1].y;
							this.graphics.lineTo(lineToX, lineToY);
							line.push(new Point(lineToX, lineToY));
						}
						beginX = this.mouseX;	
					}
                }
                else if (lineType == PencilTypeConstant.STRAIGHT)
                {
                    lineToX = this.mouseX;
                    lineToY = line[1].y;
					this.graphics.lineTo(lineToX, lineToY);
					line.push(new Point(lineToX, lineToY));
                }
                else if (lineType == PencilTypeConstant.CUSTOM)
                {
                    lineToX = this.mouseX;
                    lineToY = this.mouseY;
					this.graphics.lineTo(lineToX, lineToY);
					line.push(new Point(lineToX, lineToY));
                }
             
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
    }
}