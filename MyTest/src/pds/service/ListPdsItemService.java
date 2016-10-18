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
		// 요청한 페이지 들고 오고, 
		if(pageNumber < 0){
			throw new IllegalArgumentException("page number < 0 : "+pageNumber);
		}
		
		// Dao와 connection
		PdsItemDao pdsItemDao = PdsItemDao.getInstance();
		
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();

			// 전체 레코드 수를 가져와서 저장하는 메서드를 실행 / ex. 글이 50개 있다고 하자.
			// 왼쪽의 int는 50이 저장이 된다.
			int totalArticleCount = pdsItemDao.selectCount(conn);


			// 글이 50개 있다고 하면 if문 실행이 안된다.
			if (totalArticleCount == 0){
				return new PdsItemListModel();
			}
			
			
			
			// 전체 페이지 갯수를 구해준다. 위에서의 메서드에서 구하게 되었음.
			int totalPageCount = calculateTotalPageCount(totalArticleCount);
			
			// 현재 페이지에서, 시작할 글번호 ~ 끝 글번호를 구한다.
			int firstRow = (pageNumber - 1 ) * COUNT_PER_PAGE + 1;
			int endRow = firstRow + COUNT_PER_PAGE - 1;
			
			// 마지막 글번호가 전체 글 갯수보다 크면, 전체 글 갯수를, endRow에 삽입을 시키도록 한다.
			if (endRow > totalArticleCount ) {
				endRow = totalArticleCount;
			}
			
			// startRow 와 endRow를 사용해서 메서드 사용
			List<PdsItem> PdsItemList = pdsItemDao.select(conn, firstRow, endRow);
			
			// 위에서 리스트를 가져오고,
			// 이번에는 다른 생성자를 가져온다. 
			// ex. 글의 수가 50개 이면, totalPageCount 가 5이다.
			PdsItemListModel PdsItemListView = new PdsItemListModel(
						PdsItemList, pageNumber, totalPageCount, firstRow, endRow);
			
			return PdsItemListView;
			
		} catch(SQLException e){
			throw new RuntimeException("DB 에러 발생 : gdsfg "+e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
		
		
		
	}
	
	private int calculateTotalPageCount(int totalPdsItemCount ){
		if (totalPdsItemCount == 0){
			return 0;
		}
		// 상수로 선언시킨 페이지당 글 수를 한다.
		// int 형이므로 무조건 소수점은 잘리게 된다. ex. 51개 글이 있으면 pageCount는 5이다.
		int pageCount = totalPdsItemCount / COUNT_PER_PAGE;
		// 만일 나머지 값이 있으면 페이지의 수를 늘리도록하고 리턴한다.
		if (totalPdsItemCount % COUNT_PER_PAGE > 0 ){
			pageCount ++;
		}
		return pageCount;	
	}
	

}