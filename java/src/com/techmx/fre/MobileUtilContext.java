package com.techmx.fre;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

/**移动应用工具类上下文*/
public class MobileUtilContext extends FREContext {

	/**发短信的接口*/
	public static String SEND_SMS="sendSMS";
	
	@Override
	public void dispose() {
		// TODO Auto-generated method stub
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functionMap=new HashMap<String, FREFunction>();
		functionMap.put(SEND_SMS, new SendSMSFunction());
		return functionMap;
	}

}
