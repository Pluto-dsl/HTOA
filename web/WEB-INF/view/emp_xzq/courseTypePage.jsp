<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/6
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程类型</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<%--添加弹出层--%>
<div id="addWin" style="display:none;">
    <form id="addfrom"class="layui-form" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <td>课程类型:</td>
                <td><input type="text" name="courseTypeName" required lay-verify="required" placeholder="请输入课程类型" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>说明：</td>
                <td><input type="text" name="remark" required lay-verify="required" placeholder="请输入说明" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <button lay-submit lay-filter="Csubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--编辑弹出层--%>
<div id="editWin" class="layui-form" style="display:none;">
    <form id="Wedit" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <input type="hidden" name="courseTypeId" id="cid" />
            <tr>
                <td>课程类型:</td>
                <td><input type="text" id="courseTypeName" name="courseTypeName" required lay-verify="required" placeholder="请输入课程类型" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>说明：</td>
                <td><input type="text" id="remark" name="remark" required lay-verify="required" placeholder="请输入说明" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <button lay-submit lay-filter="Esubmit"  class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<table class="layui-hide" id="Clist" lay-filter="Clist"></table>
</body>
<script type="text/html" id="toolbarT">
    <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="add"><i class="layui-icon layui-icon-add-circle"></i>新增</button>
</script>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</button>
    <button class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</button>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //课程类型列表
        table.render({
            elem: '#Clist'
            ,url:'${pageContext.request.contextPath}/jack/courseList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'courseTypeId', title:'编号', width:300,unresize:true,sort: true}
                ,{field:'courseTypeName', title:'类别名称', width:300}
                ,{field:'remark', title:'说明', width:300}
                ,{title:'操作', toolbar:'#barDemo', width:200}
            ]]
            ,page: true
            ,limit:5
            ,limits: [5, 15, 20, 30, 40, 50]

        });

        //post提交添加
        form.on('submit(Csubmit)',function (data) {
            $.post(
                '${pageContext.request.contextPath}/jack/addCourse',
                data.field,
                function (data) {
                    alert(data);
                    if(data > 0){
                        //3.1   弹窗提示
                        layer.msg("添加成功！", {icon: 1});
                        //3.2  获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //3.3   关闭当前frame
                        parent.layer.close(index);
                        //3.4   刷新页面
                        window.parent.location.reload();
                    }else {
                        layer.msg("添加失败！", {icon: 1});
                    }
                },'json');
        });

        //post提交修改
        form.on('submit(Esubmit)',function (data) {
            $.post(
                '${pageContext.request.contextPath}/jack/editCourse',
                data.field,
                function (d) {
                    alert(d);
                    if(d > 0){
                        //3.1   弹窗提示
                        layer.msg("修改成功！", {icon: 1});
                        //3.2  获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //3.3   关闭当前frame
                        parent.layer.close(index);
                        //3.4   刷新页面
                        window.parent.location.reload();
                    }else {
                        layer.msg("修改失败！", {icon: 1});
                    }
                });
        });

        /** 表格行按钮监听  编辑、删除*/
        table.on('tool(Clist)',function (obj) {
            var data = obj.data;
            $("#cid").val(data.courseTypeId);
            $("#courseTypeName").val(data.courseTypeName);
            $("#remark").val(data.remark);
            if(obj.event === 'edit'){
                layer.open({
                    type:1,
                    title:'修改课程类型',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['500px', '350px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    //content: ['${pageContext.request.contextPath}/jack/test','no']
                    content: $('#editWin'),
                    cancel: function(index, layero){
                        $("#Wedit")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        return false;
                    }
                });
                /** 删除 */
            }else if(obj.event === 'del'){
                var cid = data.courseTypeId;
                layer.confirm('真的删除行么', function(index){
                    $.get("${pageContext.request.contextPath}/jack/delCourse?cid="+cid,function (d) {
                        if(d > 0){
                            layer.msg('删除成功');
                            table.reload('Clist');
                        }else if (d === null){
                            layer.msg('删除失败');
                            table.reload('Clist');
                        }
                    });
                    layer.close(index);
                });
            }
        });

        /** 表格头部按钮监听  添加 */
        table.on('toolbar(Clist)',function (obj) {
            var data = obj.data;
            table.reload('Clist');
            if(obj.event === 'add'){
                layer.open({
                    type:1,
                    title:'新增课程类别',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['500px', '350px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    //content: ['${pageContext.request.contextPath}/jack/test','no']
                    content: $('#addWin'),
                    cancel: function(index, layero){
                        table.reload('Clist');
                        layer.close(index);
                        return false;
                    }
                });
            }
        });
    });

</script>
</html>
