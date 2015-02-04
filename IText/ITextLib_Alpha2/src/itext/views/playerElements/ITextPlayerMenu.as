package itext.views.playerElements
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    import itext.components.ITextPlayer;
    import itext.constants.PencilTypeConstant;

    import mx.core.UIComponent;

    /**
     *ITEXT播放器的菜单
     * @author Jing
     *
     */
    public class ITextPlayerMenu extends UIComponent
    {
        private var ui:ITextPlayerMenuUI = new ITextPlayerMenuUI();

        private var _player:ITextPlayer = null;

        //线条的尺寸
        private var lineSize:int = 1;

        //线条颜色
        private var lineColor:uint = 0;

        //线条类型
        private var lineType:String = PencilTypeConstant.CUSTOM;

        public function ITextPlayerMenu()
        {
            super();

            initInterface();
            initListeners();
        }

        /**
         *初始化用户界面
         *
         */
        private function initInterface():void
        {
            ui.noteColorPanel.visible = false;
            ui.drawColorPanel.visible = false;
            ui.drawLineSizePanel.visible = false;
            ui.drawLineStylePanel.visible = false;
            ui.drawMenuPanel.visible = false;

            this.width = ui.btnDraw.x + ui.btnDraw.width - ui.btnNote.x;
            this.height = Math.max(ui.btnDraw.height, ui.btnNote.height);

            this.addChild(ui);
        }

        /**
         *初始化时间监听
         *
         */
        private function initListeners():void
        {
            //-------------界面控制部分
            this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);

            ui.btnNote.addEventListener(MouseEvent.CLICK, btnNote_rollClickHandler);
            ui.btnDraw.addEventListener(MouseEvent.CLICK, btnDraw_rollClickHandler);

            ui.drawMenuPanel.btnDrawColor.addEventListener(MouseEvent.ROLL_OVER, btnDrawPanelButton_rollOverHandler);
            ui.drawMenuPanel.btnDrawLine.addEventListener(MouseEvent.ROLL_OVER, btnDrawPanelButton_rollOverHandler);
            ui.drawMenuPanel.btnDrawStyle.addEventListener(MouseEvent.ROLL_OVER, btnDrawPanelButton_rollOverHandler);

            ui.drawColorPanel.addEventListener(MouseEvent.ROLL_OUT, childPanel_rollOutHandler);
            ui.drawLineSizePanel.addEventListener(MouseEvent.ROLL_OUT, childPanel_rollOutHandler);
            ui.drawLineStylePanel.addEventListener(MouseEvent.ROLL_OUT, childPanel_rollOutHandler);



            //-------------功能实现部分
            ui.noteColorPanel.addEventListener(MouseEvent.CLICK, noteColorPanel_clickHandler);

            ui.drawColorPanel.addEventListener(MouseEvent.CLICK, drawColorPanel_clickHandler);
            ui.drawLineSizePanel.addEventListener(MouseEvent.CLICK, drawLineSizePanel_clickHandler);
            ui.drawLineStylePanel.addEventListener(MouseEvent.CLICK, drawLineStylePanel_clickHandler);

            ui.drawMenuPanel.btnDrawEraser.addEventListener(MouseEvent.CLICK, btnDrawEraser_clickHandler);

        }

        private function rollOutHandler(e:MouseEvent):void
        {
//            ui.noteColorPanel.visible = false;
            ui.drawColorPanel.visible = false;
            ui.drawLineSizePanel.visible = false;
            ui.drawLineStylePanel.visible = false;
            //            ui.drawMenuPanel.visible = false;
        }

        private function btnNote_rollClickHandler(e:MouseEvent):void
        {
            ui.noteColorPanel.visible = !ui.noteColorPanel.visible;
        }

        private function btnDraw_rollClickHandler(e:MouseEvent):void
        {
            ui.drawMenuPanel.visible = !ui.drawMenuPanel.visible;
            _player.setPencil(lineColor, lineSize, lineType, ui.drawMenuPanel.visible);
        }

        private function btnDrawPanelButton_rollOverHandler(e:MouseEvent):void
        {
            switch (e.currentTarget)
            {
                case ui.drawMenuPanel.btnDrawColor:
                    ui.drawColorPanel.visible = true;
                    break;
                case ui.drawMenuPanel.btnDrawLine:
                    ui.drawLineSizePanel.visible = true;
                    break;
                case ui.drawMenuPanel.btnDrawStyle:
                    ui.drawLineStylePanel.visible = true;
                    break;
            }
        }

        private function childPanel_rollOutHandler(e:MouseEvent):void
        {
            (e.currentTarget as DisplayObject).visible = false;
        }

        private function noteColorPanel_clickHandler(e:MouseEvent):void
        {
            switch (e.target)
            {
                case ui.noteColorPanel.btnRedNote:
                    _player.setNote(COLOR_4);
                    break;
                case ui.noteColorPanel.btnYellowNote:
                    _player.setNote(COLOR_3);
                    break;
                case ui.noteColorPanel.btnGreenNote:
                    _player.setNote(COLOR_2);
                    break;
                case ui.noteColorPanel.btnBlueNote:
                    _player.setNote(COLOR_1);
                    break;
                case ui.noteColorPanel.btnBlackNote:
                    _player.setNote(COLOR_0);
                    break;
            }
        }

        private function drawColorPanel_clickHandler(e:MouseEvent):void
        {
            var lineColor:uint = 0;

            switch (e.target)
            {
                case ui.drawColorPanel.btnDrawRed:
                    ui.drawMenuPanel.btnDrawColor.upState = getCopy(ui.drawColorPanel.btnDrawRed.upState);
                    lineColor = COLOR_4;
                    break;
                case ui.drawColorPanel.btnDrawYellow:
                    ui.drawMenuPanel.btnDrawColor.upState = getCopy(ui.drawColorPanel.btnDrawYellow.upState);
                    lineColor = COLOR_3;
                    break;
                case ui.drawColorPanel.btnDrawGreen:
                    ui.drawMenuPanel.btnDrawColor.upState = getCopy(ui.drawColorPanel.btnDrawGreen.upState);
                    lineColor = COLOR_2;
                    break;
                case ui.drawColorPanel.btnDrawBlue:
                    ui.drawMenuPanel.btnDrawColor.upState = getCopy(ui.drawColorPanel.btnDrawBlue.upState);
                    lineColor = COLOR_1;
                    break;
                case ui.drawColorPanel.btnDrawDarkGreen:
                    ui.drawMenuPanel.btnDrawColor.upState = getCopy(ui.drawColorPanel.btnDrawDarkGreen.upState);
                    lineColor = COLOR_0;
                    break;
            }

            if (lineColor != 0)
            {
                e.currentTarget.visible = false;
                this.lineColor = lineColor;
                _player.setPencil(lineColor, lineSize, lineType, ui.drawMenuPanel.visible);
            }


        }

        private function getCopy(obj:DisplayObject):DisplayObject
        {
            var bitmapData:BitmapData = new BitmapData(obj.width, obj.height, true, 0x00000000);
            bitmapData.draw(obj);
            var bitmap:Bitmap = new Bitmap(bitmapData);
            bitmap.x = obj.x;
            bitmap.y = obj.y;
            return bitmap;
        }


        private function drawLineSizePanel_clickHandler(e:MouseEvent):void
        {
            var lineSize:int = -1;

            switch (e.target)
            {
                case ui.drawLineSizePanel.btnDraw1px:
                    ui.drawMenuPanel.btnDrawLine.upState = getCopy(ui.drawLineSizePanel.btnDraw1px.upState);
                    lineSize = 1;
                    break;
                case ui.drawLineSizePanel.btnDraw2px:
                    ui.drawMenuPanel.btnDrawLine.upState = getCopy(ui.drawLineSizePanel.btnDraw2px.upState);
                    lineSize = 2
                    break;
                case ui.drawLineSizePanel.btnDraw3px:
                    ui.drawMenuPanel.btnDrawLine.upState = getCopy(ui.drawLineSizePanel.btnDraw3px.upState);
                    lineSize = 3
                    break;
                case ui.drawLineSizePanel.btnDraw4px:
                    ui.drawMenuPanel.btnDrawLine.upState = getCopy(ui.drawLineSizePanel.btnDraw4px.upState);
                    lineSize = 4
                    break;
                case ui.drawLineSizePanel.btnDraw5px:
                    ui.drawMenuPanel.btnDrawLine.upState = getCopy(ui.drawLineSizePanel.btnDraw5px.upState);
                    lineSize = 5
                    break;
            }

            if (lineSize != -1)
            {
                e.currentTarget.visible = false;
                this.lineSize = lineSize;
                _player.setPencil(lineColor, lineSize, lineType, ui.drawMenuPanel.visible);
            }

        }

        private function drawLineStylePanel_clickHandler(e:MouseEvent):void
        {
            var lineType:String = null;

            switch (e.target)
            {
                case ui.drawLineStylePanel.btnDrawDotaLine:
                    ui.drawMenuPanel.btnDrawStyle.upState = getCopy(ui.drawLineStylePanel.btnDrawDotaLine.upState);
                    lineType = PencilTypeConstant.DOT;
                    break;
                case ui.drawLineStylePanel.btnDrawDoubleLine:
                    ui.drawMenuPanel.btnDrawStyle.upState = getCopy(ui.drawLineStylePanel.btnDrawDoubleLine.upState);
                    lineType = PencilTypeConstant.DOUBLE;
                    break;
                case ui.drawLineStylePanel.btnDrawLine:
                    ui.drawMenuPanel.btnDrawStyle.upState = getCopy(ui.drawLineStylePanel.btnDrawLine.upState);
                    lineType = PencilTypeConstant.STRAIGHT;
                    break;
                case ui.drawLineStylePanel.btnDrawNormalLine:
                    ui.drawMenuPanel.btnDrawStyle.upState = getCopy(ui.drawLineStylePanel.btnDrawNormalLine.upState);
                    lineType = PencilTypeConstant.CUSTOM;
                    break;
                case ui.drawLineStylePanel.btnDrawWave:
                    ui.drawMenuPanel.btnDrawStyle.upState = getCopy(ui.drawLineStylePanel.btnDrawWave.upState);
                    lineType = PencilTypeConstant.WAVE;
                    break;
            }

            if (lineType != null)
            {
                e.currentTarget.visible = false;
                this.lineType = lineType;
                _player.setPencil(lineColor, lineSize, lineType, ui.drawMenuPanel.visible);
            }

        }

        private function btnDrawEraser_clickHandler(e:Event):void
        {
            _player.paletteEraser();
        }

        //--------------------公共接口----------------------
        public function bindITextPlayer(itextPlayer:ITextPlayer):void
        {
            _player = itextPlayer;
        }

        private const COLOR_0:uint = 0x004168;

        private const COLOR_1:uint = 0x44A9E4;

        private const COLOR_2:uint = 0x54BD00;

        private const COLOR_3:uint = 0xFFA44B;

        private const COLOR_4:uint = 0xE93C00;
    }
}