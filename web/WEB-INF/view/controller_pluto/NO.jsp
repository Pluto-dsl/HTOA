<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/21
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>无权限</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <div>
        <i class="layui-icon layui-icon-face-surprised" style="font-size: 600px; color: #1E9FFF;margin-left: 33%;"></i>
<%--        <i class="layui-icon-face-surprised"></i>--%>
        <br>
        <font style="font-size: 30px;margin-left: 35%;">
            抱歉，您没有此项权限！5秒后将返回主页！拜拜了您内！！！
        </font>
    </div>
</body>
    <script>
        setTimeout(function () {
            window.location.href="${pageContext.request.contextPath}/toPage/oamain";
        },5000)
    </script>
</html>
