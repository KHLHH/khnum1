
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
       
        // �̹����� ������ ��ο� ����
        File imageFile = new File(
        		realPath+"\\aImage\\image",
            image);
        // ���� �̸��� �����̸� ó��
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
       
        // ����� �̹��� ����
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
alert("���ο� �̹����� ����߽��ϴ�.");
location.href = "list.jsp";
</script>