<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/16
  Time: 22:06
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
<form class="layui-form" action="${pageContext.request.contextPath}/student/updJt" id="form1" method="post">

    <input type="hidden" name="stuid" id="stuid" value="${s.studid}" class="layui-input"/>
    <input type="hidden" name="familyid" id="familyid" value="${f.familyid}" class="layui-input"/>
    <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
        <tr>
            <th colspan="4">
                <font style="font-size: 25px;">
                    修改家庭信息
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
                <label class="label-top">亲属姓名:</label>
            </td>
            <td colspan="3">
                <input  name="familyname"  maxlength="10" value="${f.familyname}" id="familyname" class="layui-input"
                        style="width:290px;">
            </td>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">与学生关系:</label>
            </td>
            <td >
                <select class="layui-form-label" name="relation" id="relation" editable="false" value="1" ditable="false"
                        style="width:290px;">
                    <option value="父子" <c:if test="${f.relation == '父子'}">selected="selected"</c:if>>父子</option>
                    <option value="母子" <c:if test="${f.relation == '母子'}">selected="selected"</c:if>>母子</option>
                    <option value="父女" <c:if test="${f.relation == '父女'}">selected="selected"</c:if>>父女</option>
                    <option value="母女" <c:if test="${f.relation == '母女'}">selected="selected"</c:if>>母女</option>
                    <option value="其他" <c:if test="${f.relation == '其他'}">selected="selected"</c:if>>其他</option>
                </select>
            </td>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">亲属号码:</label>
            </td>
            <td>
                <input  name="familyhone" lay-verify="phone" value="${f.familyhone}" id="familyhone" class="layui-input"
                        style="width:290px;">
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
        layui.use(['laydate','form'], function() {
            var form = layui.form;

            form.on('submit(sub)', function(data){
                var data = data.field;
                console.log(data)
                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/student/updJt", // ajax请求路径
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
                parent.layer.close(index);      //关闭当前页
            })
        })
    </script>
</form>
</body>
</html>