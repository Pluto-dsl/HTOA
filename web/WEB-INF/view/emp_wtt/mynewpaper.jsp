<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <table class="layui-table" lay-skin="line">
        <thead>
            <tr>
                <th>编号</th>
                <th>员工名称</th>
                <th>填写日期</th>
                <th>本周情况描述</th>
                <th>问题学生情况反馈</th>
                <th>意见建议</th>
                <th>下周工作计划</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="paperlist">
                <tr>
                    <td>${paperlist.weeklogid}</td>
                    <td>${paperlist.Empid}</td>
                    <td>${paperlist.Workday}</td>
                    <td>${paperlist.weekCur}</td>
                    <td>${paperlist.studentQuestion}</td>
                    <td>${paperlist.Idea}</td>
                    <td>${paperlist.weekNext}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>