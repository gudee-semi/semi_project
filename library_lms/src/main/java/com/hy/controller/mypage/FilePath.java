package com.hy.controller.mypage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * Servlet implementation class FilePath
 */
@WebServlet("/profile/filePath")
public class FilePath extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FilePath() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String filePath = request.getParameter("filePath");
		if(filePath == null || filePath.trim().equals("")) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		File file = new File(filePath);
		if(!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		//파일 확장자가 등록되지 않은 파일이라면 mimeType을 기본 바이너리 타입으로 지정
		String mimeType = getServletContext().getMimeType(filePath);
		if(mimeType == null) mimeType="application/octet-stream";
		response.setContentType(mimeType);
		
		try(FileInputStream fis = new FileInputStream(file);
				OutputStream out= response.getOutputStream();) {
				byte[]buffer = new byte[1024];
				int byteRead;
				while((byteRead=fis.read(buffer))!=-1) {
					out.write(buffer,0,byteRead);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
