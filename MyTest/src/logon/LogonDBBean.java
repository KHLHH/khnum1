package logon;

import java.sql.*;
import java.util.Vector;

public class LogonDBBean {
	private static LogonDBBean instance = new LogonDBBean();
	// static���� �̸� �ѹ� �����, static �޼���� ���� static ������ ���� �����ϰ� �Ѵ�.
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	// �����ڿ� ���� �����ڸ� ����ؼ�, �ܺο��� ���� ����
	private LogonDBBean() {
	}
	// LogonDBBean.getInstance(); �̸� ����ؼ�, �̱��� �ν��Ͻ� ������ �� �ִ�.
	
	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		// pool�̶�� jocl ���Ϸ� ���� Ŀ�ؼ� Ǯ���� ������
		return DriverManager.getConnection(jdbcDriver);
		// connection Ǯ���� connection ��������, ����
		// �� Ŭ���� �ȿ����� �� - �� Ŭ���������� ����, private���� ����
		// ��ü�� ���� �� ������ �ƴ�, �ϳ��� �����ϰ�, ���� �������� ����Ѵ�. - �̱��� ����
		// connection �������� ���� �ݺ� - �޼���� ����
		// �� Ŭ���� �� ����, �̱� ������ ��

	}
	
	// �� ���� ��û�� ����, ������ ����
	// ��� ������ ������, �޼������ ����� �����ϰų�
	// �۾��ϸ鼭, �޼��带 ����� ��.

	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = getConnection();
			stmt = conn.prepareStatement("insert into MEMBERS values (?,?,?,?,?, ?,?,?,?,?)");
			stmt.setString(1, member.getId());
			stmt.setString(2, member.getPasswd());
			stmt.setString(3, member.getName());
			stmt.setString(4, member.getJumin1());
			stmt.setString(5, member.getJumin2());
			stmt.setString(6, member.getEmail());
			stmt.setString(7, member.getBlog());
			stmt.setTimestamp(8, member.getReg_date());
			stmt.setString(9, member.getZipcode());

			stmt.setString(10, member.getAddress());

			stmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (stmt != null)
				try {
					stmt.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
	}
	
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			stmt = conn.prepareStatement(
					"select passwd from MEMBERS where id = ?"
					);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next() ){
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd) ){
					x = 1; // ���� ����
				} else {
					x = 0; // ��й�ȣ Ʋ��
				}
			} else {
				x = -1; // �ش� ���̵� ����
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(SQLException e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(SQLException e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(SQLException e){e.printStackTrace();}
		}
		return x;
	}
	
	public int confirmId(String id) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int x = -1;
		
		try {
			conn = getConnection();
			stmt = conn.prepareStatement(
					"select * from MEMBERS where ID = ?"
					);
			
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next() )
				x = 1;			
			else
				x = -1;
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return x;
	}
	
	
	public LogonDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		LogonDataBean member = null;
		
		
		try {
			conn = getConnection();
			
			stmt = conn.prepareStatement(
					"select * from MEMBERS where id = ?"
					);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next() ){
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin1"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
			}
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return member;
	}
	

	public void updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = getConnection();
			
			stmt = conn.prepareStatement(
					"update MEMBERS set passwd=?, name=?, email=?, blog=?, address=?, zipcode=? where id=?"
					);
			stmt.setString(1, member.getPasswd());
			stmt.setString(2, member.getName());
			stmt.setString(3, member.getEmail());
			stmt.setString(4, member.getBlog());
			stmt.setString(5, member.getAddress());
			stmt.setString(6, member.getZipcode());
			stmt.setString(7, member.getId());
			
			stmt.executeUpdate();
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
	}
	
	


	public int deleteMember(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			stmt = conn.prepareStatement(
					"select passwd from MEMBERS where id = ?"
					);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next() ){
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd) ){
					stmt = conn.prepareStatement(
							"delete from MEMBERS where id=?"
							);
					stmt.setString(1, id);
					stmt.executeUpdate();
					x = 1;
				} else {
					x = 0;
				}
			}
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return x;
	}
	
	


	public Vector zipcodeRead(String area4) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();
		
		
		try {
			conn = getConnection();
			String strQuery = "select * from zipcode where area4 like '"+area4+"%'";
			stmt = conn.prepareStatement(strQuery);
			rs = stmt.executeQuery();
			while(rs.next() ){
				ZipcodeBean tempZipcode = new ZipcodeBean();
				tempZipcode.setZipcode(rs.getString("zipcode"));
				tempZipcode.setArea1(rs.getString("area1"));
				tempZipcode.setArea2(rs.getString("area2"));
				tempZipcode.setArea3(rs.getString("area3"));
				tempZipcode.setArea4(rs.getString("area4"));
				vecList.addElement(tempZipcode);
			}
			
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return vecList;
	}
	
	
		
	
	
	

	public String findId(LogonDataBean l) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String str1 = null;
		try {
			conn = getConnection();
			stmt = conn.prepareStatement(
					"select * from MEMBERS where name = ? and jumin1 = ? and jumin2 = ?"
					);

			System.out.println("str1 #########"+l.getName()+"##"+l.getJumin1()+"##"+l.getJumin2());
			stmt.setString(1, l.getName() );
			stmt.setString(2, l.getJumin1() );
			stmt.setString(3, l.getJumin2() );
			rs = stmt.executeQuery();
			
			if(rs.next() ){
				str1 = rs.getString("id");
				System.out.println("rs.next #########"+str1);
			}
			else{
				str1 = null;
				System.out.println("str1 #########"+str1);
			}
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return str1;
	}
	
	
	

	public Boolean findPw(LogonDataBean l) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Boolean b1 = false;
		try {
			conn = getConnection();
			stmt = conn.prepareStatement(
					"select * from MEMBERS where name = ? and jumin1 = ? and jumin2 = ? and id = ?"
					);

			stmt.setString(1, l.getName() );
			stmt.setString(2, l.getJumin1() );
			stmt.setString(3, l.getJumin2() );
			stmt.setString(4, l.getId() );
			rs = stmt.executeQuery();
			
			if(rs.next() ){
				b1 = true;
			}
			else{
				b1 = false;
			}
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return b1;
	}
	


	public Boolean findPwNewPw(LogonDataBean l) throws Exception{
		System.out.println("~~~#########");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Boolean b1 = false;
		try {
			conn = getConnection();
			stmt = conn.prepareStatement(
					"update members set passwd = ? where id = ?"
					);

			System.out.println("str1 #########"+l.getPasswd()+"###"+l.getId());
			stmt.setString(1, l.getPasswd() );
			stmt.setString(2, l.getId() );
			b1 = ( 1 == stmt.executeUpdate() );
			
		} catch (Exception e){e.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception e){e.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception e){e.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception e){e.printStackTrace();}
		}
		return b1;
	}
	
	
	
	
	
}
