<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/13
  Time: 15:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>考评内容</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<div id="addWin" style="display: none">
    <form id="addFrom" class="layui-form">
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <td>考评内容:</td>
                <td> <input type="text" id="Evaluation" name="evaluationName" required lay-verify="required" placeholder="请输入考评类型" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>评价对象:</td>
                <td>
                    <select name="evaluationType"  lay-verify="required">
                        <option value="">评价对象</option>
                        <option value="1">授课老师</option>
                        <option value="2">班主任</option>
                    </select>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <button lay-submit lay-filter="addSubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--<div id="editWin" style="display: none">--%>
<%--    <form id="editFrom" class="layui-form">--%>
<%--        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">--%>
<%--            <tr>--%>
<%--                <td>考评内容:</td>--%>
<%--                <td> <input type="text" id="Acontext" name="evaluationName" required lay-verify="required" placeholder="请输入考评类型" autocomplete="off" class="layui-input"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>评价对象:</td>--%>
<%--                <td>--%>
<%--                    <select id="evaluationType" name="evaluationType" lay-filter="type">--%>
<%--                        <option>评价对象</option>--%>
<%--                        <option value="1">授课老师</option>--%>
<%--                        <option value="2">班主任</option>--%>
<%--                    </select>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>说明:</td>--%>
<%--                <td>--%>
<%--                    <input type="text" id="Remark1" name="remark" required lay-verify="required" placeholder="请输入考评类型" autocomplete="off" class="layui-input">--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>--%>
<%--                    <button lay-submit lay-filter="addSubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </form>--%>
<%--</div>--%>
<button class="layui-btn layui-btn-normal" id="addBtn" style="margin-left: 40%;margin-top: 10px;" >添加考评指标</button>
<table class="layui-hide" id="headmasterList" lay-filter="headmasterList"></table>
<table class="layui-hide" id="teacherList" lay-filter="teacherList"></table>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-danger" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</button>
</script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        $("#addBtn").on('click',function () {
            layer.open({
                type: 1,
                title:'添加考评',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['700px', '450px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: false, //开启遮罩关闭
                content: $('#addWin'),
                cancel: function(index, layero){
                    layer.close(index);
                    table.reload('teacherList');
                    table.reload('headmasterList');
                    return false;
                }
            });
        });

        form.on('submit(addSubmit)',function (data) {
            $.ajax({
                url:'${pageContext.request.contextPath}/jack/addEvaluation',
                async:false,
                dataType:'text',
                data:data.field,
                success:function (data) {
                    if(data) {
                        layer.msg("添加成功");
                    }
                }
            });
            table.reload('teacherList');
            table.reload('headmasterList');
        });

        table.render({
            elem: '#headmasterList'
            ,url:'${pageContext.request.contextPath}/jack/headmasterList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,skin:'nob'
            ,title: '用户数据表'
            ,cols: [[
                {field:'evaluationid', title:'编号', width:80}
                ,{field:'evaluationName', title:'考评内容', width:300}
                ,{field:'evaluationType',templet:function (d) {
                        if(d.evaluationType == 2){
                            return '班主任';
                        }
                    }, title:'考评对象', width:150}
                ,{title:'操作',toolbar:"#barDemo", width:200}
            ]]
            ,page: false

        });
        table.render({
            elem: '#teacherList'
            ,url:'${pageContext.request.contextPath}/jack/teacherList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,skin:'nob'
            ,cols: [[
                {field:'evaluationid', title:'编号', width:80}
                ,{field:'evaluationName', title:'考评内容', width:300}
                ,{field:'evaluationType',templet:function (d) {
                        if(d.evaluationType == 1){
                            return '授课老师';
                        }
                    }, title:'考评对象', width:150}
                ,{title:'操作',toolbar:"#barDemo", width:200}
            ]]
            ,page: false

        });

        //授课老师
        table.on('tool(teacherList)',function (obj) {
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('确认真的删除吗?',function (index) {
                    $.get("${pageContext.request.contextPath}/jack/delEvaluation",{evaluationid:data.evaluationid},function (result) {
                        if(result === '成功'){
                            layer.msg("删除成功");
                            table.reload('teacherList');
                        }
                    },'text');
                    table.reload('teacherList');
                    layer.close(index);
                });
            }
        });

        //班主任
        table.on('tool(headmasterList)',function (obj) {
            var data = obj.data;
            if(obj.event === 'del') {
                layer.confirm('确认真的删除吗?',function (index) {
                    $.get("${pageContext.request.contextPath}/jack/delEvaluation",{evaluationid:data.evaluationid},function (result) {
                        if(result === '成功'){
                            layer.msg("删除成功");
                            table.reload('teacherList');
                        }
                    },'text');
                    table.reload('headmasterList');
                    layer.close(index);
                });
            }
        });
    });



</script>
</html>
