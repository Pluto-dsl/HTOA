<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/17
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/StudentScore/editscore" id="form1" method="post">
    <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
        <input type="hidden" name="scoreId" id="scoreId" value="${sc.scoreId}"/>
        <input type="hidden" name="stuid" id="stuid" value="${sc.stuid}"/>
        <tr>
            <th colspan="4">
                <font style="font-size: 25px;">
                    修改学生成绩
                </font>
            </th>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">学&nbsp;生&nbsp;姓&nbsp;名:</label>

            </td>
            <td>
                <label class="label-top">${s.stuname}</label>
            </td>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">科目:</label>
            </td>
            <td>
                <select class="layui-form-label" name="courseId" value="" id="courseId" editable="false"  ditable="false" style="width:290px;">
                    <c:forEach items="${kList}" var="k" >
                        <option value="${k.courseId}" <c:if test="${k.courseId eq sc.courseId}">selected="selected"</c:if>>${k.courseName}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <label class="label-top">考试类别:</label>
            </td>
            <td>
                <select class="layui-form-label" name="testType" id="testType" editable="false" value="1" ditable="false"
                        style="width:290px;">
                    <option value="1" <c:if test="${sc.testType == 1}">selected="selected"</c:if>>笔试</option>
                    <option value="2" <c:if test="${sc.testType == 2}">selected="selected"</c:if>>机试</option>
                    <option value="3" <c:if test="${sc.testType == 3}">selected="selected"</c:if>>模拟面试</option>
                </select>
            </td>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">在读学期:</label>
            </td>
            <td>
                <select class="layui-form-label" name="termid" value="" id="termid" editable="false"  ditable="false" style="width:290px;">
                    <c:forEach items="${xList}" var="x" >
                        <option value="${x.termid}" <c:if test="${x.termid eq sc.termid}">selected="selected"</c:if>>${x.termName}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                <label class="label-top">考试成绩:</label>
            </td>
            <td>
                <input name="score" id="score" maxlength="10" autocomplete="off" class="layui-input" value="${sc.score}"
                       style="width:290px;">
            </td>
        </tr>

        <tr style="height: 40px">
            <td>
                <label class="label-top">补考成绩:</label>
            </td>
            <td>
                <input name="res" id="res"  maxlength="10"  autocomplete="off" class="layui-input" value="${sc.Rescore}"
                       style="width:290px;">
            </td>
            <td>
                <label class="label-top">考试时间:</label>
            </td>
            <td>
<%--                <input name="scoreTime" id="scoreTime" autocomplete="off" class="layui-input" value=""--%>
<%--                       style="width:290px;">--%>
                <input class="layui-input" type="text" value="${sc.scoreTime}" placeholder="请选择考试时间" autocomplete="off" name="scoreTime" id="scoreTime"
                       editable="false"  style="width:290px;">
            </td>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">备注:</label>
            </td>
            <td>
                <textarea placeholder="请输入内容"  maxlength="100"  name="remark" class="layui-textarea">
                    ${sc.remark}
                </textarea>
            </td>

        </tr>

        <tr style="height: 40px">
            <td colspan="4">
                <center>
                    <button class="layui-btn" id="submit" lay-submit lay-filter="sub">保存</button>
                </center>
            </td>
        </tr>
    </table>
</form>
<script>
    layui.use(['laydate','form'], function() {

        var laydate = layui.laydate;
        var form = layui.form;

        laydate.render({
            elem: '#Time'
            // ,format: 'yyyy年MM月dd日'
        });


        form.on('submit(sub)', function(data){
            var data = data.field;

            $.ajax({
                type: 'post',
                url: "${pageContext.request.contextPath}/StudentScore/editscore", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    document.getElementById("form1").reset();
                    layer.msg('修改成功！');
                }
            });
            window.parent.location.reload();
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);//关闭当前页
        })
    })
</script>
</body>
</html>
