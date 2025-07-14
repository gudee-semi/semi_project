package com.hy.service.notice;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;

import com.hy.dto.notice.NoticeAttach;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class NoticeAttachService {
	
	public static File getUploadDirectory() {
		String dirPath = "C://upload/notice";
		
		File uploadDir = new File(dirPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		return uploadDir;
	}
	
	public static NoticeAttach handleUploadFile(HttpServletRequest request, File uploadDir) {
		NoticeAttach result = null;
		
		try {
			Part filePart = request.getPart("file");
			if (filePart.getSize() > 0) {
				result = getFileMeta(filePart, uploadDir);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}
	
	public static NoticeAttach getFileMeta(Part part, File uploadDir) {
		String oriName = part.getSubmittedFileName();
		String ext = FilenameUtils.getExtension(oriName);
		// 여기 선생님꺼 코드 보기
		String fileName = oriName.substring(0, oriName.indexOf(".")); // ?
		String saveName = UUID.randomUUID().toString().replace("-", "");
		File file = new File(uploadDir, saveName + "." + ext);
		
		try (InputStream input = part.getInputStream(); OutputStream output = Files.newOutputStream(file.toPath())) {
			input.transferTo(output);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		NoticeAttach na = new NoticeAttach();
		na.setOriName(oriName);
		na.setReName(saveName + "." + ext);
		na.setPath("C://upload/notice/" + saveName + "." + ext);
		
		return na;
		
	}
}
