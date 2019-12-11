<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/8
  Time: 20:31
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
    <title>报修申请</title>
    <jsp:include page="${pageContext.request.contextPath}/toPage/include"/>
</head>
<body>
<button id="btn" class="layui-btn" style="margin-top: 10px;margin-left: 10px;" value="1">切换学生报修</button>
<table id="RepairList" lay-filter="test"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="ok">完成</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</body>
<script>
    layui.use('table', function(){
        //定义学生报修表头
        var stuCols = [[
            {field:'equipmentId', title:'报修编号', width:120, fixed: 'left', unresize: true, sort: true}
            ,{field:'equipmentType', title:'保修设备名称',width: 160,fixed: 'left'}
            ,{field:'depName', title:'班级名称', width:100, fixed: 'left'}
            ,{field:'empName', title:'学生姓名', width:100, fixed: 'left'}
            ,{field:'startTime', title:'开始时间', width:160, fixed: 'left'}
            ,{field:'endTime', title:'结束时间', width:160, fixed: 'left'}
            ,{field:'remark', title:'备注',width: 320,fixed: 'left'}
            ,{field:'status', title:'状态',width: 80, minWidth: 200, fixed: 'left'}
            ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:120}
        ]];
        //定义员工报修表头
        var empCols = [[
            {field:'equipmentId', title:'报修编号', width:120, fixed: 'left', unresize: true, sort: true}
            ,{field:'equipmentType', title:'保修设备名称',width: 160,fixed: 'left'}
            ,{field:'depName', title:'部门名称', width:100, fixed: 'left'}
            ,{field:'empName', title:'员工姓名', width:100, fixed: 'left'}
            ,{field:'startTime', title:'开始时间', width:160, fixed: 'left'}
            ,{field:'endTime', title:'结束时间', width:160, fixed: 'left'}
            ,{field:'remark', title:'备注',width: 320,fixed: 'left'}
            ,{field:'status', title:'状态',width: 80, minWidth: 200, fixed: 'left'}
            ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:120}
        ]];
        var table = layui.table;
        var tableInt = table.render({
            elem: '#RepairList'
            ,url:'${pageContext.request.contextPath}/logs/getEmpRepairData'
            ,title: '我的报修列表'
            ,cols: empCols
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            console.log(obj.event);
            if (obj.event === 'del') {
                console.log(data);
            }else if(obj.event === 'ok'){

            }
        });

        //切换为学生列表
        $("#btn").click(function () {
            var cols = [];
            console.log(this);
            var type = $(this).val();
            if ($(this).val()==="1"){
                cols = stuCols;
                $(this).text("切换员工");
                $(this).val("2");
            }else {
                cols = empCols;
                $(this).text("切换学生");
                $(this).val("1");
            }
            tableInt.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    type:type
                }
                ,cols: cols
                ,method:'post'
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });
    });
</script>
</html>