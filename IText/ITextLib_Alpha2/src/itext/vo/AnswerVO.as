package itext.vo
{

    /**
     *问题答案
     * @author Jing
     *
     */
    public class AnswerVO
    {
        /**
         *问题索引
         */
        public var questionIndex:int=0;

        /**
         *答案起始索引
         */
        public var beginIndex:int=0;

        /**
         *答案结束索引
         */
        public var endIndex:int=0;

        /**
         *答案内容
         */
        public var content:String="";

        /**
         *是否被回答过
         */
        public var isAnswered:Boolean=false;
    }
}