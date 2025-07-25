package com.hy.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

import com.hy.dto.Member;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginSessionFilter
 */
@WebFilter("/*")
public class LoginSessionFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginSessionFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		 HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse res = (HttpServletResponse) response;

	        String uri = req.getRequestURI();
	        String context = req.getContextPath();
	        String safeContext = (context == null || context.equals("/") || context.equals("")) ? "" : context;

	        // 로그인 관련 요청은 세션이 있기 전이기에 필터 제외
	        if (uri.startsWith(safeContext + "/login")|| uri.equals(safeContext + "/") ) {
	            chain.doFilter(request, response); // 로그인 관련 요청은 통과
	            return;
	        }

	        // 정적 리소스도 제외 
	        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") || uri.endsWith(".jpg")) {
	            chain.doFilter(request, response);
	            return;
	        }

	        // 세션 체크
	        HttpSession session = req.getSession(false);
	    	if(uri.startsWith(safeContext + "/views/admin/")||uri.contains(safeContext + "/admin")||uri.startsWith(safeContext + "/user") ) {
	    		
        		if(session == null || session.getAttribute("loginMember") == null||((Member)session.getAttribute("loginMember")).getMemberNo()!=1){
        			res.sendRedirect("/views/error/403.jsp");
        			return;
        			
        		}
        		
        	}
	        if (session == null || session.getAttribute("loginMember") == null) {
	        	
	       
	        	
	        	 res.setContentType("text/html; charset=UTF-8");
        	    PrintWriter out = res.getWriter();
        	

        		out.println("<!DOCTYPE html>");
        		out.println("<html><head>");
        		out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        		out.println("</head><body>");
        		out.println("<script>");
        		out.println("Swal.fire({");
        		out.println("  icon: 'warning',");
        		out.println("  title: '세션 만료',");
        		out.println("  text: '다시 로그인해주세요',");
        		out.println("  confirmButtonText: '확인',");
        		out.println("  confirmButtonColor: '#205DAC'");
        		out.println("}).then(() => {");
        		out.println("  location.href = '" +safeContext + "/login/view';");
        		out.println("});");
        		out.println("</script>");
        		out.println("</body></html>");
        		out.close();
        	    return;
        	    
        	    
	        }
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
