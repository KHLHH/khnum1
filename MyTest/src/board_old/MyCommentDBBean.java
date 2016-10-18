package board_old;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import java.util.*;


public class MyCommentDBBean {


	
	private static MyCommentDBBean instance = new MyCommentDBBean();
	
	public static MyCommentDBBean getInstance(){
		return instance;
	}
	
	private MyCommentDBBean(){}
	
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	

	//read.jsp : DB로부터 한줄의 게시글 레코드 가져옴
	public int getCommentCount(int num) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int commentCount = -9421;
		
		String sql = "";
		try {
			conn = getConnection();
			
			sql = "select count(*) from mycomment where articleNum = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);	
			rs = stmt.executeQuery();
			
			if (rs.next() ){
				commentCount = rs.getInt(1);
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return commentCount;
	}
	
	
	//read.jsp : DB로부터 한줄의 게시글 레코드 가져옴
	public List<MyCommentDataBean> getComments(int num) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<MyCommentDataBean> myComments = new Vector<MyCommentDataBean>();
		MyCommentDataBean myComment = new MyCommentDataBean();
		
		String sql = "";
		try {
			conn = getConnection();
			
			sql = "select * from mycomment where articleNum = ? order by commentNum desc";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);	
			rs = stmt.executeQuery();
			
			while (rs.next() ){
				myComment = new MyCommentDataBean();
				myComment.setCommentNum(rs.getInt("commentNum"));
				myComment.setArticleNum(rs.getInt("articleNum"));
				
				myComment.setWriter(rs.getString("writer"));
				myComment.setPasswd(rs.getString("passwd"));
				
				myComment.setReg_date(rs.getTimestamp("reg_date"));
				myComment.setContent(rs.getString("content"));
				
				myComment.setIp(rs.getString("ip"));
				myComments.add(myComment);
			}
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return myComments;
	}
	

	public void insertMyComment(MyCommentDataBean myComment) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		try {
			conn = getConnection();
			sql = "insert into myComment values (mycomment_num.nextval, ?,?, ?,?,?, ?)";
			
			p(""+myComment.getArticleNum());
			p(""+myComment.getWriter());
			p(""+myComment.getPasswd());
			p(""+myComment.getReg_date());
			p(""+myComment.getContent());
			p(""+myComment.getIp());
			

			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, myComment.getArticleNum());
			stmt.setString(2, myComment.getWriter());
			stmt.setString(3, myComment.getPasswd());
			stmt.setTimestamp(4, myComment.getReg_date());
			stmt.setString(5, myComment.getContent());
			stmt.setString(6, myComment.getIp());

			
			stmt.executeUpdate();
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
	}
	

	public Map deleteMyComment(MyCommentDataBean myComment) throws Exception{
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int update = -42313;
		HashMap ret = new HashMap();
		
		String sql = "";
		try {
			conn = getConnection();
			sql = "delete from myComment where CommentNum=? and ArticleNum=? and Passwd=?";

			p(""+myComment.getCommentNum());
			p(""+myComment.getArticleNum());
			p(""+myComment.getWriter());
			p(""+myComment.getPasswd());
			p(""+myComment.getReg_date());
			p(""+myComment.getContent());
			p(""+myComment.getIp());
			

			stmt = conn.prepareStatement(sql);

			stmt.setInt(1, myComment.getCommentNum());
			stmt.setInt(2, myComment.getArticleNum());
			stmt.setString(3, myComment.getPasswd());

			
			update = stmt.executeUpdate();
			ret.put("update", update);
			
		} catch(Exception ex){
			ex.printStackTrace();
		} finally{
			if(rs!=null)try{rs.close();}catch(Exception ex){ex.printStackTrace();}
			if(stmt!=null)try{stmt.close();}catch(Exception ex){ex.printStackTrace();}
			if(conn!=null)try{conn.close();}catch(Exception ex){ex.printStackTrace();}
		}
		return ret;
	}
	
	
	
	
	
	
	
	
	
	public void p(String str1){
		d.D.p("this : "+this+" "+str1);
	}
}
