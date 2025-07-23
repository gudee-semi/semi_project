package com.hy.common.filter;

import java.io.IOException;
import java.io.PrintWriter;

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
	        if (uri.startsWith(safeContext + "/login")|| uri.equals(safeContext + "/") || uri.equals(safeContext + "/main")) {
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
	        if (session == null || session.getAttribute("loginMember") == null) {
	        	
	        	 res.setContentType("text/html; charset=UTF-8");
        	    PrintWriter out = res.getWriter();

        	    out.println("<script>");
        	    out.println("alert('세션이 만료되어 로그아웃 되었습니다.');");
        	    out.println("location.href='" + safeContext + "/login/view';");
        	    out.println("</script>");
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
