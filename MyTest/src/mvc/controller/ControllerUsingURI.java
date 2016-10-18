package mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import mvc.command.NullHandler;


// URI 실행은
// hello.do로 주소를 입력해서 실행을 시켜야한다.
// controllerUsingFile을 처음을 실행 시키면 잘못된 요청입니다라고 나오고
// cmd=hello 라고 넣으면 알맞게 실행이 된다.
// do는 가장 의미없는 확장자 이다. 두라고 발음한다. 자기가 마음대로 지정이 가능하다.

public class ControllerUsingURI extends HttpServlet {
	private Map commandHandlerMap = new java.util.HashMap();
	
	public void init(ServletConfig config)
			throws ServletException {
		
		// 초기화 설정 가져올 때 이번에는 configFile2 이다.
		// 단지 파라미터의 이름이 달라진것인 뿐이다.
		String configFile = config.getInitParameter("configFile2");
		Properties prop = new Properties();
		FileInputStream fis = null;
		try {
			String configFilePath = config.getServletContext().getRealPath(configFile);
			fis = new FileInputStream(configFilePath);
			prop.load(fis);
		} catch(IOException e){
			throw new ServletException(e);
		} finally {
			if(fis != null) try{fis.close(); } catch(IOException e){throw new ServletException(e); }
		}
		
		// /gello.do 와 helloHandler 클래스가 맵핑된다.
		Iterator keyIter = prop.keySet().iterator();
		while(keyIter.hasNext() ){
			String command = (String) keyIter.next();
			String handlerClassName = prop.getProperty(command);
			try {
				Class handlerClass = Class.forName(handlerClassName);
				Object handlerInstance = handlerClass.newInstance();
				commandHandlerMap.put(command, handlerInstance);
			} catch(ClassNotFoundException e){
				throw new ServletException(e);
			} catch(InstantiationException e){
				throw new ServletException(e);
			} catch(IllegalAccessException e){
				throw new ServletException(e);
			}
		}
	}
	

	// 어떤 방식 요청하든 밑의 process 요청
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}
	
	
	private void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 주소가 바뀐다.
		// Request 객체에서 URI 가져올 수 있다.
		// path 부분을 가져온다.
		// contextRoot 부터 시작하는 path 부분을 가져오도록 한다.
		// /SepJSP/*.do
		String command = request.getRequestURI();
		
		if(command.indexOf(request.getContextPath() ) == 0 ){
			command = command.substring(request.getContextPath().length() );
		}
		CommandHandler handler = (CommandHandler) commandHandlerMap.get(command);
		if(handler == null){
			handler = new NullHandler();
		}
		String viewPage = null;
		try {
			viewPage = handler.process(request, response);
		} catch (Throwable e){
			throw new ServletException(e);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response );
		
	}
	
	
	
	
	
	
	
}

