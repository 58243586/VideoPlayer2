package itext.events
{
	import flash.events.Event;

	import itext.vo.EffectVO;

	/**
	 *特效触发事件
	 * @author Jing
	 *
	 */
	public class EffectTriggerEvent extends Event
	{
		private var _effectVO:EffectVO = null;

		public function get effectVO():EffectVO
		{
			return _effectVO;
		}

		public function EffectTriggerEvent(type:String, vo:EffectVO)
		{
			this._effectVO = vo;
			super(type);
		}

		static public const EFFECT_TRIGGER:String = "EffectTrigger";
	}
}