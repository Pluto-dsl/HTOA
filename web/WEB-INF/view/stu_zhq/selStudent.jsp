<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/11
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查看宿舍学生</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <table id="demo"  lay-filter="test"></table>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //执行渲染
        table.render({
            elem: '#demo', //指定原始表格元素选择器（推荐id选择器）
            height: 356, //容器高度
            title:'宿舍管理',
            url:"${pageContext.request.contextPath}/selDorm",
            cols: [[ //标题栏
                ,{field: 'huorName', title: '宿舍房号', width: 150}
                ,{field: 'floorName', title: '所在班级', width: 200}
                ,{field: 'numberBeds', title: '学生姓名', width: 100}
                ,{field: 'count', title: '学生号码', width: 150}
            ]]
        });

    })
</script>
</html>
