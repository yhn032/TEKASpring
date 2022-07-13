package com.ict.teka.login;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverAPI20 extends DefaultApi20 implements SocialUrl{
	//싱글톤
	private static NaverAPI20 _instance;
	private NaverAPI20() {
		
	}
	
	public static NaverAPI20 getInstance() {
		if(_instance == null) {
			_instance = new NaverAPI20();
		}
		return _instance;
	}
	
	
	@Override
	public String getAccessTokenEndpoint() {
		// TODO Auto-generated method stub
		return NAVER_ACCESS_TOKEN;
	}
	@Override
	protected String getAuthorizationBaseUrl() {
		// TODO Auto-generated method stub
		return NAVER_AUTH;
	}

}
