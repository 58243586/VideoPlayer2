package itext.constants
{

	/**
	 *触发效果枚举
	 * @author Jing
	 *
	 */
	public class EffectTypeConstant
	{
		/**
		 *发光
		 */
		static public const CHANGE_COLOR:String = "ChangeColor";

		/**
		 *变形
		 */
		static public const DISTORTION:String = "Distortion";

		/**
		 *闪烁
		 */
		static public const FLASH:String = "Flash";
		
		//---------------效果列表
		static public const EFFECTS:Array = [{label: "变色", data: CHANGE_COLOR},
			{label: "闪烁", data: FLASH}];
	}
}