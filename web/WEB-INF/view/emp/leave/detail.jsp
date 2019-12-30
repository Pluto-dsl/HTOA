<%@ page import="org.activiti.engine.task.Comment" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/18
  Time: 8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>任务详情</title>
    <jsp:include page="../../include.jsp" />
</head>
<body>
<hr/>
<form  action="<%=request.getContextPath()%>/zeroLeave/ratify" theme="simple" method="post">
    <input type="hidden" name="holidayid" value="${ho.holidayid}"/>
    <input type="hidden" name="taskId" value="${taskId}"/>
    <table class="layui-table" width="90%" cellspacing="1">
        <tr>
            <td align="left">
                <a href="javascript:void(0)" onclick="toleave()" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回我的任务</a>
            </td>
            <th colspan="2" style="text-align: left"><h2 align="letf">员工请假详情</h2></th>
        </tr>
        <tr>
            <td align="right">请假人:</td>
            <td>${empname}</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假开始时间：</td>
            <td><fmt:formatDate timeStyle="yyyy年MM月dd日"  value="${ho.startTime}"></fmt:formatDate></td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假结束时间：</td>
            <td><fmt:formatDate timeStyle="yyyy年MM月dd日"  value="${ho.endTime}"></fmt:formatDate></td>
        </tr>
        <tr bgcolor="white">
            <td align="right">请假时长：</td>
            <td >${ho.hour}小时</td>
        </tr>
        <tr bgcolor="white">
            <td align="right">是否批准：</td>
            <td >
                <select name="flow" style="width: 80px;height: 30px">
                    <%--<c:forEach items="${plist}" var="p">
                        <option value="${p.name}">${p.name}</option>
                    </c:forEach>--%>
                    <option value="审批">审批</option>
                    <option value="拒绝">拒绝</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="right">备注：</td>
            <td ><textarea name="comment"></textarea></td>
        </tr>
        <tr bgcolor="white">
            <td>
            </td>
            <td align="left">
                <button  type="submit" class="layui-btn" style="width: 100px;">提交</button>
            </td>
        </tr>
    </table>
</form>
<hr/>
<table class="layui-table" width="90%" cellspacing="1" bgcolor="#6495ED">
    <colgroup>
        <col>
        <col>
        <col>
        <col>
    </colgroup>
    <tr>
        <th colspan="4" style="text-align: center"><h2>历史审批信息</h2></th>
    </tr>
    <tr>
        <th>ID</th>
        <th>审批时间</th>
        <th>审批人</th>
        <th>批注内容</th>
    </tr>
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
        window.location.href="<%=request.getContextPath()%>/zeroLeave/mytask";
    }
</script>
</html>
