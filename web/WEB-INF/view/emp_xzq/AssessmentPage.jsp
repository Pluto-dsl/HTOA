<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/10
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title> </title>
    <jsp:include page="../include.jsp" />
    <style>
        .layui-form-select dl{
            height: 500%;
        }
    </style>
</head>
<body>
<%--添加弹层--%>
<div id="addWin" style="display:none;">
    <form id="addfrom" class="layui-form" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <input type="hidden" name="" value="">
            <tr>
                <td>考核指标:</td>
                <td><input type="text" id="aduitName" name="aduitName" required lay-verify="required" maxlength="30" placeholder="请输入考核内容" autocomplete="off" class="layui-input"></td>
                <td>考核分数:</td>
                <td><input type="text" id="Scores" name="Scores" lay-verify="number" maxlength="5"  placeholder="请输入考核分数" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>考核部门:</td>
                <td>
                    <select id="Depid" name="Depid" lay-filter="type">
                    </select>
                </td>
                <td>说明内容:</td>
                <td><input type="text" id="Remark" name="Remark" required lay-verify="required" maxlength="30" placeholder="请输入说明内容" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <button lay-submit lay-filter="Asubmit" id="Asubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--编辑弹层--%>
<div id="editWin" style="display:none;">
    <form id="editfrom" class="layui-form" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <input type="hidden" id="aid" name="aduitModelid" />
            <tr>
                <td>考核内容:</td>
                <td><input type="text" id="aduitName1" name="aduitName" required lay-verify="required" placeholder="请输入课程类型" autocomplete="off" class="layui-input"></td>
                <td>考核分数:</td>
                <td><input type="text" id="Scores1" name="Scores" required lay-verify="number" placeholder="请输入课程类型" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>考核指标:</td>
                <td>
                    <select id="Depid1" name="Depid" lay-verify="required">
                    </select>
                </td>
                <td>说明:</td>
                <td><input type="text" id="Remark1" name="Remark" required lay-verify="required" placeholder="请输入课程类型" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <button lay-submit lay-filter="Esubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<table class="layui-hide" id="AssList" lay-filter="AssList"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="addBtn" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-add-1" style="font-size: 30px;"></i>插入指标</button>
        <button lay-event="batchDel" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-prev" style="font-size: 30px;"></i>批量删除</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-danger" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</button>
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-warm" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</button>
</script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //考勤列表
        table.render({
            elem: '#AssList'
            ,url:'${pageContext.request.contextPath}/jack/AssessmentPage'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'aduitModelid', title:'编号', width:80, fixed: 'left', unresize:true,sort: true}
                ,{field:'aduitName', title:'考核内容', width:300}
                //日期转换
                ,{field:'Scores', title:'考核分数', width:120}
                ,{field:'depName', title:'部门名称', width:120}
                ,{field:'Remark', title:'说明', width:200}
                ,{title:'操作', toolbar:'#barDemo', width:180}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]
        });
        //表头部新增按钮监听
        table.on('toolbar(AssList)',function (obj) {
            var data = obj.data;
            var checkStatus = table.checkStatus('AssList');

            $("#addfrom")[0].reset();
            layui.form.render();
            if(obj.event === 'addBtn'){
                //动态生成下拉框
                $.get('${pageContext.request.contextPath}/jack/select',{},function (data) {
                    for (var i = 0; i < data.names.length; i++) {
                        $("#Depid").append("<option value='"+data.names[i].depid+"'>"+data.names[i].depName+"</option>");
                    }
                    form.render("select");
                },'json');
                $("#addfrom")[0].reset();
                layui.form.render();
                layer.open({
                    type: 1,
                    title:'新增指标',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: $('#addWin'),
                    cancel: function(index, layero){
                        $("#addfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        table.reload('AssList');
                        return false;
                    }
                });
            }else if(obj.event === "batchDel"){
                var ids = [];
                $(checkStatus.data).each(function (i, o) {//o即为表格中一行的数据
                    ids.push(o.aduitModelid);
                });
                console.log(JSON.stringify(ids));
                if (ids.length < 1) {
                    layer.msg('无选中项');
                    return false;
                }
                layer.confirm('真的删除行么', function(index){
                    for(var a= 0;a<ids.length;a++){
                        $.get("${pageContext.request.contextPath}/jack/delAss?type=duo&cid="+ids[a],function (d) {
                            layer.msg('删除成功');
                            window.location.reload();
                        });
                    }
                    window.location.reload();
                    layer.close(index);
                });

            }
        });

        $("#Asubmit").click(function () {
            window.location.reload();
        });

        //考核添加
        form.on('submit(Asubmit)',function (data) {
            $.post('${pageContext.request.contextPath}/jack/addAss',data.field,function (d) {
                alert(d);
            },"json");
        });

        $.get('${pageContext.request.contextPath}/jack/select',{},function (da) {
            for (var i = 0; i < da.names.length; i++) {
                $("#Depid1").append("<option value='" + da.names[i].depid + "'>" + da.names[i].depName + "</option>");
            }
            form.render("select");
        },'json');

        table.on('tool(AssList)',function (obj) {
            var data = obj.data;
            if (obj.event === 'edit'){
                $("#editfrom")[0].reset();
                layui.form.render();
                //给表单赋值
                $("#aid").val(data.aduitModelid);
                $("#aduitName1").val(data.aduitName);
                $("#Scores1").val(data.Scores);
                var children = $("#Depid1").children();
                $(children).each(function (index,element) {
                    if ($(element).text() === data.depName) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });
                $("#Remark1").val(data.Remark);

                layer.open({
                    type: 1,
                    title:'考核编辑',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: $('#editWin'),
                    cancel: function(index, layero) {
                        $("#editfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        table.reload('AssList');
                        return false;
                    }
                });
            }else if(obj.event === 'del'){  //删除
                layer.confirm('确认真的删除吗?',function (index) {
                    $.get("${pageContext.request.contextPath}/jack/delAss?Aid="+data.aduitModelid,function (result) {
                        if(result === '成功'){
                            layer.msg("删除成功");
                            table.reload('AssList');
                        }
                    });
                    table.reload('AssList');
                    layer.close(index);
                });
            }
        });
        //编辑
        form.on('submit(Esubmit)',function (data) {
            $.post('${pageContext.request.contextPath}/jack/editAss',data.field,function (d) {
            },"json");
            table.reload('AssList');
        });
    });

</script>
</html>
