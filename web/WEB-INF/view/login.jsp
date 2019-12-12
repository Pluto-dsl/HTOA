<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/9
  Time: 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="include.jsp" />
    <style>
        #Bcontext{
            width: 100%;
            height: 100%;
            background-color:#40AFFE;
        }
        #login{
            width: 345px;
            height: 325px;
            background-color: white;
            margin: 10% 40%;
            position: absolute;
            z-index: 100;
        }
        #log{
            z-index: 50;
            position: absolute;
            margin: 20% 5%;
        }
    </style>
</head>
<body>
<div id="Bcontext" >
    <div id="log">
        <span style="font-size: 40px;color: white">宏图软件教育-办公管理系统</span>
    </div>
    <div id="login" align="center">
<%--        <form class="layui-form" action="${pageContext.request.contextPath}/jack/login" method="post">--%>
            <table style="border-collapse: separate;border-spacing: 10px 20px;">
                <tr>
                    <th align="center" colspan="2" style="font-size: 30px;">用户登录</th>
                </tr>
                <tr>
                    <td>
                        <i class="layui-icon layui-icon-username" style="    font-size: 30px;position: absolute;margin-left: -35px;margin-top: 5px;"></i>
                        <input type="text" id="acc" name="acc" required lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="layui-icon layui-icon-password" style="font-size: 30px;position: absolute;margin-left: -35px;margin-top: 5px;"></i>
                        <input type="password" id="pwd" name="pwd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input" />
                    </td>
                </tr>
                <tr>
                    <td>验证码:</td>
                    <td></td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <input lay-submit lay-filter="Login" style="width: 150px" type="submit" class="layui-btn layui-btn-danger" value="登录" />
                    </td>
                </tr>
            </table>
<%--    </form>--%>
    </div>
</div>
<script>
    $(document).ready(function(){
        var div=$("#login");
        div.animate({left:'380px'},"slow");
        $("#log").fadeIn(3000);
    });
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

    });
</script>
</body>
</html>
