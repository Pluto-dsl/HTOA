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
    <jsp:include page="../include.jsp" />
</head>
<body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        ddd();

        function ddd() {
            layer.confirm("请选择考评的对象", {
                btn: ['班主任', '授课老师'], //按钮
                cancel: function () {
                    layer.msg('抱歉,禁止关闭请选择~~~', {icon: 1});
                    ddd();
                }
            }, function () {
                layer.msg('进入班主任考评~~~', {icon: 1});
                window.location.href='${pageContext.request.contextPath}/jack/toHeadmasterEva?type=Headmaster';
            }, function () {
                layer.msg('进入授课老师考评~~~', {icon: 1})
                window.location.href='${pageContext.request.contextPath}/jack/toHeadmasterEva?type=Teachar';
            });
        }
    });
</script>
</body>
</html>
