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

public class ControllerUsingFile extends HttpServlet {
	private Map commandHandlerMap = new java.util.HashMap();
	
	// init �޼��� �����ڰ� ������ �ǰ� ���� �� �ѹ� ������ �ǰ� �ȴ�.
	// Ư�� ��û�� ������, ���� ��ü�� ����� ���� �� ����
	
	// init �޼���� ServletCofig ����
	public void init(ServletConfig config)
					throws ServletException{
		// properties ���� ���� ���,
		// properties ���Ͽ��� �ܼ��� ���ڿ��̴�.
		// ex. properties 
		// ���� ������ Ŭ���� �̸����� ����Ѵ�.
		// Ŭ���� �˾Ƶΰ�, �̸� ��ü �ν��Ͻ��� ���� �����Ѵ�.
		// �ش� ��ü ���� process �޼��带 ����.
		
		// WEB-INF/commandHandler.properties �� ���� - �̸� ��ü�� �����ؾ���
		String configFile = config.getInitParameter("configFile");
		Properties prop = new Properties(); // ������Ƽ ������ �� ����
		FileInputStream fis = null;
		
		try {
			// ������Ʈ������ ��θ� �����´�. - �� ���� WEB-INF/commandHandler.properties ������
			// ������Ƽ ������ ���� ��ġ�� �˾Ƴ���
			String configFilePath = config.getServletContext().getRealPath(configFile);
			fis = new FileInputStream(configFilePath);
			// ��ǲ ��Ʈ�� ��
			// ����� ��Ʈ�����κ��� �о , ���� ��Ų��. - �д� �� + 
			// = ���� �������� Ű��=���� ������ �����Ѵ�.
			// ���� �� �ѽ��� ����ȴ�.
			// hello, Ŭ�������
			prop.load(fis);
		} catch(IOException e){
			throw new ServletException(e);
		} finally {
			// ���̻� ��Ʈ���� ������ �ʿ� �����Ƿ� close
			if(fis != null)try {fis.close(); } catch(IOException e){e.printStackTrace(); } 
		}
		
		// ���� propertiess ��ü��
		// hello, helloHandler ����
		
		// hello �ϳ��� �ִ�. keySet���� Ű�� ������.
		Iterator keyIter = prop.keySet().iterator();
		// ���� ���ͷ����� �ȿ� ��ü�� �����Ƿ� ���ǽ� true
		while(keyIter.hasNext() ){
			// command�� hello��� ���ڿ� ����
			String command = (String) keyIter.next();
			// hello��� Ű�� ���� �� helloHandler�� �����ͼ� ����
			String handlerClassName = prop.getProperty(command);
			// mvc.command.HelloHandler - �ܼ��� ���ڿ��� Class �� �������Ѵ�.
			try {
				Class handlerClass = Class.forName(handlerClassName);
				// ��ü�� �����.
				Object handlerInstance = handlerClass.newInstance();
				// ���� ������ �ؽø� ��ü���ٰ� ������ ��Ų��.
				// hello ��� ���ڿ��� Ű�� - process ��� �޼��带 ������ �ִ� Handler ��ü�� ����
				commandHandlerMap.put(command, handlerInstance);
			} catch (ClassNotFoundException e){
				throw new ServletException(e);
			} catch (InstantiationException e){
				throw new ServletException(e);
			} catch (IllegalAccessException e) {
				throw new ServletException(e);
			}
		}
	} // init �޼��� �� - �ʱ�ȭ �ϸ�, �׻� �ؽø� ��ü�� [hello - ��ü] �� ����
	
	
	// init ������ ��û ó�� - doGet�� �����Ѵ�.
	// doGet / doPost �޼��带 �������̵� ��.
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

	public void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ?cmd=hello �Է½� hello ��Ʈ�� ��ȯ
		String command = request.getParameter("cmd");
		
		// helloHandler Ŭ������ ��ȯ
		CommandHandler handler = (CommandHandler) commandHandlerMap.get(command);
		
		if(handler == null){
			handler = new NullHandler(); // null�� �ٸ��Ƿ� ��鷯�� ��� ��鷯�� �ִ�.
		}
		
		String viewPage = null;
		try {
			// HelloHandler ���� process �޼��� Ȱ��
			// �޼��� ����, request �� �Ӽ� �ް�
			viewPage = handler.process(request, response);
			// hello.jsp ����
		} catch(Throwable e){
			throw new ServletException(e);
		}
		
		// hello.jsp �ּҸ� ���� ��η� ������
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
	
}




