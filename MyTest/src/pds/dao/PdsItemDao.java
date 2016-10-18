package pds.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import pds.model.PdsItem;
import jdbc.JdbcUtil;

public class PdsItemDao {
	private static PdsItemDao instance = new PdsItemDao();
	public static PdsItemDao getInstance() {
		return instance;
	}
	
	private PdsItemDao() {
	}
	
	
	public int selectCount(Connection conn) throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			// pds_item ���̺� ����� �ִ� ��� ���ڵ��� ������ �����´�.
			rs = stmt.executeQuery("select count(*) from pds_item");
			
			// next �޼��带 ����
			// [count(*)]
			// [����]
			
			// next�� �ؾ����� �ι�° �ڸ��� �����´�.
			// rs���� ���� �����÷��� ������ next�� �������� ���������� �ؾ��Ѵ�.
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	
	public List<PdsItem> select(Connection conn, int firstRow, int endRow) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		List<PdsItem> itemList = null;
		String sql;
		
		try {
			// �������� ��� - ���� ��� - ���� ������ from ������ ������ �ϸ� �ȴ�.
			
			// q1 : select * from pds_item m order by m.pds_item_id desc
			// ���� ������ from ������ - pds_item ���̺� m�̶�� ��Ī�� ���δ�.
			// �ش� ���̺��� id�� �������� ������������ ���� ��Ų��. - ���� �ֱ��� ���� ���� �ö� �� �� �ְ� �Ѵ�.
			
			
			
			// q2 :  select rownum rnum, pds_item_id, filename, realpath, filesize, downloadcount, description from (
			//  ) where rownum <= ?
			// ���� ���� ���� ��������
			// rownum�̶�� �����ȣ�� ���δ�.
			// rownum <= endRow
			// ex. 3�� ��������� 31�� �� ���� 40�� �۱��� �����´�. - ���� ��� endRow = 40
			// q3: select * from (  ) where rnum >= ?
			sql="select * from ( "
					+" select rownum rnum, pds_item_id, filename, realpath, filesize, downloadcount, description from ( "
						+ " select * from pds_item m order by m.pds_item_id desc"
						+ " ) where rownum <= ?"
					+ " ) where rnum >= ?";
			stmt = conn.prepareStatement(sql);


			//  ���� ���������� �ʿ��� �� ������ŭ�� �̾� �� �� �ְ� ���鵵�� �Ѵ�.
			
			stmt.setInt(1, endRow);
			stmt.setInt(2, firstRow);
			rs = stmt.executeQuery();
			
			
			// ���ڵ尡 �ϳ��� ������, ����ִ� ����Ʈ ��ü�� ���� ���� ��Ű���� �Ѵ�.
			if( !rs.next() ){
				return Collections.emptyList();
			}
			// ���ڵ忡 ���� ������, ����Ʈ ��ü�� �����
			itemList = new ArrayList<PdsItem>();
			
			// �̹� �ѹ� rs.next() �����Ƿ� ù��° ���ڵ� ������ �ִ�.
			
			
			// ���� �޼��带 ���� ���Ѽ�, ���ڵ� -> �� ��ü�� �����.
			// ResultSet�� ���� - PdsItem ��ü
			// ���� ������ ���� �ϳ��� �� ���� �־�����, �޼������ ���� �´�.
			do {
				PdsItem article = makeItemFromResultSet(rs);
				itemList.add(article);
			} while(rs.next());
		
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
		
		return itemList;
	}
	
	private PdsItem makeItemFromResultSet(ResultSet rs) throws SQLException {
		
		// ���ڵ带 ������ pds ��ü�� ���͸� ����ؼ� ����
		PdsItem item = new PdsItem();
		item.setId(rs.getInt("pds_item_id") );
		item.setFileName(rs.getString("filename") );
		item.setRealPath(rs.getString("realpath") );
		item.setFileSize(rs.getLong("filesize") );
		item.setDownloadCount(rs.getInt("downloadcount"));
		item.setDescription(rs.getString("description"));
		
		return item;
	}
	
	public PdsItem selectById(Connection conn, int itemId) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql;
		try {
			// from ������ ����.
			// pds_item ���̺��� pds_item_id �� �ش��� ��� �÷��� ���� �̾� ������ �Ѵ�.
			sql="select * from pds_item where pds_item_id = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, itemId);
			rs = stmt.executeQuery();
			
			// ���� id�� Ʋ���� - null ���� ����
			if(!rs.next() ){
				System.out.println("hefqmk");
				return null;
			}
			// ������ ���� ������ - makeItemFromResultSet
			// id�� PK �����Ǿ ���̵�� �ߺ��� ������ �ʴ´�.
			// ���� �޼��带 ���ؼ�, ���ڵ� -> pdsItem �� ��ü�� ����� ���ƿ´�.
			PdsItem item = makeItemFromResultSet(rs);
			return item;	
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
		
		
	}
	
	
	public int insert(Connection conn, PdsItem item) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// �÷��鿡 ���� �����ϰڴٰ� �����Ѵ�.
			// id���� �������� �������� �����ϵ��� �Ѵ�. ��������.nextval�� ����Ѵ�.
			/* pds_item_id => pds_item_id_seq.NEXTVAL  */
			
