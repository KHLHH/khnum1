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
			// pds_item 테이블에 저장되 있는 모든 레코드의 갯수를 가져온다.
			rs = stmt.executeQuery("select count(*) from pds_item");
			
			// next 메서드를 쓰면
			// [count(*)]
			// [숫자]
			
			// next를 해야지만 두번째 자리를 가져온다.
			// rs에서 값을 가져올려면 무조건 next를 쓴다음에 가져오도록 해야한다.
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
			// 쿼리문이 길면 - 보는 방법 - 가장 안쪽의 from 절부터 보도록 하면 된다.
			
			// q1 : select * from pds_item m order by m.pds_item_id desc
			// 가장 안쪽의 from 절보면 - pds_item 테이블에 m이라는 별칭을 붙인다.
			// 해당 테이블에서 id를 기준으로 내림차순으로 정렬 시킨다. - 가장 최근의 글이 위로 올라 올 수 있게 한다.
			
			
			
			// q2 :  select rownum rnum, pds_item_id, filename, realpath, filesize, downloadcount, description from (
			//  ) where rownum <= ?
			// 이제 위의 서브 쿼리에서
			// rownum이라는 가상번호를 붙인다.
			// rownum <= endRow
			// ex. 3번 페이지라면 31번 글 부터 40번 글까지 가져온다. - 위의 경우 endRow = 40
			// q3: select * from (  ) where rnum >= ?
			sql="select * from ( "
					+" select rownum rnum, pds_item_id, filename, realpath, filesize, downloadcount, description from ( "
						+ " select * from pds_item m order by m.pds_item_id desc"
						+ " ) where rownum <= ?"
					+ " ) where rnum >= ?";
			stmt = conn.prepareStatement(sql);


			//  현재 페이지에서 필요한 글 갯수만큼을 뽑아 올 수 있게 만들도록 한다.
			
			stmt.setInt(1, endRow);
			stmt.setInt(2, firstRow);
			rs = stmt.executeQuery();
			
			
			// 레코드가 하나도 없으면, 비어있는 리스트 객체를 만들어서 리턴 시키도록 한다.
			if( !rs.next() ){
				return Collections.emptyList();
			}
			// 레코드에 들이 있으면, 리스트 객체를 만들고
			itemList = new ArrayList<PdsItem>();
			
			// 이미 한번 rs.next() 썼으므로 첫번째 레코드 가지고 있다.
			
			
			// 위의 메서드를 실행 시켜서, 레코드 -> 빈 객체로 만든다.
			// ResultSet의 값들 - PdsItem 객체
			// 예전 같으면 여기 하나에 다 집어 넣었지만, 메서드들을 찢어 냈다.
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
		
		// 레코드를 꺼내서 pds 객체에 셋터를 사용해서 저장
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
			// from 절부터 본다.
			// pds_item 테이블에서 pds_item_id 가 해당인 모든 컬럼의 값을 뽑아 오도록 한다.
			sql="select * from pds_item where pds_item_id = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, itemId);
			rs = stmt.executeQuery();
			
			// 만일 id가 틀리면 - null 값을 리턴
			if(!rs.next() ){
				System.out.println("hefqmk");
				return null;
			}
			// 꺼내온 값이 있으면 - makeItemFromResultSet
			// id는 PK 설정되어서 아이디는 중복이 되지를 않는다.
			// 밑의 메서드를 통해서, 레코드 -> pdsItem 빈 객체로 만들고 돌아온다.
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
			// 컬럼들에 값을 저장하겠다고 지정한다.
			// id에는 시쿼스의 다음값을 적용하도록 한다. 시퀀스명.nextval을 사용한다.
			/* pds_item_id => pds_item_id_seq.NEXTVAL  */
			
			String sql="insert into pds_item "
					+ " (pds_item_id, filename, realpath, filesize, downloadcount, description) "
					+ "  values (pds_item_id_seq.NEXTVAL, ?,?,?, 0, ?)";
			// 위에서 downloadcount는 0을 저장 시킨다.
			

			// filename에는 아까 pdsItem 빈 객체에 넣었던 것 넣고
			// 마지막 컬럼은 description을 넣고
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, item.getFileName() );
			stmt.setString(2, item.getRealPath() );
			stmt.setLong(3, item.getFileSize() );
			stmt.setString(4, item.getDescription() );
			
			// 물음표 ? 에 맞는 값을 바인딩하고, insert 문 을 실행 완료 시켜서, 업로드된 파일의 정보를 올리도록한다.
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			
			// insert가 잘 됬으면,
			if(insertedCount > 0){
				
				// 시퀀스 값을 출력하기 위해서, 다음 테이블
				// 지금 입력한 pds_item_id 값과 똑같다. 이를 뽑아와서 저장하고, 이 값을 그대로 
				sql = "select pds_item_id_seq.CURRVAL from dual";
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			return -1;
		} finally {
			// finally 가 실행되고 나서 return 문이 실행이 되는 것이다.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	

	public int increaseCount(Connection conn, int id) throws SQLException {
		PreparedStatement stmt = null;
		String sql;
		try {
			// id 맞는 것을 다운로드 카운트를 증가 시킨다.
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
			// 컬럼들에 값을 저장하겠다고 지정한다.
			// id에는 시쿼스의 다음값을 적용하도록 한다. 시퀀스명.nextval을 사용한다.
			/* pds_item_id => pds_item_id_seq.NEXTVAL  */
			
			String sql="update pds_item set "
					+ " filename=?, realpath=?, filesize=?, description=? "
					+ " where pds_item_id=?";
			// 위에서 downloadcount는 0을 저장 시킨다.
			

			// filename에는 아까 pdsItem 빈 객체에 넣었던 것 넣고
			// 마지막 컬럼은 description을 넣고
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, item.getFileName() );
			stmt.setString(2, item.getRealPath() );
			stmt.setLong(3, item.getFileSize() );
			stmt.setString(4, item.getDescription() );
			stmt.setInt(5, id );
			
			// 물음표 ? 에 맞는 값을 바인딩하고, insert 문 을 실행 완료 시켜서, 업로드된 파일의 정보를 올리도록한다.
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			return insertedCount;
		} finally {
			// finally 가 실행되고 나서 return 문이 실행이 되는 것이다.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}

	
	public int modifyYesNullFile(Connection conn, PdsItem item, int id) throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			// 컬럼들에 값을 저장하겠다고 지정한다.
			// id에는 시쿼스의 다음값을 적용하도록 한다. 시퀀스명.nextval을 사용한다.
			/* pds_item_id => pds_item_id_seq.NEXTVAL  */
			
			String sql="update pds_item set "
					+ " description=? "
					+ " where pds_item_id=?";
			// 위에서 downloadcount는 0을 저장 시킨다.
			

			// filename에는 아까 pdsItem 빈 객체에 넣었던 것 넣고
			// 마지막 컬럼은 description을 넣고
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, item.getDescription() );
			stmt.setInt(2, id );
			
			// 물음표 ? 에 맞는 값을 바인딩하고, insert 문 을 실행 완료 시켜서, 업로드된 파일의 정보를 올리도록한다.
			int insertedCount = stmt.executeUpdate();
			JdbcUtil.close(stmt);
			return insertedCount;
		} finally {
			// finally 가 실행되고 나서 return 문이 실행이 되는 것이다.
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
			// finally 가 실행되고 나서 return 문이 실행이 되는 것이다.
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
}
