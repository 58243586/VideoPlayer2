package itext.interfaces
{

	/**
	 *系统接口
	 * @author Jing
	 *
	 */
	public interface ITextPlayer
	{
		/**
		 *设置IText数据
		 *
		 */
		function setIText(xml:XML):void

		/**
		 *得到学习状态出口
		 *
		 */
		function getStudyOut():void;
		/**
		 *设置注释
		 *
		 */
		function setNote(color:uint):void;
		
		

	}
}