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


// URI ������
// hello.do�� �ּҸ� �Է��ؼ� ������ ���Ѿ��Ѵ�.
// controllerUsingFile�� ó���� ���� ��Ű�� �߸��� ��û�Դϴٶ�� ������
// cmd=hello ��� ������ �˸°� ������ �ȴ�.
// do�� ���� �ǹ̾��� Ȯ���� �̴�. �ζ�� �����Ѵ�. �ڱⰡ ������� ������ �����ϴ�.

public class ControllerUsingURI extends HttpServlet {
	private Map commandHandlerMap = new java.util.HashMap();
	
	public void init(ServletConfig config)
			throws ServletException {
		
		// �ʱ�ȭ ���� ������ �� �̹����� configFile2 �̴�.
		// ���� �Ķ������ �̸��� �޶������� ���̴�.
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
		
		// /gello.do �� helloHandler Ŭ������ ���εȴ�.
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
	

	// � ��� ��û�ϵ� ���� process ��û
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
		// �ּҰ� �ٲ��.
		// Request ��ü���� URI ������ �� �ִ�.
		// path �κ��� �����´�.
		// contextRoot ���� �����ϴ� path �κ��� ���������� �Ѵ�.
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

