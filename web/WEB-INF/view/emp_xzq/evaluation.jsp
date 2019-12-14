<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/13
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考评内容</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<div id="">
<table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
    <tr>
        <td>考评内容:</td>
        <td> <input type="text" id="Evaluation" name="Remark" required lay-verify="required" placeholder="请输入考评类型" autocomplete="off" class="layui-input"></td>
    </tr>
    <tr>
        <td>评价对象:</td>
        <td>
            <select>
                <select name="timeing" lay-filter="type">
                    <option>评价对象</option>
                    <option value="1">授课老师</option>
                    <option value="2">班主任</option>
                </select>
            </select>
        </td>
    </tr>
    <tr>
        <td>说明:</td>
        <td>
            <input type="text" id="Remark" name="Remark" required lay-verify="required" placeholder="请输入考评类型" autocomplete="off" class="layui-input">
        </td>
    </tr>
</table>

<table class="layui-hide" id="headmasterList" lay-filter="headmasterList"></table>
<table class="layui-hide" id="teacherList" lay-filter="teacherList"></table>

</div>
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
            elem: '#headmasterList'
            ,url:'${pageContext.request.contextPath}/jack/headmasterList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'evaluationid', title:'编号', width:80}
                ,{field:'evaluationName', title:'考评内容', width:200}
                ,{field:'evaluationType', title:'考评对象', width:100}
            ]]
            ,page: false

        });
        table.render({
            elem: '#teacherList'
            ,url:'${pageContext.request.contextPath}/jack/teacherList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'evaluationid', title:'编号', width:80}
                ,{field:'evaluationName', title:'考评内容', width:200}
                ,{field:'evaluationType', title:'考评对象', width:100}
            ]]
            ,page: false

        });
    });

</script>
</html>
