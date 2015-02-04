package itext.vo
{

	/**
	 *the value object of the Pre-Buried setting
	 * @author Jing
	 *
	 */
	public class EffectVO
	{
		/**
		 *文本段起始索引
		 */
		public var beginIndex:int = 0;

		/**
		 *文本段结束索引
		 */
		public var endIndex:int = 0;

		/**
		 *特效类型
		 */
		public var effectType:String = "";

		/**
		 *特效动作
		 */
//		public var effectAction:int = 0;

		/**
		 *触发条件
		 */
		public var trigger:String = "";

		/**
		 *附带参数
		 */
		public var param:Object = null;

		/**
		 *内容
		 */
		public var content:String = "";

		public function EffectVO():void
		{
		}
	}
}