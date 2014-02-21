package com.techmx.fre.admob;

import android.app.Activity;
import android.app.Service;
import android.os.Vibrator;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**Function*/
public class AdmobShowBannerFunction implements FREFunction {

	Activity activity ;
	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		activity = context.getActivity();
		Vibrator vib = (Vibrator) activity
				.getSystemService(Service.VIBRATOR_SERVICE);
		vib.vibrate(1000);
		return null;
	}

}
