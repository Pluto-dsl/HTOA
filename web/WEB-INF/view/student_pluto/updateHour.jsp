<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/15
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改宿舍</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/student/updateHour" id="form1" method="post">

    <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
        <input type="hidden" name="Studid" id="stuId" value="${s.studid}"/>
        <tr>
            <th colspan="4">
                <font style="font-size: 25px;">
                    修改学生宿舍
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
            <td>
                <label class="label-top">现宿舍:</label>
            </td>
            <td>
                <input  name="" id="guarantee" value="${hourname}" class="layui-input"
                        style="width:150px;" disabled>
            </td>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">修&nbsp;改&nbsp;至&nbsp;:</label>
            </td>
            <td>
                <select class="layui-form-label" name="hour" id="hour" editable="false" value="1" ditable="false" style="width:150px;">
                    <c:forEach items="${ssList}" var="ss">
                        <option value="${ss.hourid}" <c:if test="${s.huor == ss.hourid}">selected="selected"</c:if>>${ss.huorName}</option>
                    </c:forEach>
                </select>
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
    <script>
        layui.use(['form'], function() {
            var form = layui.form;

            form.on('submit(sub)', function(data){
                var data = data.field;

                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/student/updateHour", // ajax请求路径
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
</form>
</body>
</html>
