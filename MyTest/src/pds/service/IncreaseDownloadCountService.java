package pds.service;

import java.sql.Connection;
import java.sql.SQLException;

import pds.dao.PdsItemDao;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class IncreaseDownloadCountService {
	private static IncreaseDownloadCountService instance = new IncreaseDownloadCountService();
	
	public static IncreaseDownloadCountService getInstance () {
		return instance;
	}
	
	
	public boolean increaseCount(int id){
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int updatedCount = PdsItemDao.getInstance().increaseCount(conn, id);
					
			// 업데이트가 됬는지 여부를 반환하도록 한다.
			return updatedCount == 0 ? false : true;
		} catch (SQLException e){
			throw new RuntimeException("DB 처리 에러 발생 : "+e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}		
	}
	
	
	
}