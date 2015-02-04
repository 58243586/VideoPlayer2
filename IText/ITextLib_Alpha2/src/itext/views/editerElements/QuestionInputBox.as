package itext.views.editerElements
{
    import com.adobe.utils.StringUtil;
    
    import fl.text.TLFTextField;
    
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    
    import itext.views.editerElements.marks.QuestionMark;
    
    import mx.core.FlexGlobals;
    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    /**
     *编辑界面中的问题编辑窗口
     * @author Jing
     * @data 2010-07-30
     *
     */
    public class QuestionInputBox extends UIComponent
    {
        private const DEFAULT_STRING:String = "请输入问题内容";

        /**
         *关联的问题标注
         */
        private var questionMark:QuestionMark = null;

        //SWC中的显示对象
        private var _ui:QuestionInputBoxUI = new QuestionInputBoxUI();

        public function QuestionInputBox()
        {
            super();
            this.addChild(_ui);

            initInterface();
            initListeners();
        }

        private function initInterface():void
        {
			
        }

        private function initListeners():void
        {
            _ui.btnClose.addEventListener(MouseEvent.CLICK, btnClose_clickHandler);
            _ui.textField.addEventListener(Event.CHANGE, textField_changeHandler);
            _ui.textField.addEventListener(FocusEvent.FOCUS_IN, textField_focusInHandler);
        }

        private function releasListeners():void
        {
            _ui.btnClose.removeEventListener(MouseEvent.CLICK, btnClose_clickHandler);
            _ui.textField.removeEventListener(Event.CHANGE, textField_changeHandler);
            _ui.textField.removeEventListener(FocusEvent.FOCUS_IN, textField_focusInHandler);
        }

        private function textField_focusInHandler(e:FocusEvent):void
        {
			if(_ui.textField.text == DEFAULT_STRING)
			{
				_ui.textField.text = "";
				_ui.textField.textColor = 0x000000;
			}
        }

        private function btnClose_clickHandler(e:MouseEvent):void
        {
            this.close();
        }

        private function textField_changeHandler(e:Event):void
        {
            questionMark.vo.content = StringUtil.trim(_ui.textField.text);
            this.dispatchEvent(new Event(Event.CHANGE));

        }

        public function show(target:QuestionMark):void
        {
            questionMark = target;

            if (questionMark.vo.content != "")
            {
                _ui.textField.text = questionMark.vo.content;
            }
            else
            {
                _ui.textField.text = DEFAULT_STRING;
            }

            if (this.stage == null)
            {
                PopUpManager.addPopUp(this, FlexGlobals.topLevelApplication.document, false);
            }

            if (target != null)
            {
                var globalPoint:Point = target.localToGlobal(new Point(0, 0));
                this.x = globalPoint.x;
                this.y = globalPoint.y;
            }
        }

        public function close():void
        {
            if (this.stage != null)
            {
                PopUpManager.removePopUp(this);
            }
        }

        public function dispose():void
        {
            releasListeners();
        }
    }
}