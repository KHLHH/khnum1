package soldesk.board;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import java.util.*;

public class BoardDBBean {
	
	
	
	
	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance(){
		return instance;
	}
	
	private BoardDBBean(){}
	
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	// writePro.jsp
	public void insertArticle(BoardDataBean article) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 답변 글 / 일반글인지 구분
		
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		
		int number = 0;
		String sql = "";
		try {
			conn = getConnection();
			stmt = conn.prepareStatement("select max(num) from board");
			rs = stmt.executeQuery();
			if (rs.next()){
				number = rs.getInt(1)+1;
			} else {
				number = 1;
			}
			
			if(num!=0){
				sql="update board set re_step=re_step+1 where ref=? and re_step>?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, ref);
				stmt.setInt(2, re_step);
				stmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;
			} else {
				ref = number;
				re_step=0;
				re_level=0;
			}
			

			sql = "insert into board "
			+ " (num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip) "
			+ " values (board_num.NEXTVAL, ?, ?, ?, ?, ?  , ?, ?, ?, ?, ?) ";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, article.getWriter());
			stmt.setString(2, article.getEmail());
			stmt.setString(3, article.getSubject());
			stmt.setString(4, article.getPasswd());
			stmt.setTimestamp(5, article.getReg_date());
			stmt.setInt(6, ref);
			stmt.setInt(7, re_step);
			stmt.setInt(8, re_level);
			stmt.setString(9, article.getContent());
			stmt.setString(10, article.getIp());
			
