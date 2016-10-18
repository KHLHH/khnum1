package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class HelloHandler implements CommandHandler {
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws Throwable {
		request.setAttribute("hello","æ»≥Á«œººø‰!");
		return "/mvc/hello.jsp";
	}
}

