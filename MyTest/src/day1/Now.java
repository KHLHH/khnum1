package day1;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//@WebServlet("/Now");
public class Now extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		Date now = new Date();
	
		PrintWriter writer = response.getWriter();
		writer.println("<html>");
		writer.println("<head><title>현재 시간</title></head>");
		writer.println("<body>");
		writer.println("<h1>");		
		writer.println("서블릿 생성 현재 시간:");
		writer.println(now);
		writer.println("</h1>");		
		writer.println("</body>");
		writer.println("</html>");
		writer.println(Config);
		writer.println(config);
		writer.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
