package com.techmx.fre;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**Java扩展实现*/
public class MobileUtilExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new MobileUtilContext();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub
	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub
	}

}
