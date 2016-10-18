package pds.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import pds.dao.PdsItemDao;
import pds.model.PdsItem;
import pds.model.PdsItemListModel;
import mvjsp.jdbc.JdbcUtil;
import mvjsp.jdbc.connection.ConnectionProvider;

public class ListPdsItemService {
	
	private static ListPdsItemService instance = new ListPdsItemService();
	
	public static ListPdsItemService getInstance() {
		return instance;
	}
	
	private ListPdsItemService(){};
	
	
	public static final int COUNT_PER_PAGE = 10;
	
	
	
	public PdsItemListModel getPdsItemList(int pageNumber ){
		// ��û�� ������ ��� ����, 
		if(pageNumber < 0){
			throw new IllegalArgumentException("page number < 0 : "+pageNumber);
		}
		
		// Dao�� connection
		PdsItemDao pdsItemDao = PdsItemDao.getInstance();
		
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();

			// ��ü ���ڵ� ���� �����ͼ� �����ϴ� �޼��带 ���� / ex. ���� 50�� �ִٰ� ����.
			// ������ int�� 50�� ������ �ȴ�.
			int totalArticleCount = pdsItemDao.selectCount(conn);


			// ���� 50�� �ִٰ� �ϸ� if�� ������ �ȵȴ�.
			if (totalArticleCount == 0){
				return new PdsItemListModel();
			}
			
			
			
			// ��ü ������ ������ �����ش�. �������� �޼��忡�� ���ϰ� �Ǿ���.
			int totalPageCount = calculateTotalPageCount(totalArticleCount);
			
			// ���� ����������, ������ �۹�ȣ ~ �� �۹�ȣ�� ���Ѵ�.
			int firstRow = (pageNumber - 1 ) * COUNT_PER_PAGE + 1;
			int endRow = firstRow + COUNT_PER_PAGE - 1;
			
			// ������ �۹�ȣ�� ��ü �� �������� ũ��, ��ü �� ������, endRow�� ������ ��Ű���� �Ѵ�.
			if (endRow > totalArticleCount ) {
				endRow = totalArticleCount;
			}
			
			// startRow �� endRow�� ����ؼ� �޼��� ���
			List<PdsItem> PdsItemList = pdsItemDao.select(conn, firstRow, endRow);
			
			// ������ ����Ʈ�� ��������,
			// �̹����� �ٸ� �����ڸ� �����´�. 
			// ex. ���� ���� 50�� �̸�, totalPageCount �� 5�̴�.
			PdsItemListModel PdsItemListView = new PdsItemListModel(
						PdsItemList, pageNumber, totalPageCount, firstRow, endRow);
			
			return PdsItemListView;
			
		} catch(SQLException e){
			throw new RuntimeException("DB ���� �߻� : gdsfg "+e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
		
		
	}
	
	private int calculateTotalPageCount(int totalPdsItemCount ){
		if (totalPdsItemCount == 0){
			return 0;
		}
		// ����� �����Ų �������� �� ���� �Ѵ�.
		// int ���̹Ƿ� ������ �Ҽ����� �߸��� �ȴ�. ex. 51�� ���� ������ pageCount�� 5�̴�.
		int pageCount = totalPdsItemCount / COUNT_PER_PAGE;
		// ���� ������ ���� ������ �������� ���� �ø������ϰ� �����Ѵ�.
		if (totalPdsItemCount % COUNT_PER_PAGE > 0 ){
			pageCount ++;
		}
		return pageCount;	
	}
	

}