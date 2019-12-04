<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/4
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <ul id="tt">
    </ul>
</body>
<script>
    var param = {

    }
    var backdata = function(d){
        layui.use('tree', function(){
            var tree = layui.tree;
            //渲染
            var inst1 = tree.render({
                elem: '#tt', //绑定元素
                data:d
            });
        });
    }
    $.post('${pageContext.request.contextPath}/tree?type=tree',param,backdata,"json")

</script>
</html>
