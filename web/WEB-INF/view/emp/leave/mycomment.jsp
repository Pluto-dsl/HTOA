<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/18
  Time: 8:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>批注记录</title>
    <jsp:include page="../../include.jsp" />
</head>
<body>
<a  href="javascript:void(0)" onclick="toleave()" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回请假管理</a>
  <h2 style="float: right;margin-right: 50%;">审批记录</h2>
<table class="layui-table">
    <colgroup>
        <col>
        <col>
        <col>
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>ID</th>
        <th>审批时间</th>
        <th>审批人</th>
        <th>批注内容</th>
    </tr>
    </thead>
    <c:forEach items="${commentList}" var="t" varStatus="xh">
        <tr>
            <td>${t.id }</td>
            <td><fmt:formatDate timeStyle="yyyy年MM月dd日"  value="${t.time}"></fmt:formatDate></td>
            <td>${username[xh.index]}</td>
            <td>${t.fullMessage}</td>
        </tr>
    </c:forEach>
</table>
</body>
<script>
    function toleave() {
        window.location.href="<%=request.getContextPath()%>/zeroLeave/toleave";
    }
</script>
</html>
