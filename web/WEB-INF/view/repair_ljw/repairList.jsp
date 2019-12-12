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
    <jsp:include page="../include.jsp"/>
    <style>
        .my-badge-dot{
            margin-left: 3px;
            color: #ff3d00;
        }
    </style>
</head>
<body>
<div id="window" style="padding-right:5%;display: none">
    <br><br>
    <div class="layui-form-item">
        <label class="layui-form-label">处理结果：</label>
        <div class="layui-input-block">
            <input type="hidden" name="repairId">
            <input type="text" name="result" autocomplete="off" placeholder="请输入处理结果" class="layui-input">
        </div>
    </div>
    <br>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button name="submit" class="layui-btn">提交</button>
            <button name="close" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </div>
</div>
<div class="layui-tab">
    <ul class="layui-tab-title">
        <li id="empListTitle" class="layui-this">员工维修列表</li>
        <li id="stuListTitle">学生维修列表</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <table id="empRepairList" lay-filter="test"></table>
        </div>
        <div class="layui-tab-item">
            <table id="stuRepairList" lay-filter="test"></table>
        </div>
    </div>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="manage">处理</a>
</script>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var tableIns = table.render({
            elem: '#empRepairList'
            ,url:'${pageContext.request.contextPath}/logs/getEmpRepairData'
            ,title: '我的报修列表'
            ,cols: [[
                {field:'equipmentId', title:'ID', width:60, fixed: 'left', unresize: true, sort: true}
                ,{field:'equipmentType', title:'保修设备名称',width: 140,fixed: 'left'}
                ,{field:'depName', title:'部门名称', width:90 }
                ,{field:'empName', title:'员工姓名', width:90 }
                ,{field:'startTime', title:'申请时间', width:160}
                ,{field:'remark', title:'备注',width: 175}
                ,{field:'empId', title:'处理人',width: 90}
                ,{field:'endTime', title:'处理时间', width:160}
                ,{field:'result', title:'处理详情',width: 175}
                ,{field:'status', title:'状态',width: 80, minWidth: 200}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:84}
            ]]
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
            ,parseData:function (res) {
                if (res.count >= 1){
                    $("#empListTitle").text("员工维修列表");
                    $("#empListTitle").append("<span class='my-badge-dot'>("+res.count+")</span>");
                }else {
                    $("#empListTitle").text("员工维修列表");
                }
            }
        });
        table.render({
            elem: '#stuRepairList'
            ,url:'${pageContext.request.contextPath}/logs/getStuRepairData'
            ,title: '我的报修列表'
            ,cols: [[
                {field:'equipmentId', title:'ID', width:60, fixed: 'left', unresize: true, sort: true}
                ,{field:'equipmentType', title:'保修设备名称',width: 140,fixed: 'left'}
                ,{field:'depName', title:'班级名称', width:150 }
                ,{field:'empName', title:'学生姓名', width:90 }
                ,{field:'startTime', title:'申请时间', width:160}
                ,{field:'remark', title:'备注',width: 145}
                ,{field:'empId', title:'处理人',width: 90}
                ,{field:'endTime', title:'处理时间', width:160}
                ,{field:'result', title:'处理详情',width: 145}
                ,{field:'status', title:'状态',width: 80, minWidth: 200}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:83}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
            ,parseData:function (res) {
                if (res.count >= 1){
                    $("#stuListTitle").text("学生维修列表");
                    $("#stuListTitle").append("<span class='my-badge-dot'>("+res.count+")</span>");
                }else {
                    $("#stuListTitle").text("学生维修列表");
                }
            }
        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            console.log(obj.data);
            if (obj.event === 'manage') {
                $('input[name="repairId"]').val(data.equipmentId);
                layer.open({
                    type: 1,
                    title:'处理设备申请单',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //是否显示关闭按钮
                    area: ['550px', '220px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //是否点击遮罩时关闭
                    content: $('#window'),
                    cancel: function(index, layero){
                        layui.form.render();
                        layer.close(index);
                        return false;
                    }
                });
            }
        });
        //点击提交按钮触发的方法
        $('button[name="submit"]').click(function (obj) {
            var repairId = $('input[name="repairId"]').val();
            var result = $('input[name="result"]').val();
            var data = {
                repairId:repairId,
                result:result
            };
            $.post("${requestScope.context.contextPath}/logs/manageRepair",data,function (data) {
                console.log(data);
                layer.closeAll();
                tableIns.reload({
                    method:'post'
                });
            },"json")
        });
        //点击取消按钮触发的方法
        $('button[name="close"]').click(function (obj) {
            layer.closeAll();
        })
    });
    layui.use('element',function () {
        var $ = layui.jquery;
        var element = layui.element;
    })
</script>
<script>

</script>
</html>