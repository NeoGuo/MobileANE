package com.techmx.ext.event
{
	import flash.events.Event;
	/**
	 * Admob的事件
	 */	
	public class AdmobEvent extends Event
	{
		public static const AD_CLICKED:String = "adClicked";
		public static const BANNER_RECEIVED:String = "bannerReceived";
		public static const BANNER_FAILED:String = "bannerFailed";
		public static const INTERSTITIAL_RECEIVED:String = "interstitialReceived";
		public static const INTERSTITIAL_FAILED:String = "interstitialFailed";
		
		public function AdmobEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}