package itext.views.playerElements.preburieds
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import itext.constants.TriggerConstant;
	import itext.events.EffectTriggerEvent;
	import com.jing.utils.TextAreaUtil;
	import itext.vo.EffectVO;
	
	import mx.core.UIComponent;
	
	import spark.components.TextArea;
	import itext.tools.RectBlock;

	public class EffectPreburied extends UIComponent
	{
		private var rectBlocks:Vector.<RectBlock> = new Vector.<RectBlock>();

		private var _vo:EffectVO = null;

		public function get vo():EffectVO
		{
			return _vo;
		}

		public function set vo(value:EffectVO):void
		{
			_vo = value;
		}

		public function EffectPreburied(vo:EffectVO)
		{
			super();
			_vo = vo;
 
			switch (_vo.trigger)
			{
				case TriggerConstant.MOUSE_CLICK:
					this.addEventListener(MouseEvent.CLICK, triggerHandler);
					break;
				case TriggerConstant.MOUSE_OVER:
					this.addEventListener(MouseEvent.ROLL_OVER, triggerHandler);
					break;
				case TriggerConstant.TIME:
					setTimeout(triggerHandler, (Number(_vo.param) * 1000));
					break;
			}
		}

		private function triggerHandler(e:Event = null):void
		{
			trace("触发关键词句");
//			this.removeEventListener(MouseEvent.CLICK, triggerHandler);
//			this.removeEventListener(MouseEvent.ROLL_OVER, triggerHandler);
			this.dispatchEvent(new EffectTriggerEvent(EffectTriggerEvent.EFFECT_TRIGGER, _vo));
		}

		public function update(beginIndex:int, endIndex:int, ta:TextArea):void
		{
			
			for (var i:int = 0; i < rectBlocks.length; i++)
			{
				this.removeChild(rectBlocks[i]);
			}
			rectBlocks.length = 0;
			
			var beginRect:Rectangle =TextAreaUtil.getBoundRectOfIndex(beginIndex,ta);
			var endRect:Rectangle = TextAreaUtil.getBoundRectOfIndex(endIndex - 1,ta);

			//起始行数
			var startLineIndex:int = ta.textFlow.flowComposer.findLineIndexAtPosition(beginIndex);
			//结束行数
			var endLineIndex:int =ta.textFlow.flowComposer.findLineIndexAtPosition(endIndex - 1);


			this.x = beginRect.x + ta.x;
			this.y = beginRect.y + ta.y;

			var rectBlock1:RectBlock = null;
			var rectBlock2:RectBlock = null;
			var rectBlock3:RectBlock = null;

			var distance:int = endLineIndex - startLineIndex;
			
			var color:uint = 0xE28706;
			var alpha:int = 0;

			if (distance == 0)
			{
				rectBlock1 = new RectBlock();
				rectBlock1.update(endRect.x + endRect.width - beginRect.x, beginRect.height, color, alpha);
				rectBlocks.push(rectBlock1);
				this.addChild(rectBlock1);
			}
			else if (distance == 1)
			{
				//顶层
				rectBlock1 = new RectBlock();
				//底层
				rectBlock2 = new RectBlock();

				rectBlock1.update(ta.width - beginRect.x, beginRect.height, color, alpha);
				this.addChild(rectBlock1);

				rectBlock2.update(endRect.x + endRect.width, endRect.height, color, alpha);
				rectBlock2.x = -beginRect.x;
				rectBlock2.y = endRect.y - beginRect.y;
				this.addChild(rectBlock2);

				rectBlocks.push(rectBlock1, rectBlock2);
			}
			else if (distance > 1)
			{
				//顶层
				rectBlock1 = new RectBlock();
				//底层
				rectBlock2 = new RectBlock();
				//中层
				rectBlock3 = new RectBlock();

				rectBlock1.update(ta.width - beginRect.x, beginRect.height, color, alpha);
				this.addChild(rectBlock1);

				rectBlock2.update(endRect.x + endRect.width, endRect.height, color, alpha);
				rectBlock2.x = -beginRect.x;
				rectBlock2.y = endRect.y - beginRect.y;
				this.addChild(rectBlock2);

				rectBlock3.update(ta.width, endRect.y - (beginRect.y + beginRect.height), color, alpha);
				rectBlock3.x = -beginRect.x;
				rectBlock3.y = beginRect.height;
				this.addChild(rectBlock3);

				rectBlocks.push(rectBlock1, rectBlock2, rectBlock3);
			}
			
		}
	}
}