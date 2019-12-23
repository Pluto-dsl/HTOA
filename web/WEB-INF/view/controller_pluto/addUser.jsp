<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/18
  Time: 20:16
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
<form class="layui-form"  id="form1"  method="post">

    <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
        <input type="hidden" name="characterId" id="characterId" value="0"/>
        <tr>
            <th colspan="4">
                <font style="font-size: 25px;">
                    添加角色
                </font>
            </th>
        </tr>
        <tr style="height: 40px">
            <td>
                <label class="label-top">角色名称:</label>

            </td>
            <td>
                <input name="characterName" id="characterName" lay-verify="required" autocomplete="off" class="layui-input" value=""
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

            var laydate = layui.laydate;
            var form = layui.form;

            laydate.render({
                elem: '#savetime'
                // ,format: 'yyyy年MM月dd日'
            });


            form.on('submit(sub)', function(data){
                var data = data.field;

                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/controller/addUser", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:data,
                    success: function(data){
                        document.getElementById("form1").reset();
                        layer.msg('新增成功！');
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
