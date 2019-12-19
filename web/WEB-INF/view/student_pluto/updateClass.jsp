<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/15
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>调整班级</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <form class="layui-form" action="${pageContext.request.contextPath}/student/updateClass" id="form1" method="post">
        <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
            <input type="hidden" name="Studid" id="stuId" value="${s.studid}"/>
            <tr>
                <th colspan="4">
                    <font style="font-size: 25px;">
                        修改学生班级
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
                    <label class="label-top">现班级:</label>
                </td>
                <td>
                    <input  name="" id="guarantee" value="${classname}" class="layui-input"
                            style="width:250px;" disabled>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">修&nbsp;改&nbsp;至&nbsp;:</label>
                </td>
                <td colspan="3">
                    <select class="layui-form-label" name="classId" id="classId" editable="false" value="1" ditable="false" style="width:250px;">
                        <c:forEach items="${classList}" var="c">
                            <option value="${c.classId}" <c:if test="${s.clazz == c.classId}">selected="selected"</c:if>>${c.className}</option>
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
                        url: "${pageContext.request.contextPath}/student/updateClass", // ajax请求路径
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
</body>
</html>
