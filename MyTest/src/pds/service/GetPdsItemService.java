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
	
	// PdsItemNotFoundException : �� ���� ��ü�� �츮�� ���� �������. -> extends Exception �ؼ� ����
	public PdsItem getPdsItem(int id) throws PdsItemNotFoundException {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			// selectById �޼��� ���� - �̶� id�� ��� ����.
			PdsItem pdsItem = PdsItemDao.getInstance().selectById(conn, id);
			if(pdsItem == null){

				throw new PdsItemNotFoundException("�������� �ʽ��ϴ�. id : "+id);
			}
			return pdsItem;
		} catch(SQLException e){
			throw new RuntimeException("DB ó�� ���� �߻�: "+e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	
	
}