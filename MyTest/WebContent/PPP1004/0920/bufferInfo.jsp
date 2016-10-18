<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page buffer="100kb" autoFlush="false" %>
<html>
<head><title>Buffer Information</title></head>
<body>

BufferSize: <%= out.getBufferSize() %> <br>
RemainSize: <%= out.getRemaining() %> <br>
Auto Flush: <%= out.isAutoFlush() %> <br>

</body>
</html>
