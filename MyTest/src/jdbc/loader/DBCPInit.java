package jdbc.loader;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.util.StringTokenizer;
public class DBCPInit extends HttpServlet {
	
	// Servlet으로부터 상속 받은 메서드 overriding.
	// ex. 우클릭 servlet 만들 때, doGet, doPost -> 메서드 기억
	// 지금부터는 init / destory 메서드 기억
	// init: 초기화 메서드 / destory : 소멸 메서드
	
	// init 메서드 - 생성자 실행하고나서 그 다음에 바로 실행.
	// init이 변수 초기화를 많이 담당한다. -> 객체 생성후 생성자 실행하고 init 메서드 사용
	
	// destory는 servlet 메서드가 사라지게 직전에 마지막으로 destory 메서드 수행하고, 사라진다.

	// 사용하기 위해 이 객체가 만들어진다. init 메서드 실행
	@Override
	public void init(ServletConfig config) throws ServletException {
		// config - ㄱ기본 객체 중 하나.
		try {
			String drivers = config.getInitParameter("jdbcdriver");
			// 
			// 초기화 파라미터 값중 -> jdbcdriver 저장
			
			System.out.println("1");
	
			StringTokenizer st = new StringTokenizer(drivers, ",");
			// , 쉼표를 기준으로 토큰을 나눔. 처음부터 끝까지 한줄로 나눔.
			System.out.println("2");
			while (st.hasMoreTokens()) {
				// hasMoreTokens로 확인 -> 
				String jdbcDriver = st.nextToken();
				Class.forName(jdbcDriver);// oracle드라이버 로딩
				// 오라클 드라이버를 로딩함. String 안쓰고, oracle.jdbc. ~~~ 써도 됨
				// 귀찮게 토큰을 
				// web.xml -> db가 바꿔도 -> 컴파일 다시 할 필ㄹ요가 없다.
				// web.xml에 , 찍고서 더 수정이 가능하다. oracle driver 하나 로딩
				// 지금까지는 1번 단계와 같다.
			}

			// 이제는 pooling driver를 호출. 
			// 우리 project안에서, 확장자가 jocl이라는 파일이 실행이 된다.
			// 해당 계정에 연결한다. - 
			// sample.jocl -> sample 이라는 파일로 만든 커넥션 풀
			Class.forName("org.apache.commons.dbcp.PoolingDriver");

		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	} // init 메서드 끝.
	// 이 서블릿은 첫번째로 시작됨 - 이제는 클라이언트가 요청한 viewMember
	// DBCPInit 을 1번으로 load 걸고, 커넥션 저장하는 것을 함.
	// viewMemberUsingPool.jsp 를 실행.
}
