<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
// 다운로드 관련 설정 부분이다.
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires", 1L);
%>
<html>
<head>
<title>자료실 목록</title>
<style>
</style>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script>
		$(function(){
			
			function f1() {
				var $this = $(this);
				window.setTimeout(f2, 1000);
				window.setTimeout(f2, 2000);
				window.setTimeout(f2, 3000);
				window.setTimeout(f2, 4000);
				window.setTimeout(f2, 8000);
				function f2(){
					$(".table-wrapper").load("list.jsp table");
				}
				console.log("fqwfwq");
			}
			
			$(".downloadLink").on("click",f1());
			console.log("fwqfqw");
		});
		</script>
</head>
<span class="table-wrapper">
<table>
	<c:if test="${listModel.totalPageCount > 0}">
		<tr>
			<th class="list-inf" colspan="5">
				<div class="float-r">
				${listModel.startRow}-${listModel.endRow}
				[${listModel.requestPage}/${listModel.totalPageCount}]
				</div>
			</td>
		</tr>
	</c:if>
		<tr>
			<th>번호</th>
			<th>파일명</th>
			<th>파일크기</th>
			<th>다운로드회수</th>
			<th>버튼들</th>
		</tr>
		
		<c:choose>
			<c:when test="${listModel.hasPdsItem == false}">
				<tr>
					<td colspan="5">
						게시글이 없습니다.
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="item" items="${listModel.pdsItemList}" varStatus="sta">
					<tr>
						<td>${item.id}</td>
						<td>${item.fileName}</td>
						<td class=" fileSize"><fmt:formatNumber value="${item.fileSize}" type="number"/></td>
						<td class=" downloadCount">${item.downloadCount }</td>
						<td class=" imageButtons">
							<a class="downloadLink" href="download.jsp?id=${item.id}">
								<input type="image" src="http://www.databasecompare.com/uploads/images/SQLServerComparison/downloadSmallIcon.png" />
							</a>
							<a class="modifyLink" href="modify.jsp?id=${item.id}">
								<input type="image" src="http://localvox.com/wp-content/uploads/2013/06/content-icon.jpg" />
							</a>
							<a class="deleteLink" href="delete.jsp?id=${item.id}">
								<input type="image" src="http://findicons.com/files/icons/573/must_have/48/delete.png" />
							</a>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td class="list-footer" colspan="5">
						<div>
							<div class="center list-indexes">
								<c:if test ="${beginPage > 10}">
									<a href="list.jsp?p=${beginPage-1}">이전</a>
								</c:if>
								<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
									<a href="list.jsp?p=${pno}">[${pno}]</a>
								</c:forEach>
								<c:if test="${endPage < listModel.totalPageCount }">
									<a href="list.jsp?p=${endPage + 1}">다음</a>
								</c:if>
							</div>
						</div>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
		<tr>
			<td class="list-footer darker" colspan="5">
				<div>
					<div class="float-r">
						<a href="uploadForm.jsp"><input type="button" value="파일 첨부" onclick=""></a>
					</div>
				</div>
			</td>
		</tr>
</table>
</span>
	


</html>


