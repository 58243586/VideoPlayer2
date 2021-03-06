package itext.events
{
    import flash.events.Event;
    
    import itext.vo.EffectVO;
    import itext.vo.KeywordVO;
    import itext.vo.QuestionVO;

    /**
     *IText编辑器事件
     * @author Jing
     *
     */
    /**
     *
     * @author Jing
     */
    public class InTextEditerEvent extends Event
    {
        private var _keywords:Vector.<KeywordVO> = null;

        /**
         *关键词数据集合
         * @return
         *
         */
        public function get keywords():Vector.<KeywordVO>
        {
            return _keywords;
        }


        private var _questions:Vector.<QuestionVO> = null;

        /**
         *问题数据集合
         * @return
         *
         */
        public function get questions():Vector.<QuestionVO>
        {
            return _questions;
        }


        private var _effects:Vector.<EffectVO> = null;

        /**
         *特效数据集合
         * @return
         *
         */
        public function get effects():Vector.<EffectVO>
        {
            return _effects;
        }

        /**
         *
         * @param type
         * @param keywords
         * @param questions
         * @param effects
         *
         */
        public function InTextEditerEvent(type:String, keywords:Vector.<KeywordVO> = null, questions:Vector.<QuestionVO> = null, effects:Vector.<EffectVO> = null)
        {
            this._keywords = keywords;
            this._effects = effects;
            this._questions = questions;
            super(type);
        }

        /**
         *编辑改变
         */
        static public const EDITER_CHANGE:String = "EditerChange";

        /**
         *文本范围选择
         */
        static public const TEXT_SELECTION:String = "TextSelection";
		
		/**
		 *问题输入框的改变事件 
		 */		
		static public const QUESTION_INPUT_BOX_CHANGE:String = "QuestionInputBoxChange";

    }


}