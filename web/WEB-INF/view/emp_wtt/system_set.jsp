<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/11
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <div style="width:100%;height:100%">
        <table align="center" style="width: 100%;height: 100%">
            <tr>
                <td align="center">
                    <div style="height: 30px" onclick="alert('aaa')">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        届别设置
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" onclick="alert('aaa')">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        班级类别
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" onclick="alert('aaa')">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        部门管理
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <div style="height: 30px" onclick="alert('aaa')">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        专业设置
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" id="aa" onclick="">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        流程设置
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" onclick="alert('aaa')">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        答辩项目
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
    <script>
        layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {

            $("#aa").click(function () {
                location.href='${pageContext.request.contextPath}/zhq/flow'
            })
        })
    </script>
</html>