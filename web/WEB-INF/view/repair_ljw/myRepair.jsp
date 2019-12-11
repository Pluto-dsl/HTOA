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
    <jsp:include page="../include.jsp"/>
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
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" name="remark" lay-verify="title" autocomplete="off" placeholder="请输入对维修设备的详情" class="layui-input">
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
                ,{field:'depName', title:'部门名称', width:90 }
                ,{field:'empName', title:'员工姓名', width:90 }
                ,{field:'startTime', title:'申请时间', width:160}
                ,{field:'remark', title:'备注',width: 145}
                ,{field:'empId', title:'处理人',width: 90}
                ,{field:'endTime', title:'处理时间', width:160}
                ,{field:'result', title:'处理详情',width: 145}
                ,{field:'status', title:'状态',width: 80, minWidth: 200}
                ,{fixed:'right', title:'操作',templet:function(d){
                    console.log(d);
                    if (d.status==='未完成'){
                        return '<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>';
                    }else {
                        return ''
                    }
                    }, width:80}
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
        table.on('tool(test)',function (obj) {
            var data = obj.data;
            if ('del' === obj.event){
                layer.confirm('是要删除此申请吗', function(index){
                    obj.del();
                    layer.close(index);
                    delRepair(obj.data.equipmentId)
                });
            }
        })
    });
</script>
<script>
    function delRepair(id) {
        var data = {delRepairId:id};
        $.post("${pageContext.request.contextPath}/logs/delRepair",data,function (data) {
            console.log(data)
        },"json");
    }
</script>
</html>