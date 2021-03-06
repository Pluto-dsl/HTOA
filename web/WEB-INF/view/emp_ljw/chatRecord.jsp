<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/4
  Time: 11:20
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
    <jsp:include page="../include.jsp"/>
    <style>
        .layui-anim-upbit{
            height: 240px;
        }
    </style>
</head>
<body>
<table style="margin-top: 10px;margin-left: 20px;">
    <tr>
        <td>
            员工姓名:
            <div class="layui-inline" style="padding-right: 15px">
                <input class="layui-input" name="empName" id="empName" autocomplete="off">
            </div>
        </td>
        <td>
            <form class="layui-form">
                部门名称:
                <div class="layui-inline" style="padding-right: 15px">
                    <select name="depId">
                        <option value="0" selected>所有部门</option>
                        <c:forEach items="${requestScope.depList}" var="dep">
                            <option value="${dep.depid}">${dep.depName}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
        </td>
        <td>
            开始日期:
            <div class="layui-inline" style="padding-right: 15px">
                <input type="text" id="startDay" name="startDay" autocomplete="off" class="layui-input">
            </div>
        </td>
        <td>
            结束日期:
            <div class="layui-inline" style="padding-right: 15px">
                <input type="text" id="endDay" name="endDay" autocomplete="off" class="layui-input">
            </div>
        </td>
        <td>
            <button class="layui-btn menu" id="btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
        </td>
    </tr>
</table>

<div id="windows" style="margin-left: 5%;display: none;">
    <form id="MyForm" style="width: 94%" class="layui-form" action="${pageContext.request.contextPath}/ljw/newChatRecord" method="post" onsubmit=" layer.load(0, {shade: false});">
        <br><br>
        <input id="chatId" type="hidden" name="chatIds">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">日期选择</label>
                <div class="layui-input-block">
                    <input type="text" id="chatDate" name="chatDate" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">输入地址</label>
                <div class="layui-input-block">
                    <input id="addr" type="text" name="addr" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">选择学生</label>
            <div style="width: 480px;float: left;">
                <select id="sayface" name="sayface" class="layui-select" required lay-verify="required">
                    <option value="">请选择数据</option>
                    <c:forEach items="${requestScope.stuList}" var="stu">
                        <option value="${stu.studid}">${stu.stuname}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="margin: 5px;float: left;">
                <i class="layui-icon layui-icon-help" style="font-size: 24px;color: #666;cursor: pointer;" onclick="layer.msg('如果这里没有学生数据，请检查是否带班');"></i>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">谈心内容</label>
            <div class="layui-input-block" style="width: 515px">
                <textarea id="sayscon" name="sayscon" placeholder="在此输入谈心的内容" class="layui-textarea" lay-verify="required"></textarea>
            </div>
        </div>
        <br>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<table id="chatRecordList" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="newChatRecord"><i class="layui-icon layui-icon-add-1"></i>新增谈心记录</button>
        <button class="layui-btn layui-btn-sm" lay-event="delChatRecordList"><i class="layui-icon layui-icon-delete"></i>删除所选数据</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</body>
<script>
    layui.use(['table','form','laydate'], function(){
        var laydate = layui.laydate;
        var form = layui.form;
        //执行一个laydate实例
        laydate.render({
            elem: '#startDay' //指定元素
            ,format:'yyyy/MM/dd'
            ,max:0
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#endDay' //指定元素
            ,format:'yyyy/MM/dd'
            ,max:0
        });
        //执行一个laydate实例
        laydate.render({
            elem: '#chatDate' //指定元素
            ,format:'yyyy/MM/dd'
            ,max:0
        });
        var table = layui.table;
        var tableIns = table.render({
            elem: '#chatRecordList'
            ,url:'${pageContext.request.contextPath}/ljw/getChatRecordData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'chatId', title:'ID', width:60, fixed: 'left', unresize: true, sort: true}
                ,{field:'sayFace', title:'学生名称', width:90, fixed: 'left'}
                ,{field:'teacher', title:'员工名称', width:90, fixed: 'left'}
                ,{field:'chatDate', title:'时间', width:120, fixed: 'left', unresize: true, sort: true}
                ,{field:'addr', title:'地址', width:170, fixed: 'left'}
                ,{field:'sayscon', title:'谈心内容',width: '45%', minWidth: 200, fixed: 'left'}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:120}
            ]]
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        //重载表格
        $("#btn").click(function () {
            //获取条件
            var empName = $('input[name="empName"]').val();
            var depId = $('select[name="depId"] option:selected').val();
            var startDay = $('input[name="startDay"]').val();
            var endDay = $('input[name="endDay"]').val();
            console.log(empName);
            console.log(depId);
            console.log(startDay);
            console.log(endDay);
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
        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            console.log(obj);
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'newChatRecord':
                    $("#MyForm")[0].reset();
                    layui.form.render();
                    layer.open({
                        type: 1,
                        title:'添加谈心记录',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //是否显示关闭按钮
                        area: ['700px', '420px'],
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
                    break;
                case 'delChatRecordList':
                    var data = checkStatus.data;
                    var msg = "是要删除ID为：";
                    $(data).each(function (index,elemnt) {
                        console.log(elemnt.chatId);
                        msg +=elemnt.chatId+"、";
                    });
                    msg = msg.substr(0,msg.length-1);
                    msg +="的记录吗?";
                    layer.confirm(msg, {
                        btn: ['是的','取消']
                        //按钮
                    }, function(index){
                        $(data).each(function (index,elemnt) {
                            delChatRecord(elemnt.chatId,tableIns);
                        });
                        layer.close(index);
                    },function (index) {
                        layer.close(index);
                    });
                    break;
            }
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('是要删除这条记录吗', function(index){
                    obj.del();
                    layer.close(index);
                    delChatRecord(obj.data.chatId,tableIns)
                });
            } else if(obj.event === 'edit'){
                console.log(data);
                //重置表单数据
                $("#MyForm")[0].reset();
                layui.form.render();
                //为表单赋值
                $("#chatId").val(data.chatId);
                $("#chatDate").val(data.chatDate);
                $("#addr").val(data.addr);
                $("#sayscon").val(data.sayscon);
                $("#teacher").children().each(function (index,element) {
                    if ($(element).text() === data.teacher) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });

                $("#sayface").children().each(function (index,element) {
                    if ($(element).text() === data.sayFace) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });

                //重新渲染表单
                layui.use('form', function() {
                    var element = layui.form;
                    element.render();
                });

                //打开窗口
                layer.open({
                    type: 1,
                    title:'修改谈心记录',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //是否显示关闭按钮
                    area: ['700px', '420px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //是否点击遮罩时关闭
                    content: $('#windows'),
                    cancel: function(index, layero){//点击关闭按钮时触发
                        //重置表单数据
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
<script>
    //删除谈心记录的方法
    function delChatRecord(id,tableIns) {
        var index = layer.load(0, {shade: false});
        var data = {id:id};
        $.post("${pageContext.request.contextPath}/ljw/delChatRecord",data,function (data) {
            layer.close(index);
            console.log(data);
            tableIns.reload();
        },"json");
    }
</script>
</html>