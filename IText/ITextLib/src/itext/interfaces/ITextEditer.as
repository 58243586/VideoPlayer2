package itext.interfaces
{

	/**
	 *用户（制作者）接口
	 * @author Jing
	 *
	 */
	public interface ITextEditer
	{
		/**
		 *文本编辑
		 *
		 */
		function setFormat():void;
		
		/**
		 *设置互动特效 
		 * @param effect 效果类型
		 * @param trigger 触发条件
		 * @param param 参数
		 * 
		 */		
		function setEffect(effectType:String, trigger:String, param:Object = null):void;
		
		/**
		 *预埋问题 
		 * 
		 */		
		function setQuestion(content:String):void;
		
		/**
		 *设置问题答案 
		 * 
		 */		
		function setQuestionAnswer(questionIndex:int):void;
		
		/**
		 *设置关键词句
		 * @param keyword
		 * 
		 */		
		function setKeyword(fontColor:uint, border:String, borderColor:uint, trigger:String, param:Object = null):void;
			
		
		/**
		 *设置学习状态出口
		 *
		 */
		function setStudyOut():void;

		/**
		 *获取IText数据 
		 * @return XML
		 * 
		 */		
		function getIText():XML;
	}
}