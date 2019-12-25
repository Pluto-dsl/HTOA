<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/16
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改在校情况</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/student/updatezx" id="form1" method="post">

    <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
        <input type="hidden" name="happenid" id="happenid" value="${zx.happenid}"/>
        <tr>
            <th colspan="4">
                <font style="font-size: 25px;">
                    修改在校情况
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

        </tr><tr style="height: 40px">
        <td>
            <label class="label-top">记录时间:</label>
        </td>
        <td colspan="3">
            <input class="layui-input" type="text" value="<fmt:formatDate value="${zx.optime}" timeStyle="yyyy-MM-dd"></fmt:formatDate>" placeholder="请选择记录时间" autocomplete="off" name="savetime" id="savetime"
                   editable="false"  style="width:290px;">
        </td>
    </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">情况记录:</label>
            </td>
            <td colspan="3">
                <textarea placeholder="请输入内容" name="content" class="layui-textarea">${zx.happening}</textarea>
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
            var laydate = layui.laydate;
            var form = layui.form;
            /*var day2 = new Date();
            day2.setTime(day2.getTime());
            var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();*/
            laydate.render({
                /*type:'date',*/
                elem: '#savetime'
                /*,min: '1990-01-01'
                ,max:s2*/
                // ,format: 'yyyy年MM月dd日'
            });

            form.on('submit(sub)', function(data){
                var data = data.field;

                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/student/updatezx", // ajax请求路径
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
