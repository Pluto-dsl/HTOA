<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/20
  Time: 8:43
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
    <form id="MyForm" class="layui-form" action="${pageContext.request.contextPath}/sysSet/newDept" method="post" onsubmit="layer.load(0, {shade: false})">
        <br><br>
        <input type="hidden" name="deptIds">
        <div class="layui-form-item">
            <label class="layui-form-label">系名称</label>
            <div class="layui-input-block" style="width: 515px">
                <input type="text" name="deptName" lay-verify="required" autocomplete="off" placeholder="请输入系名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">说明</label>
            <div class="layui-input-block" style="width: 515px">
                <textarea name="remark" placeholder="在此输入院系说明" class="layui-textarea"></textarea>
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
<table id="deptList" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="newDept"><i class="layui-icon layui-icon-add-1"></i>新增院系</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</body>
<script>
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form = layui.form;
        var tableIns = table.render({
            elem: '#deptList'
            ,url:'${pageContext.request.contextPath}/sysSet/getDeptData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '院系表'
            ,cols: [[
                {field:'deptid', title:'院系编号', width: '120' , unresize: true, sort: true}
                ,{field:'deptName', title:'院系名称', width: '160'}
                ,{field:'remark', title:'院系说明',width:'882'}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:'120'}
            ]]
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            console.log(obj);
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'newDept':
                    layer.open({
                        type: 1,
                        title:'添加院系',
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
                console.log(data);
                //重置表单数据
                $("#MyForm")[0].reset();
                layui.form.render();
                //为表单赋值
                $("input[name='deptIds']").val(data.deptid);
                $("input[name='deptName']").val(data.deptName);
                $("textarea[name='remark']").val(data.remark);
                //打开窗口
                layer.open({
                    type: 1,
                    title:'修改院系设置',
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
            } else if (obj.event === 'del'){
                layer.confirm('确定删除该院系吗', function(index){
                    layer.close(index);
                    delDept(obj,obj.data.deptid,tableIns);
                });
            }
        });
    });
    $("input[name='deptName']").blur(function () {
        var termName = $(this).val();
        var patt = /^[\u4e00-\u9fa5]+$/;
        if (!patt.test(termName)){
            $(this).val("");
            layer.msg("院系名字只能为中文");
            return;
        }
        $("td[data-field='deptName']").each(function (index,element) {
            if($(element).children(":first").text() === $("input[name='deptName']").val()){
                $("input[name='deptName']").val("");
                layer.msg("专业名字重复");
            }
        });
    });
</script>
<script>
    //删除院系的方法
    function delDept(obj,id,tableIns) {
        var index = layer.load(0, {shade: false});
        var data = {id:id};
        $.post("${pageContext.request.contextPath}/sysSet/delDept",data,function (data) {
            console.log(data);
            layer.close(index);
            if("isUsed" === data){
                layer.msg('删除失败，该院系正在被使用');
            }else {
                obj.del();
                tableIns.reload();
                layer.msg("删除成功");
            }
        },"text");
    }
</script>
</html>