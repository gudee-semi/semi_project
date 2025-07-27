package com.hy.common.filter;

import java.util.Arrays;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

public class BadWordWrapper extends HttpServletRequestWrapper {

	public BadWordWrapper(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String name) {
		List<String> badWords = Arrays.asList(
			    "씨발",
			    "시발",
			    "씹새",
			    "개새끼",
			    "좆",
			    "존나",
			    "엿같",
			    "미친놈",
			    "미친년",
			    "병신",
			    "븅신",
			    "ㅂㅅ",
			    "ㅄ",
			    "ㅗ",
			    "엿먹어",
			    "꺼져",
			    "꺼졍",
			    "개놈",
			    "년놈",
			    "똘아이",
			    "미친",
			    "죽어",
			    "뒤져",
			    "놈현",
			    "홍어",
			    "틀딱",
			    "좆같",
			    "개같"
			);
		String value = super.getParameter(name);
		if (("title".equals(name) || "content".equals(name) || "qnaTitle".equals(name) || "qnaContent".equals(name)) && value != null) {
			for (String bw : badWords) {
				if (value.contains(bw)) {
					value = "CODE_REJECT_BAD_WORD";
					break;
				}
			}
		}
		return value;
	}

}
