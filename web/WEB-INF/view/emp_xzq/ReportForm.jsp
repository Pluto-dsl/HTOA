<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/17
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<div style="width: 140px;">
    <h3 style="float: right;">最高平均分</h3>
    <input type="text" id="teacherName" disabled class="layui-input">
    <input type="text" id="score" disabled class="layui-input"/>
</div>
<table class="layui-hide" id="ReportForm" lay-filter="ReportForm"></table>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        table.render({
            elem: '#ReportForm'
            ,url:'${pageContext.request.contextPath}/jack/ReportForm'
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,skin:'line'
            ,cols: [[
                {field:'teacherTotalid', title:'编号', width:80}
                ,{field:'empName', title:'班主任/授课老师', width:180}
                ,{field:'evaluation', title:'老师类型', width:200}
                ,{field:'sugges', title:'问题与意见', width:150}
                ,{field:'avg', title:'平均评分', width:100}
                ]]
            ,page: false
            ,done: function(res, curr, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                var data = res.data;
                $("#teacherName").val(data[0].empName);
                $("#score").val(data[0].avg);
            }
        });

    });
</script>
</html>
