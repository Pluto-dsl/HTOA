<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/6
  Time: 14:28
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
    <title>周报审阅</title>
    <jsp:include page="../include.jsp"/>
    <style>
        .menu{
            margin-top: 8px;
            margin-left: 15px;
            float: left;
        }
        .layui-table-view{
            float: left;
        }
    </style>
</head>
<body>
<div class="menu">
    员工姓名:
    <div class="layui-inline" style="padding-right: 15px">
        <input class="layui-input" name="empName" id="empName" autocomplete="off">
    </div>
</div>
<form class="layui-form menu">
    部门名称:
    <div class="layui-inline" style="padding-right: 15px">
        <select name="depId" lay-verify="required">
            <option value="0" selected>所有部门</option>
            <c:forEach items="${requestScope.depList}" var="dep">
                <option value="${dep.depid}">${dep.depName}</option>
            </c:forEach>
        </select>
    </div>
</form>
<div class="menu">
    开始日期:
    <div class="layui-inline" style="padding-right: 15px">
        <input type="text" id="startDay" name="startDay" autocomplete="off" class="layui-input">
    </div>
</div>
<div class="menu">
    结束日期:
    <div class="layui-inline" style="padding-right: 15px">
        <input type="text" id="endDay" name="endDay" autocomplete="off" class="layui-input">
    </div>
</div>
<button class="layui-btn menu" id="btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
<table id="weekLog" lay-filter="test" style="float: left"></table>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="info" style="float: left">查看详情</a>
</script>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var tableIns = table.render({
            elem: '#weekLog'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/ljw/getWeekLogData'
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '用户数据表'
            ,cols: [[
                {field:'worklogid', title:'ID', width:60, fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称', width:90, fixed: 'left'}
                ,{field:'weekDay', title:'填写日期', width:120, fixed: 'left', unresize: true, sort: true}
                ,{field:'weekCur', title:'本周情况描述', width:280, fixed: 'left'}
                ,{field:'studentQuestion', title:'问题学生情况反馈', width:280, fixed: 'left'}
                ,{field:'idea', title:'意见建议',width: 140, minWidth: 200, fixed: 'left'}
                ,{field:'weekNext', title:'下周工作计划',width: 215, minWidth: 200, fixed: 'left'}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:90}
            ]]
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'info'){
                console.log(data);
                console.log(data.worklogid);
                window.location.href='<%=request.getContextPath()%>/ljw/lookEmpPaperPage/'+data.worklogid;
            }
        });
        //重载表格
        $("#btn").click(function () {
            console.log("fasfd");
            //获取条件
            var empName = $('input[name="empName"]').val();
            var depId = $('select[name="depId"] option:selected').val();
            var startDay = $('input[name="startDay"]').val();
            var endDay = $('input[name="endDay"]').val();
            //调用重载方法
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    empName:empName,
                    depId:depId,
                    startDay:startDay,
                    endDay:endDay
                }
                ,method:'post'
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });
    });
    //初始化时间选择框
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#startDay' //指定元素
            ,format:'yyyy/MM/dd'
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#endDay' //指定元素
            ,format:'yyyy/MM/dd'
        });
    });
</script>
</html>