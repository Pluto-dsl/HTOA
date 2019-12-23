<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/15
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
    <style>
        dl{
            height: 255px;
        }
    </style>
</head>
<body>
<div id="addWin">
    <form id="addFrom" action="${pageContext.request.contextPath}/jack/ajaxEvaluate" class="layui-form" method="post">
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <th id="className">班级:（<font color="#ff4500">${evaluate.className}</font>）</th>
                <th id="teacharName">${teacher}:（<font color="#ff4500">${evaluate.empName}</font>）</th>
                <input type="hidden" value="${teacher}" name="type" />
                <input name="classid" type="hidden" value="${evaluate.classId}" />
                <input name="teacherid" type="hidden" value="${evaluate.empId}" />
            </tr>
            <tr align="center">
                <td>考评题目</td>
                <td>分数</td>
            </tr>
            <c:forEach items="${problem}" var="problem">
            <tr align="center">
                <td id="test">${problem.evaluationName}</td>
                <input type="hidden" name="evaluationid" value="${problem.evaluationid}" />
                <td>
                    <select name="number"  lay-verify="required">
                        <option value="">选择分数</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </td>
            </tr>
            </c:forEach>
            <tr align="center">
                <td colspan="2" id="suggesText" name="suggesText">问题与意见</td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <input type="text" id="sugges" name="sugges"  placeholder="问题与意见" autocomplete="off" class="layui-input">
                </td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <button lay-submit lay-filter="Hsubmit" id="Hsubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
    });
</script>
</html>
