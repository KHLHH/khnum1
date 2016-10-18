package pds.service;

import java.sql.Connection;
import java.sql.SQLException;

import pds.dao.PdsItemDao;
import pds.model.PdsItem;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class GetPdsItemService {
	
	private static GetPdsItemService instance = new GetPdsItemService();
	
	public static GetPdsItemService getInstance() {
		return instance;
	}
	
	// PdsItemNotFoundException : 이 예외 객체는 우리가 직접 만들었다. -> extends Exception 해서 만듬
	public PdsItem getPdsItem(int id) throws PdsItemNotFoundException {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			// selectById 메서드 실행 - 이때 id값 들고 간다.
			PdsItem pdsItem = PdsItemDao.getInstance().selectById(conn, id);
			if(pdsItem == null){

				throw new PdsItemNotFoundException("존재하지 않습니다. id : "+id);
			}
			return pdsItem;
		} catch(SQLException e){
			throw new RuntimeException("DB 처리 에러 발생: "+e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	
	
}