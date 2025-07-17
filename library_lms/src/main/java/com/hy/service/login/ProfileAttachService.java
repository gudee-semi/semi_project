package com.hy.service.login;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;

import com.hy.dto.login.ProfileAttach;
import com.hy.dto.qna.Attach;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class ProfileAttachService {
	public static File getUploadDirectory() {
		String dirPath="C://upload/profile";
		File uploadDir = new File(dirPath);
		if(!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		return uploadDir;
	}
	
	public static ProfileAttach handleUploadFile(HttpServletRequest request ,
			File uploadDir) {
		//form에서 파일 가져오기 -> name 속성 기준
		ProfileAttach result = null;
		try {
			Part filePart= request.getPart("member_profile");
			if(filePart.getSize()>0) {
				result =  getFileMeta(filePart,uploadDir);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}
	public static ProfileAttach getFileMeta(Part part, File uploadDir) {
		//원본 파일 이름
		String dirPath="C://upload/profile";
		String oriName = part.getSubmittedFileName();
		// ex)a.png ->%%#eewp$!@@!)dff23E%.png
		//파일 확장자 
		String ext =FilenameUtils.getExtension(oriName);
		// 확장자 제외 파일 이름
		String fileName = oriName.substring(0,oriName.indexOf("."));
		//UUID 사용 -> 중복 방지
		String saveName = UUID.randomUUID().toString().replace("-", "");		
		// 중복 방지 파일명 + 확장자
		File file = new File(uploadDir,saveName+"."+ext);
		
		//파일 서버에 저장
		try(InputStream input = part.getInputStream();
			OutputStream output = Files.newOutputStream(file.toPath())
			){
			//output 경로에 input에 담긴 데이터 보내기
			
			input.transferTo(output);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		
		}		
		ProfileAttach a = new ProfileAttach();
		a.setOriName(oriName);
		a.setReName(saveName+"."+ext);
		a.setPath(dirPath+"/"+saveName+"."+ext);
		return a;		
	}
	
}
