
[write.jsp]
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page errorPage = "error_view.jsp" %>

<%@ page import = "java.sql.Timestamp" %>
<%@ page import = "java.io.File" %>
<%@ page import = "org.apache.commons.fileupload.FileItem" %>

<%@ page import = "zzImage.ImageUtil" %>
<%@ page import = "zzImage.FileUploadRequestWrapper" %>

<%@ page import = "zzImage.Theme" %>
<%@ page import = "zzImage.ThemeManager" %>
<%@ page import = "zzImage.ThemeManagerException" %>

<%
	
	String realPath = request.getServletContext().getRealPath("");
    FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(
        request, -1, -1,
        realPath+"\\aImage\\temp");
    HttpServletRequest tempRequest = request;
%>
<jsp:useBean id="theme" class="zzImage.Theme">
    <jsp:setProperty name="theme" property="*" />
</jsp:useBean>
<%
    FileItem imageFileItem = requestWrap.getFileItem("imageFile");
    String image = "";
    if (imageFileItem.getSize() > 0) {
        image = Long.toString(System.currentTimeMillis());
       
        // 이미지를 지정한 경로에 저장
        File imageFile = new File(
        		realPath+"\\aImage\\image",
            image);
        // 같은 이름의 파일이름 처리
        if (imageFile.exists()) {
            for (int i = 0 ; true ; i++) {
                imageFile = new File(
                		realPath+"\\aImage\\image",
                    image+"_"+i);
                if (!imageFile.exists()) {
                    image = image + "_" + i;
                    break;
                }
            }
        }
        imageFileItem.write(imageFile);
       
        // 썸네일 이미지 생성
        File destFile = new File(
        		realPath+"\\aImage\\image",
            image+".small.jpg");
        ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);
    }
   
    theme.setRegister(new Timestamp(System.currentTimeMillis()));
    theme.setImage(image);
   
    ThemeManager manager = ThemeManager.getInstance();
    manager.insert(theme);
%>
<script>
alert("새로운 이미지를 등록했습니다.");
location.href = "list.jsp";
</script>