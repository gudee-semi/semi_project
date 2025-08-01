package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.qna.Qna;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/qna/view")
public class QnaViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService service = new QnaService();
       
    public QnaViewServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Qna qna = new Qna();
		
		// 현재 페이지 정보 셋팅
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if(nowPageStr != null) {
			nowPage = Integer.parseInt(nowPageStr);
		}
		qna.setNowPage(nowPage);
		
		// 검색어 셋팅
		String keywordIn = request.getParameter("keywordIn");
		qna.setKeywordIn(keywordIn);
		
		String keyword = request.getParameter("keyword");
		qna.setKeyword(keyword);
		
		// 전체 게시글 개수 조회
		int totalData = service.selectQnaCount(qna);
		
		// 키워드 기준 2가지로 메소드 각각 만들기
		qna.setTotalData(totalData);
		int totaldata = qna.getTotalData();
		
		// 게시글 목록 정보 조회
		List<Qna> qnaList = service.selectQnaList(qna);
	
		request.setAttribute("totaldata", totaldata);
		request.setAttribute("paging", qna);
		request.setAttribute("qnaList", qnaList);
		request.getRequestDispatcher("/views/qna/list.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
