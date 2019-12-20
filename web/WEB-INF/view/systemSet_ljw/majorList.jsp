<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/19
  Time: 21:14
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
    <title>document</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<div id="windows" style="margin-left: 1%;display: none;">
    <form id="MyForm" class="layui-form" action="${pageContext.request.contextPath}/sysSet/newMajor" method="post" lay-filter="MyForm">
        <br><br>
        <input type="hidden" name="majorids">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">专业名称</label>
                <div class="layui-input-block">
                    <input type="text" name="majorName" placeholder="请输入专业名称" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline" style="margin-left: 15px;">
                <label class="layui-form-label">选择系别</label>
                <div class="layui-input-inline">
                    <select name="deptid" class="layui-select">
                        <c:forEach items="${requestScope.list}" var="dept">
                            <option value="${dept.deptid}">${dept.deptName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">说明</label>
            <div class="layui-input-block" style="width: 515px">
                <textarea name="remark" placeholder="在此输入专业说明" class="layui-textarea"></textarea>
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
<table id="majorList" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="newChatRecord">新增专业</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs" lay-event="edit">编辑</button>
</script>
</body>
<script>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form = layui.form;
        var tableIns = table.render({
            elem: '#majorList'
            ,url:'${pageContext.request.contextPath}/sysSet/getMajorData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '用户数据表'
            ,cols: [[
                {field:'majorid', title:'专业编号', width:120, fixed: 'left', unresize: true, sort: true}
                ,{field:'majorName', title:'专业设置', width:160}
                ,{field:'deptName', title:'院系名称', width:160}
                ,{field:'deptid',hide:true}
                ,{field:'remark', title:'备注', width:809}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:80}
            ]]
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            console.log(obj);
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'newChatRecord':
                    layer.open({
                        type: 1,
                        title:'添加谈心记录',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //是否显示关闭按钮
                        area: ['700px', '350px'],
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
            }
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                //重置表单数据
                $("#MyForm")[0].reset();
                layui.form.render();

                console.log(data);
                form.val('MyForm',{
                    majorids:data.majorid,
                    majorName:data.majorName,
                    deptName:data.deptid,
                    remark:data.remark
                });
                //打开窗口
                layer.open({
                    type: 1,
                    title:'修改谈心记录',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //是否显示关闭按钮
                    area: ['700px', '350px'],
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
<script>
    //删除谈心记录的方法
    function delChatRecord(id) {
        var data = {id:id};
        $.post("${pageContext.request.contextPath}/ljw/delChatRecord",data,function (data) {
            console.log(data)
        },"json");
    }
</script>
</html>