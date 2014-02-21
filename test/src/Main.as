package
{
	import com.techmx.ext.AdmobUtil;
	import com.techmx.ext.MobileUtil;
	import com.techmx.ext.event.AdmobEvent;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

	/**
	 * ANE测试
	 * @author shaorui
	 */	
	public class Main extends Sprite
	{
		/**@private*/
		private var mobileUtil:MobileUtil;
		/**@private*/
		private var btn:SimpleButton;
		
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
			btn = new SimpleButton(shape,shape,shape,shape);
			btn.x = 100;
			btn.y = 60;
			addChild(btn);
			btn.addEventListener(MouseEvent.MOUSE_DOWN,showAD);
		}
		/**测试发短信*/
		protected function sendSMS(event:MouseEvent):void
		{
			mobileUtil.sendSMS("1000000","今天你吃饭了吗?");
		}
		/**测试震动*/
		protected function shake(event:MouseEvent):void
		{
			mobileUtil.shake();
		}
		/**测试广告*/
		protected function showAD(event:MouseEvent):void
		{
			trace("点击测试广告");
			btn.alpha = 0.2;
			mobileUtil.admob.init("a152af025a3526b","a152834c2b8cce6");
			mobileUtil.admob.showBanner(new Rectangle(btn.x,btn.y,AdmobUtil.BANNER.width,AdmobUtil.BANNER.height));
			mobileUtil.admob.addEventListener(AdmobEvent.BANNER_RECEIVED,bannerReceivedHandler);
			mobileUtil.admob.addEventListener(AdmobEvent.BANNER_FAILED,bannerReceivedHandler);
			mobileUtil.admob.addEventListener(AdmobEvent.AD_CLICKED,bannerReceivedHandler);
			mobileUtil.admob.addEventListener(AdmobEvent.INTERSTITIAL_RECEIVED,bannerReceivedHandler);
			mobileUtil.admob.addEventListener(AdmobEvent.INTERSTITIAL_FAILED,bannerReceivedHandler);
			mobileUtil.admob.setOrientation(stage.orientation);
			stage.removeEventListener(StageOrientationEvent.ORIENTATION_CHANGE,onOrientationChanged);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE,onOrientationChanged);
		}
		/**侦听屏幕翻转*/
		protected function onOrientationChanged(event:StageOrientationEvent):void
		{
			mobileUtil.admob.setOrientation(event.afterOrientation);
		}
		/**事件*/
		protected function bannerReceivedHandler(event:AdmobEvent):void
		{
			if(event.type == AdmobEvent.BANNER_RECEIVED)
			{
				trace("广告显示成功");
			}
			else
			{
				trace("广告加载失败");
			}
		}
	}
}