package com.techmx.ext
{
	import com.techmx.ext.event.AdmobEvent;
	
	import flash.display.StageOrientation;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.geom.Rectangle;

	[Event(name="adClicked", type="com.techmx.ext.event.AdmobEvent")]
	[Event(name="bannerReceived", type="com.techmx.ext.event.AdmobEvent")]
	[Event(name="bannerFailed", type="com.techmx.ext.event.AdmobEvent")]
	[Event(name="interstitialReceived", type="com.techmx.ext.event.AdmobEvent")]
	[Event(name="interstitialFailed", type="com.techmx.ext.event.AdmobEvent")]
	/**
	 * Admob相关功能
	 */	
	public class AdmobUtil extends EventDispatcher
	{
		/**初始化*/
		private static const INIT:String = "admobInit";
		/**初始化屏幕方向*/
		private static const SET_ORIENTATION:String = "admobSetOrientation";
		/**显示广告*/
		private static const SHOW_BANNER:String = "admobShowBanner";
		/**隐藏广告*/
		private static const HIDE_BANNER:String = "admobHideBanner";
		/**显示整屏广告*/
		private static const SHOW_INTERSTITIAL:String = "admobShowInterstitial";
		
		public static const BANNER:Rectangle = new Rectangle(0,0,320,50);
		public static const IAB_MEDIUM_RECTANGLE:Rectangle = new Rectangle(0,0,320,250);
		public static const IAB_FULLSIZE_BANNER:Rectangle = new Rectangle(0,0,468,60);
		public static const IAB_LEADERBOARD:Rectangle = new Rectangle(0,0,728,90);
		
		/**@private*/
		private var extContext:ExtensionContext;
		/**@private*/
		private var bannerKey:String;
		/**@private*/
		private var interstitialKey:String;
		/**@private*/
		private var isTest:Boolean;
		/**@private*/
		private var _adVisible:Boolean = false;
		/**广告是否正在显示*/
		public function get adVisible():Boolean
		{
			return _adVisible;
		}
		
		/**@private*/
		public function AdmobUtil(value:ExtensionContext)
		{
			extContext = value;
			if(extContext)
				extContext.addEventListener(StatusEvent.STATUS, onAdHandler);
		}
		/**@private*/
		private function onAdHandler(event:StatusEvent):void
		{
			if(event.code == AdmobEvent.AD_CLICKED)
			{
				dispatchEvent( new AdmobEvent(AdmobEvent.AD_CLICKED));
			}
			else if(event.code == AdmobEvent.BANNER_RECEIVED)
			{
				dispatchEvent( new AdmobEvent(AdmobEvent.BANNER_RECEIVED));
			}
			else if(event.code == AdmobEvent.BANNER_FAILED)
			{
				dispatchEvent( new AdmobEvent(AdmobEvent.BANNER_FAILED));
			}
			else if(event.code == AdmobEvent.INTERSTITIAL_RECEIVED)
			{
				dispatchEvent( new AdmobEvent(AdmobEvent.INTERSTITIAL_RECEIVED));
			}
			else if(event.code == AdmobEvent.INTERSTITIAL_FAILED)
			{
				dispatchEvent( new AdmobEvent(AdmobEvent.INTERSTITIAL_FAILED));
			}
		}
		/**
		 * 对Admob进行初始化
		 * @param bannerKey 广告ID(必填)
		 * @param interstitialKey 弹窗广告ID(可选)
		 * @param testID 如果是测试模式，则设置true，否则false
		 */		
		public function init(bannerKey:String,interstitialKey:String=null,isTest:Boolean=false):void
		{
			this.bannerKey = bannerKey;
			this.interstitialKey = interstitialKey;
			this.isTest = isTest;
			CONFIG::mobile
			{
				try
				{
					if(extContext)
						extContext.call(INIT,bannerKey,interstitialKey,isTest?1:0);
				}
				catch(err:Error)
				{
					trace("AdmobUtil:init:Error:",err);
				}
			}
		}
		/**
		 * 设置屏幕方向
		 * @param orientation 方向
		 */		
		public function setOrientation(orientation:String):void
		{
			CONFIG::mobile
			{
				try
				{
					if(extContext)
					{
						var orientationIndex:int = 1;
						switch(orientation)
						{
							case StageOrientation.DEFAULT:
								orientationIndex = 1;
								break;
							case StageOrientation.UPSIDE_DOWN:
								orientationIndex = 2;
								break;
							case StageOrientation.ROTATED_LEFT:
								orientationIndex = 3;
								break;
							case StageOrientation.ROTATED_RIGHT:
								orientationIndex = 4;
								break;
						}
						extContext.call(SET_ORIENTATION,orientationIndex);
					}
				}
				catch(err:Error)
				{
					trace("AdmobUtil:setOrientation:Error:",err);
				}
			}
		}
		/**显示广告
		 * @param rect 广告显示区域
		 **/
		public function showBanner(rect:Rectangle,bannerType:int=0):void
		{
			CONFIG::mobile
			{
				try
				{
					if(extContext)
						extContext.call(SHOW_BANNER,rect.x,rect.y,rect.width,rect.height,bannerType);
					_adVisible = true;
				}
				catch(err:Error)
				{
					trace("AdmobUtil:showBanner:Error:",err);
				}
			}
			CONFIG::desktop
			{
				trace("AdmobUtil:showBanner:已调用");
			}
		}
		/**隐藏广告*/
		public function hideBanner():void
		{
			CONFIG::mobile
			{
				try
				{
					if(extContext)
						extContext.call(HIDE_BANNER);
					_adVisible = false;
				}
				catch(err:Error)
				{
					trace("AdmobUtil:hideBanner:Error:",err);
				}
			}
			CONFIG::desktop
			{
				trace("AdmobUtil:hideBanner:已调用");
			}
		}
		/**显示整屏广告*/
		public function showInterstitial():void
		{
			CONFIG::mobile
			{
				try
				{
					if(extContext)
						extContext.call(SHOW_INTERSTITIAL);
				}
				catch(err:Error)
				{
					trace("AdmobUtil:showInterstitial:Error:",err);
				}
			}
			CONFIG::desktop
			{
				trace("AdmobUtil:showInterstitial:已调用");
			}
		}
	}
}