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
			// Ŀ�ؼ� Ǯ���� Ŀ�ؼ��� �޾� ������ �Ѵ�.
			conn = ConnectionProvider.getConnection();
			
			// AutoCommit�� �Ӽ��� false �Կ���, Transaction�� �����ϵ��� �Ѵ�.
			// �̴� commit�� �ϰų� rollback �Ҷ����� Ʈ������� ����ȴ�.
			conn.setAutoCommit(false);
			
			
			// �Ʊ� upload.jsp���� ���� request ��ü�� pdsItem ��ü�� �����.
			// bean ���Ǹ� ����, ���̺��� ��� �÷��� �����ϵ����Ѵ�.
			// �� Ŭ������ ��ü�� �����.
			PdsItem pdsItem = request.toPdsItem();
			
			
			
			// Dao ��ü�� ����, 
			// �̶�, Ŀ�ؼ� ��ü�� �� ��ü�� ��� ����.
			int id = PdsItemDao.getInstance().insert(conn, pdsItem);
			if (id == -1) {
				// �Ʊ� �� �޼��忡�� ���� 
				JdbcUtil.rollback(conn);
				// ��Ÿ���ͼ����� ���� catch������ SQLException���δ� ���� ���� ����.
				// �׳� ������ �ȴ�.
				throw new RuntimeException("DB ���� �ȵ�");
			}
			pdsItem.setId(id);
			
			// if���� ���� �ȵǸ�, Ʈ�������� commit ���Ѽ� �ݿ� ��Ų��.
			conn.commit();
			
			return pdsItem;
		} catch (SQLException e)  {
			JdbcUtil.rollback(conn);
			// RuntimeException �߻��ϸ� �׳� �ߴ��� �ȴ�.
			throw new RuntimeException(e);
		} finally {
			// �������ʹ� �ٽ� setAutoCommit���� �ڵ� Ŀ���� �ǰ� �Ѵ�.
			if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException e){}
		
			JdbcUtil.close(conn);
		}
	} // ���� upload.jsp�� ���ư���.
	
	

	
	public boolean modifyNotNullFile(AddRequest request, int id) {
		Connection conn = null;
		try {
			// Ŀ�ؼ� Ǯ���� Ŀ�ؼ��� �޾� ������ �Ѵ�.
			conn = ConnectionProvider.getConnection();
			
			// AutoCommit�� �Ӽ��� false �Կ���, Transaction�� �����ϵ��� �Ѵ�.
			// �̴� commit�� �ϰų� rollback �Ҷ����� Ʈ������� ����ȴ�.
			conn.setAutoCommit(false);
			
			
			// �Ʊ� upload.jsp���� ���� request ��ü�� pdsItem ��ü�� �����.
			// bean ���Ǹ� ����, ���̺��� ��� �÷��� �����ϵ����Ѵ�.
			// �� Ŭ������ ��ü�� �����.
			PdsItem pdsItem = request.toPdsItem();
			
			
			
			// Dao ��ü�� ����, 
			// �̶�, Ŀ�ؼ� ��ü�� �� ��ü�� ��� ����.
			PdsItemDao.getInstance().modifyNotNullFile(conn, pdsItem, id);
			
			// if���� ���� �ȵǸ�, Ʈ�������� commit ���Ѽ� �ݿ� ��Ų��.
			conn.commit();
			
			return true;
		} catch (SQLException e)  {
			JdbcUtil.rollback(conn);
			// RuntimeException �߻��ϸ� �׳� �ߴ��� �ȴ�.
			throw new RuntimeException(e);
		} finally {
			// �������ʹ� �ٽ� setAutoCommit���� �ڵ� Ŀ���� �ǰ� �Ѵ�.
			if(conn != null) try { conn.setAutoCommit(true); } catch(SQLException e){}
		
			JdbcUtil.close(conn);
		}
	} // ���� upload.jsp�� ���ư���.
	

	
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

