<%--
  Created by IntelliJ IDEA.
  User: Jerry
  Date: 2019/12/19
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看公告</title>
</head>
<body>
    <div style="font-size: 30px;text-align: center;">${LookNotice.title}</div>
    <div style="margin-top: 20px;text-align: center;font-size: 12px;">
        <span>${LookNotice.empid}</span>
        <span style="margin-left: 10px;">${noticeTime}</span>
    </div>

    <div style="font-size: 16px;margin-top: 30px;">
        ${LookNotice.content}
    </div>

</body>
</html>
