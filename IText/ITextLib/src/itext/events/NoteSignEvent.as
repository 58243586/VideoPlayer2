package itext.events
{
	import flash.events.Event;

	import itext.vo.NoteVO;

	/**
	 *注释标记的事件
	 * @author Jing
	 *
	 */
	public class NoteSignEvent extends Event
	{
		private var _noteVO:NoteVO = null;

		public function get noteVO():NoteVO
		{
			return _noteVO;
		}

		public function NoteSignEvent(type:String, noteVO:NoteVO)
		{
			this._noteVO = noteVO;
			super(type);
		}

		/**
		 *删除注释
		 */
		static public const DEL_NOTE:String = "DelNote";
	}
}