<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/6
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <table style="width: 100%;height: 50%" class="layui-table">
        <tr>
            <th>编号</th>
            <th>请假人</th>
            <th>假期天数</th>
            <th>开始时间</th>
            <th>结束时间</th>
           <%-- <th>申请类型</th>--%>
            <th>请假事由</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${studentleavelist}" var="list">
            <tr>
                <td>${list.holidayid}</td>
                <td>${list.stuname}</td>
                <td>${list.holidayDay}</td>
                <td>${list.startTime}</td>
                <td>${list.endTime}</td>
                <%--<td>${list.ritle}</td>--%>
                <td>${list.remark}</td>
                <td>${list.status}</td>
                <td>
                    <a href="<%=request.getContextPath()%>/student/studentexamine?taskid=${list.taskid}&instance=${list.processInstanceId}">查看详情</a>
                </td>
            </tr>
        </c:forEach>
        <%--<tr>
            <td colspan="8" align="center">
                <div id="demo2"></div>
            </td>
        </tr>--%>
    </table>
</body>
<%--<script>
    layui.use(['laypage', 'layer'], function(){
        var laypage = layui.laypage;
        laypage.render({
            elem: 'demo2'
            ,count: 100
            ,theme: '#1E9FFF'
        });
    })
</script>--%>
</html>