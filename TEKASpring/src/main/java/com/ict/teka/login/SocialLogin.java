package com.ict.teka.login;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import vo.TekaMemberVo;

public class SocialLogin {
	private OAuth20Service oauthService;
	private SocialValue social;
	
	public SocialLogin(SocialValue social) {
		this.oauthService = new ServiceBuilder(social.getClientId())
				.apiSecret(social.getClientSecret())
				.callback(social.getRedirectUrl())
				.scope("profile")
				.build(social.getApi20Instance());
		
		this.social = social;
	}

	public Object getNaverAuthURL() {
		// TODO Auto-generated method stub
		return this.oauthService.getAuthorizationUrl();
	}

	public TekaMemberVo getUserProfile(String code) throws Exception {
		// TODO Auto-generated method stub
		//액세스 토큰을 받아오기
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		
		//소셜에 요청하기 위한 request생성
		OAuthRequest request = new OAuthRequest(Verb.GET, this.social.getProfileUrl());
		oauthService.signRequest(accessToken, request);
		
		//요청을 처리한 응답을 가져온다.
		Response response = oauthService.execute(request);
		
		//json형태로 응답이 온다.
		//return parseJson(response.getBody());
		return parseJson(response.getBody());
	}
	
	private TekaMemberVo parseJson(String body) throws Exception {
		// TODO Auto-generated method stub
		
		TekaMemberVo user = new TekaMemberVo();
		
		
		//json - > object 매핑
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
	
		JsonNode resNode = rootNode.get("response");
		user.setM_naverId(resNode.get("id").asText());
		user.setM_email(resNode.get("email").asText());
		user.setM_nickname(uniToKor(resNode.get("name").asText()));
		return user;
	}
	
	public String uniToKor(String uni){
	    StringBuffer result = new StringBuffer();
	    
	    for(int i=0; i<uni.length(); i++){
	        if(uni.charAt(i) == '\\' &&  uni.charAt(i+1) == 'u'){    
	            Character c = (char)Integer.parseInt(uni.substring(i+2, i+6), 16);
	            result.append(c);
	            i+=5;
	        }else{
	            result.append(uni.charAt(i));
	        }
	    }
	    return result.toString();
	}
}
