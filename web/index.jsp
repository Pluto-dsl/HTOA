<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/2
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
    <img src="${pageContext.request.contextPath}/imgs/test/index.jpg" alt="">
    <br/>
    欢迎！
  </body>
  <script>
    window.location.href="${pageContext.request.contextPath}/toPage/login"
  </script>
</html>