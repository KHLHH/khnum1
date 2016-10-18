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
	
	// init 메서드 생성자가 실행이 되고 나서 단 한번 실행이 되게 된다.
	// 특정 요청이 들어오면, 서블릿 객체를 만들고 밑의 것 실행
	
	// init 메서드는 ServletCofig 받음
	public void init(ServletConfig config)
					throws ServletException{
		// properties 파일 정보 대로,
		// properties 파일에는 단순한 문자열이다.
		// ex. properties 
		// 값을 실제로 클래스 이름으로 써야한다.
		// 클래를 알아두고, 이를 객체 인스턴스로 만들어서 저장한다.
		// 해당 객체 안의 process 메서드를 실행.
		
		// WEB-INF/commandHandler.properties 를 저장 - 이를 객체에 저장해야함
		String configFile = config.getInitParameter("configFile");
		Properties prop = new Properties(); // 프로퍼티 저장할 것 만듬
		FileInputStream fis = null;
		
		try {
			// 프로젝트까지의 경로를 가져온다. - 그 뒤의 WEB-INF/commandHandler.properties 가져옴
			// 프로퍼티 파일이 실제 위치를 알아내고
			String configFilePath = config.getServletContext().getRealPath(configFile);
			fis = new FileInputStream(configFilePath);
			// 인풋 스트림 씀
			// 연결된 스트림으로부터 읽어서 , 저장 시킨다. - 읽는 것 + 
			// = 이퀄 기준으로 키값=벨류 값으로 저장한다.
			// 지금 딱 한쌍이 저장된다.
			// hello, 클래스경로
			prop.load(fis);
		} catch(IOException e){
			throw new ServletException(e);
		} finally {
			// 더이상 스트림을 연결할 필요 없으므로 close
			if(fis != null)try {fis.close(); } catch(IOException e){e.printStackTrace(); } 
		}
		
		// 지금 propertiess 객체에
		// hello, helloHandler 저장
		
		// hello 하나만 있다. keySet으로 키만 가져옴.
		Iterator keyIter = prop.keySet().iterator();
		// 지금 이터레이터 안에 객체가 있으므로 조건식 true
		while(keyIter.hasNext() ){
			// command에 hello라는 문자열 저장
			String command = (String) keyIter.next();
			// hello라는 키에 맵핑 된 helloHandler를 가져와서 저장
			String handlerClassName = prop.getProperty(command);
			// mvc.command.HelloHandler - 단순한 문자열을 Class 로 만들어야한다.
			try {
				Class handlerClass = Class.forName(handlerClassName);
				// 객체로 만든다.
				Object handlerInstance = handlerClass.newInstance();
				// 위에 선언한 해시맵 객체에다가 저장을 시킨다.
				// hello 라는 문자열의 키와 - process 라는 메서드를 가지고 있는 Handler 객체가 저장
				commandHandlerMap.put(command, handlerInstance);
			} catch (ClassNotFoundException e){
				throw new ServletException(e);
			} catch (InstantiationException e){
				throw new ServletException(e);
			} catch (IllegalAccessException e) {
				throw new ServletException(e);
			}
		}
	} // init 메서드 끝 - 초기화 하면, 항상 해시맵 객체에 [hello - 객체] 쌍 저장
	
	
	// init 끝나면 요청 처리 - doGet을 실행한다.
	// doGet / doPost 메서드를 오버라이딩 함.
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
		// ?cmd=hello 입력시 hello 스트링 반환
		String command = request.getParameter("cmd");
		
		// helloHandler 클래스를 반환
		CommandHandler handler = (CommandHandler) commandHandlerMap.get(command);
		
		if(handler == null){
			handler = new NullHandler(); // null과 다르므로 헨들러는 헬로 헨들러가 있다.
		}
		
		String viewPage = null;
		try {
			// HelloHandler 안의 process 메서드 활용
			// 메서드 가면, request 에 속성 받고
			viewPage = handler.process(request, response);
			// hello.jsp 받음
		} catch(Throwable e){
			throw new ServletException(e);
		}
		
		// hello.jsp 주소를 갖는 경로로 포워드
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		
	}
	
}




