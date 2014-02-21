package com.techmx.ext
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	/**
	 * 基于Adobe AIR移动应用的功能扩展
	 * @author shaorui
	 */	
	public class MobileUtil extends EventDispatcher
	{
		/**发送短信*/
		private static const SEND_SMS:String = "sendSMS";
		/**震动*/
		private static const SHAKE:String = "shake";
		/**扩展ID*/
		private static const EXTENSION_ID:String = "com.techmx.ext.MobileUtil";
		/**@private*/
		private var extContext:ExtensionContext;
		/**@private*/
		private var _admob:AdmobUtil;
		
		/**@private*/
		public function MobileUtil()
		{
			CONFIG::mobile
			{
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID,"");
				extContext.addEventListener(StatusEvent.STATUS,onStatusChange);
			}
			_admob = new AdmobUtil(extContext);
		}
		/**Admob引用*/
		public function get admob():AdmobUtil
		{
			return _admob;
		}
		/**侦听异步事件的派发*/
		protected function onStatusChange(event:StatusEvent):void
		{
			//trace(event.code,event.level);
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
		/**震动
		 **/
		public function shake():void
		{
			CONFIG::mobile
			{
				try
				{
					if(extContext)
						extContext.call(SHAKE);
				}
				catch(err:Error)
				{
					trace("shake:Error:",err);
				}
			}
			CONFIG::desktop
			{
				trace("手机产生了一次震动");
			}
		}
	}
}