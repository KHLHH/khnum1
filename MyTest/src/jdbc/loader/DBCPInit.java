package jdbc.loader;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.util.StringTokenizer;
public class DBCPInit extends HttpServlet {
	
	// Servlet���κ��� ��� ���� �޼��� overriding.
	// ex. ��Ŭ�� servlet ���� ��, doGet, doPost -> �޼��� ���
	// ���ݺ��ʹ� init / destory �޼��� ���
	// init: �ʱ�ȭ �޼��� / destory : �Ҹ� �޼���
	
	// init �޼��� - ������ �����ϰ��� �� ������ �ٷ� ����.
	// init�� ���� �ʱ�ȭ�� ���� ����Ѵ�. -> ��ü ������ ������ �����ϰ� init �޼��� ���
	
	// destory�� servlet �޼��尡 ������� ������ ���������� destory �޼��� �����ϰ�, �������.

	// ����ϱ� ���� �� ��ü�� ���������. init �޼��� ����
	@Override
	public void init(ServletConfig config) throws ServletException {
		// config - ���⺻ ��ü �� �ϳ�.
		try {
			String drivers = config.getInitParameter("jdbcdriver");
			// 
			// �ʱ�ȭ �Ķ���� ���� -> jdbcdriver ����
			
			System.out.println("1");
	
			StringTokenizer st = new StringTokenizer(drivers, ",");
			// , ��ǥ�� �������� ��ū�� ����. ó������ ������ ���ٷ� ����.
			System.out.println("2");
			while (st.hasMoreTokens()) {
				// hasMoreTokens�� Ȯ�� -> 
				String jdbcDriver = st.nextToken();
				Class.forName(jdbcDriver);// oracle����̹� �ε�
				// ����Ŭ ����̹��� �ε���. String �Ⱦ���, oracle.jdbc. ~~~ �ᵵ ��
				// ������ ��ū�� 
				// web.xml -> db�� �ٲ㵵 -> ������ �ٽ� �� �ʤ��䰡 ����.
				// web.xml�� , ��� �� ������ �����ϴ�. oracle driver �ϳ� �ε�
				// ���ݱ����� 1�� �ܰ�� ����.
			}

			// ������ pooling driver�� ȣ��. 
			// �츮 project�ȿ���, Ȯ���ڰ� jocl�̶�� ������ ������ �ȴ�.
			// �ش� ������ �����Ѵ�. - 
			// sample.jocl -> sample �̶�� ���Ϸ� ���� Ŀ�ؼ� Ǯ
			Class.forName("org.apache.commons.dbcp.PoolingDriver");

		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	} // init �޼��� ��.
	// �� ������ ù��°�� ���۵� - ������ Ŭ���̾�Ʈ�� ��û�� viewMember
	// DBCPInit �� 1������ load �ɰ�, Ŀ�ؼ� �����ϴ� ���� ��.
	// viewMemberUsingPool.jsp �� ����.
}
