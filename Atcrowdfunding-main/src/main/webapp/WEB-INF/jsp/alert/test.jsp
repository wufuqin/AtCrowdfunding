<%--
  Created by IntelliJ IDEA.
  User: wfq
  Date: 2020/3/6
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试获取上下文路径</title>
</head>
<body>
<script>
    alert(${APP_PATH});
    alert(${pageContext.request.contextPath})
</script>
</body>
</html>
