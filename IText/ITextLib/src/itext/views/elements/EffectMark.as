package itext.views.elements
{
	import itext.components.TextArea;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import itext.framework.IconFactory;
	
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	
	import itext.vo.EffectVO;

	/**
	 *特效标记
	 * @author Jing
	 *
	 */
	public class EffectMark extends UIComponent
	{
		private var effectIcon:DisplayObject = null;

		private var flexSprite:FlexSprite = new FlexSprite();

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


		public function EffectMark(vo:EffectVO)
		{
			super();

			this._vo = vo;
			
			this.mouseEnabled = false;
			this.mouseChildren = true;
			flexSprite.buttonMode = true;
			effectIcon = IconFactory.getEffectIcon();
			flexSprite.addChild(effectIcon);
			this.addChild(flexSprite);
			flexSprite.y = -flexSprite.height;
			_vo = vo;			
			
			this.width = effectIcon.width;
			this.height = effectIcon.height;
		}
		
		/**
		 *
		 * @param beginIndex
		 * @param endIndex
		 * @param ta
		 *
		 */
		public function update(beginIndex:int, endIndex:int, ta:TextArea):void
		{
			for (var i:int = 0; i < rectBlocks.length; i++)
			{
				this.removeChild(rectBlocks[i]);
			}
			rectBlocks.length = 0;
			
			var beginRect:Rectangle = ta.getTextField().getCharBoundaries(beginIndex);
			var endRect:Rectangle = ta.getTextField().getCharBoundaries(endIndex - 1);
			
			//起始行数
			var startLineIndex:int = ta.getTextField().getLineIndexOfChar(beginIndex);
			//结束行数
			var endLineIndex:int = ta.getTextField().getLineIndexOfChar(endIndex - 1);
			
			
			this.x = beginRect.x + ta.x;
			this.y = beginRect.y + ta.y;
			
			var rectBlock1:RectBlock = null;
			var rectBlock2:RectBlock = null;
			var rectBlock3:RectBlock = null;
			
			var distance:int = endLineIndex - startLineIndex;
			
			if (distance == 0)
			{
				rectBlock1 = new RectBlock();
				rectBlock1.update(endRect.x + endRect.width - beginRect.x, beginRect.height, 0xE28706, 0.3);
				rectBlocks.push(rectBlock1);
				this.addChild(rectBlock1);
			}
			else if(distance == 1)
			{
				//顶层
				rectBlock1 = new RectBlock();
				//底层
				rectBlock2 = new RectBlock();
				
				rectBlock1.update(ta.width - beginRect.x, beginRect.height, 0xE28706, 0.3);
				this.addChild(rectBlock1);
				
				rectBlock2.update(endRect.x + endRect.width, endRect.height, 0xE28706, 0.3);
				rectBlock2.x = -beginRect.x;
				rectBlock2.y = endRect.y - beginRect.y;
				this.addChild(rectBlock2);
				
				rectBlocks.push(rectBlock1, rectBlock2);
			}
			else if(distance > 1)
			{
				//顶层
				rectBlock1 = new RectBlock();
				//底层
				rectBlock2 = new RectBlock();
				//中层
				rectBlock3 = new RectBlock();
				
				rectBlock1.update(ta.width - beginRect.x, beginRect.height, 0xE28706, 0.3);
				this.addChild(rectBlock1);
				
				rectBlock2.update(endRect.x + endRect.width, endRect.height, 0xE28706, 0.3);
				rectBlock2.x = -beginRect.x;
				rectBlock2.y = endRect.y - beginRect.y;
				this.addChild(rectBlock2);
				
				rectBlock3.update(ta.width, endRect.y - (beginRect.y + beginRect.height), 0xE28706, 0.3);
				rectBlock3.x = -beginRect.x;
				rectBlock3.y = beginRect.height;
				this.addChild(rectBlock3);
				
				rectBlocks.push(rectBlock1, rectBlock2, rectBlock3);
			}
		}
	}
}