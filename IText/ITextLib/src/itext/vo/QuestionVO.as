package itext.vo
{
	/**
	 *问题VO 
	 * @author Jing
	 * 
	 */	
	public class QuestionVO
	{
		/**
		 *问题所在索引 
		 */		
		public var questionIndex:int = 0;
		
		/**
		 *问题内容 
		 */		
		public var content:String = "";
		
		/**
		 *问题是否被激活（是否被触发） 
		 */		
		public var isActivation:Boolean = false;
		
		public function QuestionVO(questionIndex:int = 0, content:String = ""):void
		{
			this.questionIndex = questionIndex;
			this.content = content;
		}
		
		public var answers:Vector.<AnswerVO> = new Vector.<AnswerVO>();
	}
}