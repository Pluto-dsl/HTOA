<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/21
  Time: 8:38
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
    <form id="MyForm" class="layui-form" action="${pageContext.request.contextPath}/sysSet/newTerm" method="post"  onsubmit="layer.load(0, {shade: false})">
        <br><br>
        <input type="hidden" name="termIds">
        <div class="layui-form-item">
            <label class="layui-form-label">学期名称</label>
            <div class="layui-input-block" style="width: 515px">
                <input type="text" name="termName" lay-verify="required" autocomplete="off" placeholder="请输入学期名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学期说明</label>
            <div class="layui-input-block" style="width: 515px">
                <textarea name="remark" placeholder="在此输入学期说明" class="layui-textarea"></textarea>
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
<table id="termList" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="newTerm"><i class="layui-icon layui-icon-add-1"></i>新增学期</button>
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
        table.render({
            elem: '#termList'
            ,url:'${pageContext.request.contextPath}/sysSet/getTermData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '学期表'
            ,cols: [[
                {field:'termid', title:'学期编号', width: '120' , unresize: true, sort: true}
                ,{field:'termName', title:'学期名称', width: '160'}
                ,{field:'remark', title:'学期说明',width:'882'}
                ,{fixed:'right', title:'操作', toolbar: '#barDemo', width:'120'}
            ]]
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            console.log(obj);
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'newTerm':
                    layer.open({
                        type: 1,
                        title:'添加学期',
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
                $("input[name='termIds']").val(data.termid);
                $("input[name='termName']").val(data.termName);
                $("textarea[name='remark']").val(data.remark);
                //打开窗口
                layer.open({
                    type: 1,
                    title:'修改学期设置',
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
                layer.confirm('确定删除该学期吗', function(index){
                    layer.close(index);
                    delTerm(obj,obj.data.termid)
                });
            }
        });
    });
</script>
<script>
    //删除学期的方法
    function delTerm(obj,id) {
        console.log(id);
        var index = layer.load(0, {shade: false});
        var data = {id:id};
        $.post("${pageContext.request.contextPath}/sysSet/delTerm",data,function (data) {
            console.log(data);
            layer.close(index);
            if("isUsed" === data){
                layer.msg('删除失败，该专业正在被使用');
            }else {
                obj.del();
                layer.msg("删除成功")
            }
        },"text");
    }
</script>
</html>