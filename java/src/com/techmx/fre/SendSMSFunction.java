package com.techmx.fre;

import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**发短信的方法实现*/
public class SendSMSFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		if(args == null || args.length < 1) {
			Log.e("AndroidExtensions", "Invalid arguments number for SMSFunction! (requested: text, optional: recipient)");
			return null;
		} try {
			String text = args[1].getAsString();
			String recipient = "";
			if(args.length == 2 && args[1] != null) recipient = args[0].getAsString();
			Intent sendIntent = new Intent(Intent.ACTION_VIEW);
			sendIntent.setData(Uri.parse("sms:"+recipient));
			sendIntent.putExtra("sms_body", text);
			context.getActivity().startActivity(sendIntent);
		}
		catch(Exception e) {
			Log.e("AndroidExtensions", "Error: "+e.getMessage(), e);
		}
		return null;
	}

}
