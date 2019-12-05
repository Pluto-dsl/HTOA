<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/4
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<div id="test1"></div>
<script>
    layui.use('tree', function(){
        var tree = layui.tree;

        //渲染
        var inst1 = tree.render({
            elem: '#test1'  //绑定元素
            ,data: [{
                title: '江西' //一级菜单
                ,children: [{
                    title: '南昌' //二级菜单
                    ,children: [{
                        title: '高新区' //三级菜单
                        //…… //以此类推，可无限层级
                    }]
                }]
            }]
        });
    });
</script>
</body>
</html>
