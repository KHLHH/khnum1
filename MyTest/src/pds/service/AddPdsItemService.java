package pds.service;

import java.sql.Connection;
import java.sql.SQLException;

import pds.dao.PdsItemDao;
import pds.model.AddRequest;
import pds.model.PdsItem;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class AddPdsItemService {
	private static AddPdsItemService instance = new AddPdsItemService();
	public static AddPdsItemService getInstance() {
		return instance;
	}
	
	private AddPdsItemService () {
		
	}
	
	public PdsItem add(AddRequest request) {
		Connection conn = null;
		try {
			// 커넥션 풀에서 커넥션을 받아 오도록 한다.
			conn = ConnectionProvider.getConnection();
			
			// AutoCommit의 속성을 false 먹여서, Transaction을 시작하도록 한다.
			// 이는 commit을 하거나 rollback 할때까지 트랜잭션이 진행된다.
			conn.setAutoCommit(false);
			
			
			// 아까 upload.jsp에서 만든 request 객체로 pdsItem 객체를 만든다.
			// bean 정의를 보면, 테이블의 모든 컬럼이 존재하도록한다.
			// 이 클래스를 객체로 만든다.
			PdsItem pdsItem = request.toPdsItem();
			
			
			
			// Dao 객체를 열고, 
			// 이때, 커넥션 객체와 빈 객체를 들고 간다.
			int id = PdsItemDao.getInstance().insert(conn, pdsItem);
			if (id == -1) {
				// 아까 본 메서드에서 리턴 
				JdbcUtil.rollback(conn);
				// 런타임익센션은 밑의 catch문에서 SQLException으로는 잡을 수가 없다.
				// 그냥 끝나게 된다.
				throw new RuntimeException("DB 삽입 안됨");
			}
			pdsItem.setId(id);
			
			// if문이 실행 안되면, 트랜젝션을 commit 시켜서 반영 시킨다.
			conn.commit();
			
			return pdsItem;
		} catch (SQLException e)  {
			JdbcUtil.rollback(conn);
			// RuntimeException 발생하면 그냥 중단이 된다.
			throw new RuntimeException(e);
		} finally {
			// 이제부터는 다시 setAutoCommit으로 자동 커밋이 되게 한다.
			if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException e){}
		
			JdbcUtil.close(conn);
		}
	} // 이제 upload.jsp로 돌아간다.
	
	

	
	public boolean modifyNotNullFile(AddRequest request, int id) {
		Connection conn = null;
		try {
			// 커넥션 풀에서 커넥션을 받아 오도록 한다.
			conn = ConnectionProvider.getConnection();
			
			// AutoCommit의 속성을 false 먹여서, Transaction을 시작하도록 한다.
			// 이는 commit을 하거나 rollback 할때까지 트랜잭션이 진행된다.
			conn.setAutoCommit(false);
			
			
			// 아까 upload.jsp에서 만든 request 객체로 pdsItem 객체를 만든다.
			// bean 정의를 보면, 테이블의 모든 컬럼이 존재하도록한다.
			// 이 클래스를 객체로 만든다.
			PdsItem pdsItem = request.toPdsItem();
			
			
			
			// Dao 객체를 열고, 
			// 이때, 커넥션 객체와 빈 객체를 들고 간다.
			PdsItemDao.getInstance().modifyNotNullFile(conn, pdsItem, id);
			
			// if문이 실행 안되면, 트랜젝션을 commit 시켜서 반영 시킨다.
			conn.commit();
			
			return true;
		} catch (SQLException e)  {
			JdbcUtil.rollback(conn);
			// RuntimeException 발생하면 그냥 중단이 된다.
			throw new RuntimeException(e);
		} finally {
			// 이제부터는 다시 setAutoCommit으로 자동 커밋이 되게 한다.
			if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException e){}
		
			JdbcUtil.close(conn);
		}
	} // 이제 upload.jsp로 돌아간다.
	

	
	public boolean modifyYesNullFile(AddRequest request, int id) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			PdsItem pdsItem = request.toPdsItem();
			
			PdsItemDao.getInstance().modifyYesNullFile(conn, pdsItem, id);
			
			conn.commit();
			
			return true;
		} catch (SQLException e)  {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException e){}
		
			JdbcUtil.close(conn);
		}
	}
	

	public boolean deleteFile(int id) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			PdsItemDao.getInstance().deleteFile(conn, id);
			
			conn.commit();
			
			return true;
		} catch (SQLException e)  {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException e){}
		
			JdbcUtil.close(conn);
		}
	}
	
	
}

