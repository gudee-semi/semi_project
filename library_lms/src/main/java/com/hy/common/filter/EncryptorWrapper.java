package com.hy.common.filter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

public class EncryptorWrapper extends HttpServletRequestWrapper{

	public EncryptorWrapper(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String name) {
		String result = super.getParameter(name);
		
		//비밀번호 암호화
		if(name.equals("member_Pw")){
			return getSHA512(result);
		}
		
		//주민번호 생년월일+성별구분 코드까지 추출
		if(name.equals("member_Rrn")) {
			return result.substring(0,7)+getSHA512(result);
			
		}
		return result;
	}
	
	
	//단방향 암호화 로직
	public String getSHA512(String oriVal) {
		MessageDigest md=null;
		try {
			md = MessageDigest.getInstance("SHA-512");
			
		} catch (NoSuchAlgorithmException e) {
			
			e.printStackTrace();
		}
		byte[] oriValByte = oriVal.getBytes();
		md.update(oriValByte);
		
		byte[] encValByte = md.digest();
		
		String result= Base64.getEncoder().encodeToString(encValByte);
		return result;
	}
	
}
