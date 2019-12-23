<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/18
  Time: 8:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的任务页面</title>
    <jsp:include page="../../include.jsp" />
</head>
<body>
    <h1 style="margin-left: 42%">请假审批</h1>
    <a style="float: left;" href="javascript:void(0)" onclick="toleave()" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回请假管理</a>
    <table class="layui-table" lay-filter="test">
        <colgroup>
            <col>
            <col>
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>编号</th>
            <th>请假人</th>
            <th>请假时长</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>状态</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${tasklist}" var="t">
            <tr bgcolor="white">
                <td>${t.holidayid}</td>
                <td>${t.empName}</td>
                <td>${t.hour}</td>
                <td>${t.startTime}</td>
                <td>${t.endTime}</td>
                <td>
                    <c:if test="${t.status==1}">审批中</c:if>
                    <c:if test="${t.status==2}">已完成</c:if>
                    <c:if test="${t.status==3}">不批准</c:if>
                </td>
                <td>${t.Remark}</td>
                <td>
                    <a class="layui-btn layui-btn-primary layui-btn-sm" href="<%=request.getContextPath()%>/zeroLeave/taskDetaill?taskId=${t.taskid}&instanceid=${t.processInstanceId}">查看详情</a>
                    <a target="_blank" class="layui-btn layui-btn-primary layui-btn-sm" href="<%=request.getContextPath()%>/zeroLeave/taskImg?holidayid=${t.holidayid}&instanceid=${t.processInstanceId}">办理进度</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看详情</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="taskImg" >办理进度</a>
</script>
<script>
    function toleave() {
        window.location.href="<%=request.getContextPath()%>/zeroLeave/toleave";
    }
</script>
</html>
