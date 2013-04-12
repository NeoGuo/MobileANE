package
{
	import com.techmx.ext.MobileUtil;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;

	/**
	 * ANE测试
	 * @author shaorui
	 */	
	public class Main extends Sprite
	{
		/**@private*/
		private var mobileUtil:MobileUtil;
		
		public function Main()
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setTimeout(initApp,100);
		}
		/**test*/
		private function initApp():void
		{
			//extensions
			mobileUtil = new MobileUtil();
			//按钮的图形
			var shape:Shape = new Shape();
			var g:Graphics = shape.graphics;
			g.beginFill(0xFF0000,1);
			g.drawRect(0,0,300,60);
			g.endFill();
			//按钮
			var btn:SimpleButton = new SimpleButton(shape,shape,shape,shape);
			btn.x = btn.y = 60;
			addChild(btn);
			btn.addEventListener(MouseEvent.MOUSE_DOWN,sendSMS);
		}
		/**测试发短信*/
		protected function sendSMS(event:MouseEvent):void
		{
			mobileUtil.sendSMS("1000000","今天你吃饭了吗?");
		}
	}
}