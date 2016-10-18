package action;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardDataBean;
import board.BoardDBBean;



public class WriteProAction implements CommandAction {

	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws Throwable {

		System.out.println("#### start ####" );


		
		
		response.setCharacterEncoding("utf-8");
		System.out.println("subject # "+request.getParameter("subject"));


		BoardDataBean article = new BoardDataBean();   
		article.setNum(Integer.parseInt(request.getParameter("num")) );
		article.setWriter(request.getParameter("writer"));
		article.setEmail(request.getParameter("email"));
		article.setSubject(URLDecoder.decode(request.getParameter("subject"), "UTF-8"));
		article.setPasswd(request.getParameter("passwd"));
		
		article.setReg_date(new Timestamp(System.currentTimeMillis() ));
		article.setRef(Integer.parseInt(request.getParameter("ref") ));
		article.setRe_step(Integer.parseInt(request.getParameter("re_step") ));
		article.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		article.setContent(request.getParameter("content") );
		article.setIp(request.getRemoteAddr() );
		
		
		BoardDBBean dbPro = BoardDBBean.getInstance();
		dbPro.insertArticle(article);
		
		return "/MVC/writePro.jsp";
	}
}

