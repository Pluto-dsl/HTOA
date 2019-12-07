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
    <title>谈心记录</title>
    <jsp:include page="${pageContext.request.contextPath}/toPage/include"/>
</head>
<body>
<table id="weekLog" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">

    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="info">查看详情</a>
</script>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#weekLog'
            ,url:'${pageContext.request.contextPath}/ljw/getWeekLogData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'worklogid', title:'ID', width:60, fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称', width:90, fixed: 'left'}
                ,{field:'weekDay', title:'填写日期', width:120, fixed: 'left'}
                ,{field:'weekCur', title:'本周情况描述', width:280, fixed: 'left'}
                ,{field:'studentQuestion', title:'问题学生情况反馈', width:280, fixed: 'left'}
                ,{field:'idea', title:'意见建议',width: 140, minWidth: 200, fixed: 'left'}
                ,{field:'weekNext', title:'下周工作计划',width: 215, minWidth: 200, fixed: 'left'}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:90}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
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
    });
</script>
</html>