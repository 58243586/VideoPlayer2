package itext.events
{
    import flash.events.Event;

    import itext.vo.QuestionVO;

    /**
     * 问题答案设置
     * @author Jing
     *
     */
    public class AnswerSetWindowEvent extends Event
    {
        private var _questionVO:QuestionVO = null;

        public function get questionVO():QuestionVO
        {
            return _questionVO;
        }

        /**
         *
         * @param type 事件类型
         * @param questionVO 问题VO
         *
         */
        public function AnswerSetWindowEvent(type:String, questionVO:QuestionVO)
        {
            this._questionVO = questionVO;
            super(type);
        }

        /**
         *答案设置
         */
        static public const ANSWER_SET:String = "AnswerSet";

        /**
         *关闭
         */
        static public const CLOSE:String = "close";
    }
}