			String sql="insert into pds_item "
					+ " (pds_item_id, filename, realpath, filesize, downloadcount, description) "
					+ "  values (pds_item_id_seq.NEXTVAL, ?,?,?, 0, ?)";
			// ������ downloadcount�� 0�� ���� ��Ų��.
			

			// filename���� �Ʊ� pdsItem �� ��ü�� �־��� �� �ְ�
			// ������ �÷��� description�� �ְ�
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, item.getFileName() );
			stmt.setString(2, item.getRealPath() );
			stmt.setLong(3, item.getFileSize() );
			stmt.setString(4, item.getDescription() );
			
			// ����ǥ ? �� �´� ���� ���ε��ϰ�, insert �� �� ���� �Ϸ� ���Ѽ�, ���ε�� ������ ������ �ø������Ѵ�.
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			
			// insert�� �� ������,
			if(insertedCount > 0){
				
				// ������ ���� ����ϱ� ���ؼ�, ���� ���̺�
				// ���� �Է��� pds_item_id ���� �Ȱ���. �̸� �̾ƿͼ� �����ϰ�, �� ���� �״�� 
				sql = "select pds_item_id_seq.CURRVAL from dual";
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			return -1;
		} finally {
			// finally �� ����ǰ� ���� return ���� ������ �Ǵ� ���̴�.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	

	public int increaseCount(Connection conn, int id) throws SQLException {
		PreparedStatement stmt = null;
		String sql;
		try {
			// id �´� ���� �ٿ�ε� ī��Ʈ�� ���� ��Ų��.
			sql="update pds_item set downloadcount = downloadcount + 1 where pds_item_id = ? ";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			return stmt.executeUpdate();
		} finally {
			JdbcUtil.close(stmt);
		}
	}
	

	
	public int modifyNotNullFile(Connection conn, PdsItem item, int id) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// �÷��鿡 ���� �����ϰڴٰ� �����Ѵ�.
			// id���� �������� �������� �����ϵ��� �Ѵ�. ��������.nextval�� ����Ѵ�.
			/* pds_item_id => pds_item_id_seq.NEXTVAL  */
			
			String sql="update pds_item set "
					+ " filename=?, realpath=?, filesize=?, description=? "
					+ " where pds_item_id=?";
			// ������ downloadcount�� 0�� ���� ��Ų��.
			

			// filename���� �Ʊ� pdsItem �� ��ü�� �־��� �� �ְ�
			// ������ �÷��� description�� �ְ�
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, item.getFileName() );
			stmt.setString(2, item.getRealPath() );
			stmt.setLong(3, item.getFileSize() );
			stmt.setString(4, item.getDescription() );
			stmt.setInt(5, id );
			
			// ����ǥ ? �� �´� ���� ���ε��ϰ�, insert �� �� ���� �Ϸ� ���Ѽ�, ���ε�� ������ ������ �ø������Ѵ�.
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			return insertedCount;
		} finally {
			// finally �� ����ǰ� ���� return ���� ������ �Ǵ� ���̴�.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}

	
	public int modifyYesNullFile(Connection conn, PdsItem item, int id) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// �÷��鿡 ���� �����ϰڴٰ� �����Ѵ�.
			// id���� �������� �������� �����ϵ��� �Ѵ�. ��������.nextval�� ����Ѵ�.
			/* pds_item_id => pds_item_id_seq.NEXTVAL  */
			
			String sql="update pds_item set "
					+ " description=? "
					+ " where pds_item_id=?";
			// ������ downloadcount�� 0�� ���� ��Ų��.
			

			// filename���� �Ʊ� pdsItem �� ��ü�� �־��� �� �ְ�
			// ������ �÷��� description�� �ְ�
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, item.getDescription() );
			stmt.setInt(2, id );
			
			// ����ǥ ? �� �´� ���� ���ε��ϰ�, insert �� �� ���� �Ϸ� ���Ѽ�, ���ε�� ������ ������ �ø������Ѵ�.
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			return insertedCount;
		} finally {
			// finally �� ����ǰ� ���� return ���� ������ �Ǵ� ���̴�.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	
	
	

	public int deleteFile(Connection conn, int id) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql="delete from pds_item where pds_item_id=? ";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id );
			
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			return insertedCount;
		} finally {
			// finally �� ����ǰ� ���� return ���� ������ �Ǵ� ���̴�.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
}
