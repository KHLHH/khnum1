<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="pds.service.ListPdsItemService"%>
<%@page import="pds.model.PdsItemListModel"%>
<%
String pageNumberString = request.getParameter("p");

int pageNumber = 1;

if(pageNumberString != null && pageNumberString.length() > 0 ){
	pageNumber = Integer.parseInt(pageNumberString);
}

ListPdsItemService listService = ListPdsItemService.getInstance();



PdsItemListModel itemListModel = listService.getPdsItemList(pageNumber);
request.setAttribute("listModel", itemListModel);


if(itemListModel.getTotalPageCount() > 0 ){
	int beginPageNumber = (itemListModel.getRequestPage() - 1) / 10 * 10 +1;
	int endPageNumber = beginPageNumber + 9;
	if(endPageNumber > itemListModel.getTotalPageCount() ){
		endPageNumber = itemListModel.getTotalPageCount();
	}
	request.setAttribute("beginPage", beginPageNumber);
	request.setAttribute("endPage", endPageNumber);
}
%>

<jsp:forward page="list_view.jsp" />
