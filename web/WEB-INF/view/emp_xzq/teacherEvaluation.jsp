<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/13
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>教师考评</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<table class="layui-hide" id="teacherList" lay-filter="teacherList"></table>
</body>
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
            elem: '#teacherList'
            ,url:'${pageContext.request.contextPath}/jack/teacherListE'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,skin:'nob'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'headTeacherid',templet:function (d) {
                        if(d.headTeacherid == 1){
                            return "授课老师";
                        }else if(d.headTeacherid == 2){
                            return "班主任";
                        }
                    }, title:'编号', width:80,unresize:true,sort: true}
                ,{field:'evaluationType', title:'员工类型', width:200}
                ,{field:'empName', title:'班主任/授课老师', width:150}
                ,{field:'className', title:'班级名称', width:100}
                ,{field:'sum', title:'总评分', width:150}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]

        });
    });
</script>
</html>
