<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/15
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        layer.confirm('您是如何看待前端开发？', {
            btn: ['班主任', '授课老师'] //按钮
        }, function () {
            layer.msg('进入班主任考评~~~',{icon: 1});
        }, function () {
            layer.msg('进入授课老师考评~~~',{icon: 1})
        });
    });
</script>
</body>
</html>
