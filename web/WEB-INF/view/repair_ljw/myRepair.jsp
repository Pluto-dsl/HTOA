<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/9
  Time: 8:31
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
<div id="windows" style="margin-left: 5%;display: none;">
    <form id="MyForm" class="layui-form" action="${pageContext.request.contextPath}/logs/addRepair" method="post">
        <br><br>
        <div class="layui-form-item">
            <label class="layui-form-label">设备名称</label>
            <div class="layui-input-block">
                <input type="text" name="equipmentType" lay-verify="title" autocomplete="off" placeholder="请输入报修设备名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" name="remark" lay-verify="title" autocomplete="off" placeholder="请输入备注" class="layui-input">
            </div>
        </div>
        <br>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<table id="RepairList" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="newRepair">填写保修申请单</button>
    </div>
</script>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#RepairList'
            ,url:'${pageContext.request.contextPath}/logs/getMyRepairData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '我的报修列表'
            ,cols: [[
                {field:'equipmentId', title:'报修编号', width:120, fixed: 'left', unresize: true, sort: true}
                ,{field:'equipmentType', title:'保修设备名称',width: 160,fixed: 'left'}
                ,{field:'depName', title:'部门名称', width:100, fixed: 'left'}
                ,{field:'empName', title:'员工姓名', width:100, fixed: 'left'}
                ,{field:'startTime', title:'开始时间', width:160, fixed: 'left'}
                ,{field:'endTime', title:'结束时间', width:160, fixed: 'left'}
                ,{field:'remark', title:'备注',width: 360,fixed: 'left'}
                ,{field:'status', title:'状态',width: 120, minWidth: 200, fixed: 'left'}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            console.log(obj);
            if(obj.event === "newRepair"){
                layer.open({
                    type: 1,
                    title:'填写设备申请单',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //是否显示关闭按钮
                    area: ['700px', '280px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //是否点击遮罩时关闭
                    content: $('#windows'),
                    cancel: function(index, layero){
                        $("#MyForm")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        return false;
                    }
                });
            }
        });
    });
</script>
</html>