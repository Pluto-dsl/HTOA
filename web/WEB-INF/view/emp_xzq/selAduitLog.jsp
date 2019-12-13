<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/12
  Time: 8:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <table class="layui-hide" id="AduitLoglist" lay-filter="AduitLoglist"></table>
    <div><img id="img" style="margin-left: 25%" width="300px" height="300px" src="" ></div>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;
        var id = ${id};

        table.render({
            elem: '#AduitLoglist'
            ,url:'${pageContext.request.contextPath}/jack/selAduitLog?id='+id
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                ,{field:'aduitLogid', title:'考核内容', width:200}
                ,{field:'empName', title:'员工', width:150}
                ,{field:'Scores', title:'考核分数  ', width:100}
                ,{field:'auditDate', title:'考核时间 ',templet : "<div>{{layui.util.toDateString(d.auditDate, 'yyyy年MM月dd日')}}</div>", width:200}
                ,{field:'auditPerson', title:'录入人员', width:120}
                ,{field:'Remark', title:'说明', width:200}
                ,{ templet:function (d) {
                    $("#img").attr("src",d.Image);
                    } }
            ]]
            ,page: false

        });
    });

</script>
</html>
