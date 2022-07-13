package com.ict.teka.login;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class SocialValue implements SocialUrl{
	private String service;	//naver or google이 들어온다.
	private String clientId;
	private String clientSecret;
	private String redirectUrl;
	private DefaultApi20 api20Instance; //NaverAPI20내부에 정의된 인스턴스를 가져오기 위해 상위 클래스인 DefaultAPI20타입으로 설정한다. 이 인스턴스가 있어야만 SnsUrl에서 naverurl을 가져올 수 있다!!
	private String profileUrl;			//각 소셜에서 프로필을 받아올 URL을 저장
	
	private boolean isNaver;
	private boolean isGoogle;
	
	

	public SocialValue(String service, String clientId, String clientSecret, String redirectUrl) {
		super();
		this.service = service;
		this.clientId = clientId;
		this.clientSecret = clientSecret;
		this.redirectUrl = redirectUrl;
		this.isNaver  = this.service.equals("naver");
		this.isGoogle = this.service.equals("google");
		
		if(isNaver) {
			this.api20Instance = NaverAPI20.getInstance();
			this.profileUrl    = NAVER_PROFILE_URL;
		}
	}
	
	
	public boolean isNaver() {
		return isNaver;
	}
	
	public void setNaver(boolean isNaver) {
		this.isNaver = isNaver;
	}
	
	public boolean isGoogle() {
		return isGoogle;
	}
	
	public void setGoogle(boolean isGoogle) {
		this.isGoogle = isGoogle;
	}
	
	public DefaultApi20 getApi20Instance() {
		return api20Instance;
	}
	public void setApi20Instance(DefaultApi20 api20Instance) {
		this.api20Instance = api20Instance;
	}
	public String getProfileUrl() {
		return profileUrl;
	}
	public void setProfileUrl(String profileUrl) {
		this.profileUrl = profileUrl;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientSecret() {
		return clientSecret;
	}
	public void setClientSecret(String clientSecret) {
		this.clientSecret = clientSecret;
	}
	public String getRedirectUrl() {
		return redirectUrl;
	}
	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}
}
