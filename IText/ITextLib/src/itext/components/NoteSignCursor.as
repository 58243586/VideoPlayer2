package itext.components
{
	import flash.geom.ColorTransform;
	import flash.ui.MouseCursor;
	
	import mx.core.UIComponent;

	/**
	 * 注释标记
	 * @author Jing
	 *
	 */
	public class NoteSignCursor extends UIComponent
	{

		private var _ui:NoteSignUI = new NoteSignUI();

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

		public function NoteSignCursor()
		{
			super();
			this.addChild(_ui);
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}


	}
}