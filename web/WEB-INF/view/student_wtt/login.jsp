<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/10/15
  Time: 8:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
</head>
<body>
    <form method="post" action="<%=request.getContextPath()%>/login/loginbind">
        账号：<input type="text" name="user_num"/>
        密码：<input type="text" name="pwd"/>
        <input type="submit" value="登录">
    </form>
</body>
</html>