package pds.model;

import java.util.ArrayList;
import java.util.List;

public class PdsItemListModel {
	private List<PdsItem> pdsItemList;
	private int requestPage;
	private int totalPageCount;
	private int startRow;
	private int endRow;
	
	// �⺻ �����ڸ� ����ؼ� �����, �ϴ� List�� size=0
	// this(~~); �������̴�.
	// �ٷ� �ؿ� �ִ� �����ڸ� ���� ��Ų��.
	public PdsItemListModel(){
		this(new ArrayList<PdsItem>(), 0,0,0,0);
	}
	
	// ���� �餤�����ڿ� ���� �ҷ����� ����ִ� ����Ʈ�� 0���� ������ �ǰ� �ȴ�.
	public PdsItemListModel(List<PdsItem> pdsItemList
			, int requestPageNumber, int totalPageCount
			, int startRow, int endRow ){
		this.pdsItemList = pdsItemList;
		this.requestPage = requestPageNumber;
		this.totalPageCount = totalPageCount;
		this.startRow = startRow;
		this.endRow = endRow;
	}
	
	// ����Ʈ�� �ִ��� 
	// getter �޼��带 �θ���
	// �������� 
	// �޼��带 ���� �θ��� ���� �ƴ�, ���� ���� �״�� �θ���.
	
	// is �� get�̳� ����
	// ${��������.hasPdsItem}
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