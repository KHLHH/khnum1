<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="pds.service.ListPdsItemService"%>
<%@page import="pds.model.PdsItemListModel"%>
<%
// p라는 이름의 값을 가져온다 - 요청한 페이지 번호로 쓰도록 한다.
String pageNumberString = request.getParameter("p");

//페이지번호는 일단 1로 가져온다.
//파라미터의 타입은 String 타입 / page번호는 INT로 가져와야한다.
int pageNumber = 1;

// 파라미터로 전송된 값이 있고, 전송된 값이 있으면 페이지 번호를 int로 바꾸어서 저장을  한다.
// 만일 if문이 실행이 안되면, 위의 pageNumber 1이 그대로 저장이 되게 된다.
if(pageNumberString != null && pageNumberString.length() > 0 ){
	pageNumber = Integer.parseInt(pageNumberString);
}

// getInstance를 사용해서 DAO 객체를 가져오고
ListPdsItemService listService = ListPdsItemService.getInstance();




// item이 다시 있다고 생각을 해보고서, list.jsp의 실행흐름을 확인하도록 하자.
PdsItemListModel itemListModel = listService.getPdsItemList(pageNumber);
//pds 객체들이 저장되 있는 글들 / startRow / endRow / 전체 페이지 갯수 등이 저장이 되어 있다.
request.setAttribute("listModel", itemListModel);


if(itemListModel.getTotalPageCount() > 0 ){
	// 요청 페이지 번호에서 1을 빼고, 
	// 페이지 번호의 시작 번호를 구한다.
	// 10개씩 보여줄 수 있게, begin / end페이지 번호를 구한다.
	int beginPageNumber = (itemListModel.getRequestPage() - 1) / 10 * 10 +1;
	int endPageNumber = beginPageNumber + 9;
	
	// ex. 만일 페이지 번호가 5까지 밖에 없을 경우, 위에만 돌리고 if 안돌리면 1~10 페이지를 보여주게 된다.
	if(endPageNumber > itemListModel.getTotalPageCount() ){
		endPageNumber = itemListModel.getTotalPageCount();
	}
	request.setAttribute("beginPage", beginPageNumber);
	request.setAttribute("endPage", endPageNumber);
}
%>

<jsp:forward page="list_view.jsp" />
