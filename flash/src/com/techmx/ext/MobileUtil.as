package com.techmx.ext
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	import flash.events.StatusEvent;

	/**
	 * 基于Adobe AIR移动应用的功能扩展
	 * @author shaorui
	 */	
	public class MobileUtil extends EventDispatcher
	{
		/**发送短信*/
		public static const SEND_SMS:String = "sendSMS";
		/**扩展ID*/
		public static const EXTENSION_ID:String = "com.techmx.ext.MobileUtil";
		/**@private*/
		private var extContext:ExtensionContext;
		
		/**@private*/
		public function MobileUtil()
		{
			CONFIG::mobile
			{
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID,"");
				extContext.addEventListener(StatusEvent.STATUS,onStatusChange);
			}
		}
		/**侦听异步事件的派发*/
		protected function onStatusChange(event:StatusEvent):void
		{
			
		}
		/**发送短信(只是打开发短信界面，用户不确定是不会发的)
		 * @param phone 电话号码
		 * @param content 短信内容
		 **/
		public function sendSMS(phone:String,content:String):void
		{
			CONFIG::mobile
			{
				try
				{
					if(extContext)
						extContext.call(SEND_SMS,phone,content);
				}
				catch(err:Error)
				{
					trace("sendSMS:Error:",err);
				}
			}
			CONFIG::desktop
			{
				trace("Send SMS to ",phone,",content is '",content,"'");
			}
		}
	}
}