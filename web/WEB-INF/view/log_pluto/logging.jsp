<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/24
  Time: 20:42
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
    <title>日志</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
        </div>
    </script>
    <script type="text/html" id="barDemo">
    </script>
<div style="width: 100%;height: 100%">
    <table class="layui-hide" id="log" lay-filter="log"></table>
</div>

<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#log'
            ,url:'${pageContext.request.contextPath}/log/getLogData'
            // ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '日志报表'
            ,cellMinWidth: 80
            ,cols: [[
                {type: 'radio', fixed: 'left'}
                ,{field:'logId', title:'编号'}
                ,{field:'ipAddr', title:'访问IP'}
                ,{field:'empId', title:'操作人ID'}
                ,{field:'empName', title:'操作人姓名'}
                ,{field:'optime', title:'操作时间'}
                ,{field:'msg', title:'操作内容'}
                // ,{fixed: 'right', title:'操作', toolbar: '#barDemo',width:250}
            ]]
            ,page: true
        });

    });
</script>
</body>
</html>
