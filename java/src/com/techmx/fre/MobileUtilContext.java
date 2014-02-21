package com.techmx.fre;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.techmx.fre.admob.AdmobHideBannerFunction;
import com.techmx.fre.admob.AdmobInitFunction;
import com.techmx.fre.admob.AdmobShowBannerFunction;
import com.techmx.fre.admob.AdmobShowInterstitialFunction;

/**Context*/
public class MobileUtilContext extends FREContext {

	/**SMS*/
	public static String SEND_SMS="sendSMS";
	/**Shake*/
	public static String SHAKE="shake";
	/**ad init*/
	public static String AD_INIT = "admobInit";
	/**show banner*/
	public static String AD_SHOW_BANNER = "admobShowBanner";
	/**hide banner*/
	public static String AD_HIDE_BANNER = "admobHideBanner";
	/**show big ad*/
	public static String AD_SHOW_INTERSTITIAL = "admobShowInterstitial";
	
	@Override
	public void dispose() {
		// TODO Auto-generated method stub
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functionMap=new HashMap<String, FREFunction>();
		functionMap.put(SEND_SMS, new SendSMSFunction());
		functionMap.put(SHAKE, new ShakeFunction());
		functionMap.put(AD_INIT, new AdmobInitFunction());
		functionMap.put(AD_SHOW_BANNER, new AdmobShowBannerFunction());
		functionMap.put(AD_HIDE_BANNER, new AdmobHideBannerFunction());
		functionMap.put(AD_SHOW_INTERSTITIAL, new AdmobShowInterstitialFunction());
		return functionMap;
	}

}
