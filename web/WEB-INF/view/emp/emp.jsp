<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/4
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../include.jsp"/>
<head>
    <title>员工展示页</title>
</head>
<body>
    <table id="demo" lay-filter="test"></table>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '<%=request.getContextPath()%>/allemp' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'empId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'empName', title: '员工姓名', width:80}
                ,{field: 'depName', title: '部门', width:80, sort: true}
                ,{field: 'postName', title: '职务', width:80}
                ,{field: 'Sex', title: '性别', width: 177}
                ,{field: 'Phone', title: '手机号码', width: 80, sort: true}
                ,{field: 'Address', title: '家庭地址', width: 80, sort: true}
                ,{field: 'status', title: '状态', width: 80}
            ]]
        });

    });
</script>
</html>
