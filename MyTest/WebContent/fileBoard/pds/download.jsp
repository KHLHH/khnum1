<%@ page pageEncoding="utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="pds.service.IncreaseDownloadCountService"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="pds.service.PdsItemNotFoundException"%>
<%@page import="pds.file.FileDownloadHelper"%>
<%@page import="pds.model.PdsItem"%>
<%@page import="pds.service.GetPdsItemService"%>


<%
//id 저장하고 있는 것은 number 타입 -> parseInt
int id = Integer.parseInt(request.getParameter("id") );
try {
	// 이때 id 값을 들고 간다.
	PdsItem item = GetPdsItemService.getInstance().getPdsItem(id);
	
	// 응답 헤더 다운로드 설정
	response.reset();
	// 응답 헤더 설정을 하도록 한다. - 일단 파일명이 필요하다. - db에서 위에서 꺼내왔다.
	// item이라는 변수명의
	// 일단 바이트 배열로 바꾸고서 -  인코딩을 잘 맞춰준다음에 해야한다.
	// 만일 utf-8로 다른 페이지가 설정 도
	String fileName = new String(item.getFileName().getBytes("utf-8"), "iso-8859-1" );
	
	// 컨텐트타입 먹이고, filename을 아까 만든 것으로 한다.
	response.setContentType("application/octet-stream");
	
	// 만일 filename="abc"로 하면 죄다 abc 파일만 받아 진다.
	response.setHeader("Content-Disposition","attachment; filename=\""+fileName+"\"");
	
	response.setHeader("Content-Transfer-Encoding","binary");
	response.setContentLength((int) item.getFileSize() );
	response.setHeader("Pragma","no-cache;");
	response.setHeader("Expires", "-1;");
	
	// response에 대해 헤더 설정 완료시
	
	// 파일을 진짜 보낼려면 response에 넣도록 하면, 
	// response
	// [Application] ==> [Response] - 이렇게 연결을 시키도록 한다.
	FileDownloadHelper.copy(item.getRealPath(), response.getOutputStream() );
	
	
	
	// 여기까지 하면 response가 client에 전달 되면서 다운로드 완료
	// 아마 위의 부분이 바뀔 부분은 거의 없다.
	response.getOutputStream().close();
	
	
	
	// 다운로드가 끝났으므로 다운로드 횟수를 한번 증가를 시키도록 한다.
	IncreaseDownloadCountService.getInstance().increaseCount(id);
} catch(PdsItemNotFoundException ex){
	response.setStatus(HttpServletResponse.SC_NOT_FOUND);
}



%>