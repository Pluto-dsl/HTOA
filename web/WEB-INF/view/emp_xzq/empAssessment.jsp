<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/10
  Time: 20:32
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
</body>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</button>
    <button class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</button>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        //员工考核列表
        table.render({
            elem: '#AduitLoglist'
            ,url:'${pageContext.request.contextPath}/jack/AduitLogList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'aduitLogid', title:'编号', width:300,unresize:true,sort: true}
                ,{field:'aduitName', title:'考核内容', width:200}
                ,{field:'empName', title:'员工', width:150}
                ,{title:'Scores', title:'考核分数  ', width:100}
                ,{title:'auditDate', title:'考核时间 ', width:200}
                ,{title:'auditPerson', title:'录入人员', width:120}
                ,{title:'Remark', title:'说明', width:200}
                ,{title:'操作',toolbar:'#barDemo',width:200}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]

        });

    });
</script>
</html>
