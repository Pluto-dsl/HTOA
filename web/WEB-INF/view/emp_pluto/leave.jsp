<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/4
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工请假页面</title>
    <jsp:include page="../include.jsp" />
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test" style="text-align: center;"></table>

<div id="page"></div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<%-------------------------------------------------------------%>
<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/empLeave/returnData'
            ,toolbar: '#barDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {field: 'holidayid', title: 'ID', width:200, sort: true, fixed: 'left', totalRowText: '合计：'}
                ,{field: 'Empid', title: '请假人', width:200}
                ,{field: 'holidayDay', title: '请假时长', width: 200, sort: true, totalRow: true}
                ,{field: 'startTime', title: '开始时间', width:200, sort: true}
                ,{field: 'endTime', title: '结束时间', width: 200, sort: true, totalRow: true}
                ,{field: 'status', title: '状态', width: 200}
                ,{field: 'Remark', title: '内容', width: 200}
                ,{fixed: '', title:'操作', width: 290, align:'center', toolbar: '#barDemo'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        })
    })
</script>
</body>
</html>
