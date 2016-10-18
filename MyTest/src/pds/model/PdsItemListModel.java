package pds.model;

import java.util.ArrayList;
import java.util.List;

public class PdsItemListModel {
	private List<PdsItem> pdsItemList;
	private int requestPage;
	private int totalPageCount;
	private int startRow;
	private int endRow;
	
	// 기본 생성자를 사용해서 만들면, 일단 List는 size=0
	// this(~~); 생성자이다.
	// 바로 밑에 있는 생성자를 실행 시킨다.
	public PdsItemListModel(){
		this(new ArrayList<PdsItem>(), 0,0,0,0);
	}
	
	// 위의 깁ㄴ생성자에 의해 불러져서 비어있는 리스트랑 0들이 저장이 되게 된다.
	public PdsItemListModel(List<PdsItem> pdsItemList
			, int requestPageNumber, int totalPageCount
			, int startRow, int endRow ){
		this.pdsItemList = pdsItemList;
		this.requestPage = requestPageNumber;
		this.totalPageCount = totalPageCount;
		this.startRow = startRow;
		this.endRow = endRow;
	}
	
	// 리스트가 있는지 
	// getter 메서드를 부를때
	// 참조변수 
	// 메서드를 직접 부르는 것이 아닌, 변수 명을 그대로 부른다.
	
	// is 나 get이나 같게
	// ${참조변수.hasPdsItem}
	public boolean isHasPdsItem() {
		return ! pdsItemList.isEmpty();
	}
	
	public List<PdsItem> getPdsItemList() {
		return pdsItemList;
	}
	public void setPdsItemList(List<PdsItem> pdsItemList) {
		this.pdsItemList = pdsItemList;
	}
	public int getRequestPage() {
		return requestPage;
	}
	public void setRequestPage(int requestPage) {
		this.requestPage = requestPage;
	}
	public int getTotalPageCount() {
		return totalPageCount;
	}
	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	
	
	
}