			stmt.executeUpdate();
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
	}
	
	//list.jsp : 페이징을 위해 전체 DB에 입력된 행의 수를 구하도록 한다.
	public int getArticleCount() throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		int x = 0;
		String sql = "";
		try {
			conn = getConnection();
			sql = "select count(*) from board";
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				x = rs.getInt(1);
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return x;
	}
	
	

	
	//list.jsp : 페이징을 위해 전체 DB에 입력된 행의 수를 구하도록 한다.
	public int listCountSearch(Map searchCondition) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		

		String searchCategory = (String) searchCondition.get("searchCategory");
		String searchKeyword = (String) searchCondition.get("searchKeyword");
		
		int x = 0;
		String sql = "";
		try {
			conn = getConnection();
			
			
			if( searchCategory == null || searchCategory.equals("")
					|| searchKeyword == null || searchKeyword.equals("") ){
				sql = "select count(*) from board";
			} else {
				sql = "select count(*) from board"
					+ " where "+searchCategory+" like '%"+searchKeyword+"%'";
			}

			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				x = rs.getInt(1);
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return x;
	}
	

	
	
	//list.jsp => Paging, DB로 부터의 한 페이지 분량의 행들을 가져온다.
	public List getArticles(int start, int end) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List articleList = null;
		
		String sql = "";
		try {
			
			conn = getConnection();
			sql = "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
			+ " from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
			+ " from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount  "
			+ " from board order by ref desc, re_step asc) order by ref desc, re_step asc ) "
			+ " where r >= ? and r <= ?"
			;
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, start);
			stmt.setInt(2, end);
			
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				articleList = new ArrayList(end);
				do{
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setIp(rs.getString("ip"));
					
					articleList.add(article);
				} while(rs.next() );
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return articleList;
	}
	

	//list.jsp => Paging, DB로 부터의 한 페이지 분량의 행들을 가져온다.
	public List listSearch(int start, int end, Map searchCondition) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List articleList = null;
		String searchCategory = (String) searchCondition.get("searchCategory");
		String searchKeyword = (String) searchCondition.get("searchKeyword");
		
		String sql = "";
		try {
			
			conn = getConnection();
			if( searchCategory == null || searchCategory.equals("")
					|| searchKeyword == null || searchKeyword.equals("") ){
				sql = "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
						+ " from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
						+ " from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount  "
						+ " from board order by ref desc, re_step asc) order by ref desc, re_step asc ) "
						+ " where r >= ? and r <= ?"
						;
			} else {
				sql = "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
						+ " from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
						+ " from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount  "
						+ " from board order by ref desc, re_step asc) "
						+ " where "+searchCategory+" like '%"+searchKeyword+"%'"
						+ " order by ref desc, re_step asc ) "
						+ " where r >= ? and r <= ?"
						;
			}
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, start);
			stmt.setInt(2, end);
			
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				articleList = new ArrayList(end);
				do{
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setIp(rs.getString("ip"));
					
					articleList.add(article);
				} while(rs.next() );
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return articleList;
	}
	
	
	

	//read.jsp : DB로부터 한줄의 게시글 레코드 가져옴
	public BoardDataBean getArticle(int num) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		
		String sql = "";
		try {
			conn = getConnection();
			sql = "update board set readcount = readcount + 1 where num = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);	
				
			stmt.executeUpdate();
			
			
			sql = "select * from board where num = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);	
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				
				article.setIp(rs.getString("ip"));
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return article;
	}

	
	// updateForm.jsp : 수정폼에 하나의 레코드 를 가져옴
	public BoardDataBean updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			String sql = "select * from board where num = ?";
			conn = getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
		} catch (Exception ex){
			ex.printStackTrace();
		} finally {
			if(rs!=null)try{rs.close();}catch (Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch (Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch (Exception ex){ex.printStackTrace();}
		}
		return article;
	}
	
	// updatePro.jsp : 실제 글을 업데이트 sql 실행을 시킨다.
		public int updateArticle(BoardDataBean article) throws Exception {
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String dbpasswd = "";
			String sql = "select passwd from board where num = ?";
			int x = -1;
			
			try {
				
				conn = getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, article.getNum());
				rs = stmt.executeQuery();
				
				if (rs.next() ){
					dbpasswd = rs.getString("passwd");
					if(dbpasswd.equals(article.getPasswd() ) ){
						sql = "update board set writer=?, email=?, subject=?, passwd=?";
						sql+= ",content=? where num=?";
						stmt = conn.prepareStatement(sql);
						stmt.setString(1, article.getWriter() );
						stmt.setString(2, article.getEmail() );
						stmt.setString(3, article.getSubject() );
						stmt.setString(4, article.getPasswd() );
						stmt.setString(5, article.getContent() );
						stmt.setInt(6, article.getNum() );
						
						stmt.executeUpdate();
						x = 1;
					} else {
						x = 0;
					}
				}
			} catch (Exception ex){
				ex.printStackTrace();
			} finally {
				if(rs!=null)try{rs.close();}catch (Exception ex){ex.printStackTrace();}
				if(stmt!=null)try{stmt.close();}catch (Exception ex){ex.printStackTrace();}
				if(conn!=null)try{conn.close();}catch (Exception ex){ex.printStackTrace();}
			}
			return x;
		}
		
		// deletePro.jsp : 글 레코드 하나를 삭제하는 메서드
		public int deleteArticle(int num, String passwd) throws Exception {
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String dbpasswd = "";
			String sql = "select passwd from board where num = ?";
			int x = -1;
			
			try {
				
				conn = getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, num);
				rs = stmt.executeQuery();
				
				if (rs.next() ){
					dbpasswd = rs.getString("passwd");
					if(dbpasswd.equals(passwd) ){
						sql = "delete from board where num = ?";
						stmt = conn.prepareStatement(sql);
						stmt.setInt(1, num);
						stmt.executeUpdate();
						
						x = 1; // 글 삭제 성공
					} else {
						x = 0; // 비밀번호 틀림
					}
				}
			} catch (Exception ex){
				ex.printStackTrace();
			} finally {
				if(rs!=null)try{rs.close();}catch (Exception ex){ex.printStackTrace();}
				if(stmt!=null)try{stmt.close();}catch (Exception ex){ex.printStackTrace();}
				if(conn!=null)try{conn.close();}catch (Exception ex){ex.printStackTrace();}
			}
			return x;
		}

		public static void p(String str1){
			System.out.println("## Debug : "+str1);
		}
	

		
		public int getArticleCount(int n, String searchKeyword) throws Exception{
			
			Connection conn = null;
			PreparedStatement pstmt =null;
			ResultSet rs = null;
			
			String[] column_name = {"writer","subject","content"};
			
			int x = 0;
			
			try
			{
				conn = getConnection();
				pstmt = conn.prepareStatement("select count (*) from board where "+column_name[n]+" like '%"+searchKeyword+"%'");
				
				rs = pstmt.executeQuery();
				
				if(rs.next())
					x = rs.getInt(1);
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
			finally
			{
				if(rs != null) try {rs.close();} catch(SQLException ex){}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex){}
				if(conn != null) try {conn.close();} catch(SQLException ex){}
			}
			return x;
		}

	 public List getArticles(int start, int end, int n, String searchKeyword) throws Exception
		{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List articleList = null;
			
			String[] column_name = {"writer","subject","content"};
			
			try
			{
				conn = getConnection();
				
				String sql = "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "	
							+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
							+"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount "
							+"from board order by ref desc, re_step asc) where "+column_name[n]+" like '%"+searchKeyword+"%' order by ref desc, re_step asc ) where r >= ? and r <= ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2,	end);
				
				rs = pstmt.executeQuery();
				
				if(rs.next())
				{
					articleList = new ArrayList(end);
					
					do{
						BoardDataBean article = new BoardDataBean();
						
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPasswd(rs.getString("passwd"));
						article.setReg_date(rs.getTimestamp("reg_date"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setRe_step(rs.getInt("re_step"));
						article.setRe_level(rs.getInt("re_level"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						
						
						articleList.add(article);
					}while(rs.next());
					
				}
				
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
			finally
			{
				if(rs != null) try {rs.close();} catch(SQLException ex){}
				if(pstmt != null) try {pstmt.close();} catch(SQLException ex){}
				if(conn != null) try {conn.close();} catch(SQLException ex){}
			}
			
			return articleList;
		}
		
		
		
		
}
