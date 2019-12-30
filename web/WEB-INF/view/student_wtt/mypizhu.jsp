<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/19
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
<button class="layui-btn layui-btn-primary" style="position: fixed" onclick="get_back()"><i class="layui-icon layui-icon-return"></i>返回</button>
    <table class="layui-table" style="width: 70%;margin-left: 20%">
        <tr>
            <th>ID</th>
            <th>审批时间</th>
            <th>审批人</th>
            <th>批注内容</th>
        </tr>
        <c:forEach items="${commentlist}" var="list">
            <tr bgcolor="white">
                <td>${list.id}</td>
                <td>
                    <fmt:formatDate value="${list.time}" type="time"></fmt:formatDate>
                </td>
                <td>
                        ${list.userId}
                </td>
                <td>${list.fullMessage }</td>
            </tr>
        </c:forEach>
    </table>
</body>
<script language="JavaScript">
    function get_back() {
        history.go(-1);
    }
</script>
</html>