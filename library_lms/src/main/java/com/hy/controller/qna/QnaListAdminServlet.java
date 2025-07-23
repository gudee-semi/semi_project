package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.common.vo.Paging;
import com.hy.dto.qna.Qna;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/list/admin")
public class QnaListAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private QnaAdminService qnaAdminService = new QnaAdminService();

	public QnaListAdminServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// 페이지 번호 파라미터 받기 (없으면 1)
        int nowPage = 1;
        if(request.getParameter("page") != null){
            nowPage = Integer.parseInt(request.getParameter("page"));
        }

        // 전체 QnA 개수 가져오기 (검색 조건 포함)
        String category = request.getParameter("category");
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");

        // 전체 QnA 개수 조회 (countQna는 int 반환!)
        int total = qnaAdminService.countQna(category, searchType, keyword);

        // 페이징 객체 생성
        int pageSize = 10;
        Paging paging = new Paging(nowPage, total, pageSize);

        // QnA 리스트(페이징+검색) 조회 (List<Qna> 반환)
        List<Qna> qnaAdminList = qnaAdminService.selectQnaListPaging(paging, category, searchType, keyword);        
        
        // JSP에서 사용할 데이터 저장
        request.setAttribute("qnaAdminList", qnaAdminList);
        request.setAttribute("paging", paging);
        request.setAttribute("category", category);
        request.setAttribute("searchType", searchType);
        request.setAttribute("keyword", keyword);

        // JSP로 포워딩
        request.getRequestDispatcher("/views/qna/qnaListAdmin.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);

	}

}
