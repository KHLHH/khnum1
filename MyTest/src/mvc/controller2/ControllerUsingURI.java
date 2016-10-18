package mvc.controller2;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.CommandAction;

public class ControllerUsingURI extends HttpServlet {

	// 명령어와 명령어 처리 클래스를 쌍으로 저장

	// 우리가 쓰는 것은 apache 톰켓 서버
	// WAS - 톰켓 서버 - 즉, 새로 서버 만들 때도 사용.
	private Map commandMap = new HashMap();

	public void init(ServletConfig config)
			throws ServletException{
		String props = config.getInitParameter("propertyConfig");
		Properties pr = new Properties();
		FileInputStream f = null;
		String path = config.getServletContext().getRealPath(props);
		try {
			f = new FileInputStream(path);
			pr.load(f);
		} catch (IOException e){
			throw new ServletException(e);
		} finally {
			if(f != null) try {f.close(); } catch(IOException e){}
		}
		Iterator keyIter = pr.keySet().iterator();
		while( keyIter.hasNext() ){
			String command = (String) keyIter.next();
			String className = pr.getProperty(command);
			try {
				Class commandClass = Class.forName(className);
				Object commandInstance = commandClass.newInstance();
				
				commandMap.put(command, commandInstance);
			} catch(ClassNotFoundException e){
				throw new ServletException(e);
			} catch(InstantiationException e){
				throw new ServletException(e);
			} catch(IllegalAccessException e){
				throw new ServletException(e);
			}
		}
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		requestPro(request, response);
	}

	private void requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setCharacterEncoding("utf-8");
		
		
		System.out.println("Pro");
		String view = null;
		CommandAction com = null;
		try {
			String command = request.getRequestURI();
			if (command.indexOf(request.getContextPath()) == 0) {
				command = command.substring(request.getContextPath().length());
			}

			if (command.indexOf("MVC_board") == 0) {
				command = command.substring(request.getContextPath().length());
			}
			System.out.println(command+"#command");
			com = (CommandAction)commandMap.get(command);
			System.out.println(com+"#com");
			
			view = com.requestPro(request, response);
			System.out.println(view+"#view");
		} catch (Throwable e) {
			throw new ServletException(e);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}

}
