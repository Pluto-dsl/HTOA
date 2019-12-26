<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/7
  Time: 8:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>课程管理</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<%--添加弹出层--%>
<div id="addWin" style="display:none;">
    <form id="addfrom" class="layui-form" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <td>课程名称:</td>
                <td><input type="text" name="courseName" id="courseName1" required lay-verify="required" placeholder="请输入课程类型" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>是否必修:</td>
                <td>
                    <select name="isobligatory" lay-filter="type">
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>课程类别:</td>
                <td>
                    <select id="courseTypeId" name="courseTypeId" lay-verify="required">
                        <option value="" >请选择课程类型</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>说明:</td>
                <td><input type="text" name="remark" required lay-verify="required" placeholder="请输入说明" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <button class="layui-btn layui-btn-warm" id="addCourse" lay-submit lay-filter="Csubmit"  type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--编辑弹层--%>
<div id="editWin" style="display:none;">
    <form id="editfrom" class="layui-form" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <input type="hidden" name="courseId" id="cid" />
            <tr>
                <td>课程名称:</td>
                <td><input type="text" id="courseName" name="courseName" required lay-verify="required" placeholder="请输入课程名称" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td>是否必修:</td>
                <td>
                    <select id="isobligatory" name="isobligatory" lay-filter="type">
                        <option value="是">是</option>
                        <option value="否">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>课程类别:</td>
                <td>
                    <select id="courseTypeId1" name="courseTypeId" lay-verify="required">
                        <option value="" >请选择课程类别</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>说明:</td>
                <td><input type="text" id="remark" name="remark" required lay-verify="required" placeholder="请输入说明" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <button lay-submit lay-filter="Esubmit" id="editCourse"  class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>
<table class="layui-hide" id="Clist" lay-filter="Clist"></table>
</body>
<script type="text/html" id="toolbar">
    <button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>新增</button>
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

        ///课程管理列表
        table.render({
            elem: '#Clist'
            ,url:'${pageContext.request.contextPath}/jack/courseMgt'
            ,toolbar: '#toolbar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'courseId', title:'编号', width:150,unresize:true,sort: true}
                ,{field:'courseName', title:'课程名称', width:150}
                ,{field:'isobligatory', title:'是否必修',width:150}
                ,{field:'courseTypeName',title:'课程类别',width:150}
                ,{field:'remark',title:'说明',width:150}
                ,{title:'操作',width:180,toolbar:'#barDemo'}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]

        });

        $("#courseName").change(function () {
            $.get('${pageContext.request.contextPath}/jack/Norepeat?type=course',{Name:$("#courseName").val()},function (d1) {
                console.log(d1);
                if(d1 === '1'){
                    $("#courseName").val("");
                    layer.tips('抱歉！该课程已存在不可编辑同样的', '#courseName', {
                        tips: [4, '#000000']
                    });
                    return false;
                }
            });
        });

        $("#courseName1").change(function () {
            $.get('${pageContext.request.contextPath}/jack/Norepeat?type=course',{Name:$("#courseName1").val()},function (d1) {
                console.log(d1);
                if(d1 === '1'){
                    $("#courseName1").val("");
                    layer.tips('已有该课程了,请换一个吧~~~', '#courseName1', {
                        tips: [4, '#000000']
                    });
                    return false;
                }
            });
        });

        //添加按钮提交监听
        form.on('submit(Csubmit)',function (data) {
            $.post('${pageContext.request.contextPath}/jack/addCourseMgt',data.field,function (data) {
                layer.msg("添加成功");
                table.reload('Clist');
            },'json');
            table.reload('Clist');
        });

        //修改
        form.on('submit(Esubmit)',function (data) {
            $.post('${pageContext.request.contextPath}/jack/editCourseMgt',data.field,function (data) {
                layer.msg("添加成功");
                table.reload('Clist');
            },'json');
            table.reload('Clist');
        });

        //动态生成下拉框
        $.get('${pageContext.request.contextPath}/jack/list',{},function (d) {
            for (var i = 0; i < d.names.length; i++) {
                $("#courseTypeId1").append("<option value='"+d.names[i].courseTypeId+"'>"+d.names[i].courseTypeName+"</option>");
            }
            form.render("select");
        },'json');

        //监听行工具事件
        table.on('tool(Clist)',function (obj) {
            var data1 = obj.data;
            if(obj.event === 'edit'){
                $("#editfrom")[0].reset();
                layui.form.render();
                //为表单赋值
                $("#cid").val(data1.courseId);
                $("#courseName").val(data1.courseName);
                $("#isobligatory").children().each(function (index,element) {
                    if ($(element).text() === data1.isobligatory) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });
                $("#courseTypeId1").children().each(function (index,element) {
                    if ($(element).text() === data1.courseTypeName) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });
                $("#remark").val(data1.remark);

                layer.open({
                    type: 1,
                    title:'编辑课程',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    //content: ['${pageContext.request.contextPath}/jack/test','no']
                    content: $('#editWin'),
                    cancel: function(index, layero){
                        $("#editfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        table.reload('Clist');
                        return false;
                    }
                })
            }else if(obj.event === 'del'){
                var cid = data1.courseId;
                layer.confirm('真的删除行么', function(index){
                    $.get("${pageContext.request.contextPath}/jack/delCourseMgt?cid="+cid,function (d) {
                        if(d > 0){
                            layer.msg('删除成功');
                            window.location.reload();
                        }else if (d === null){
                            layer.msg('删除失败');
                            window.location.reload();
                        }
                    });
                    table.reload('Clist');
                    layer.close(index);
                });
            }
        })


        //表头部新增按钮监听
        table.on('toolbar(Clist)',function (obj) {
            var data = obj.data;
            if(obj.event === 'add'){
                //动态生成下拉框
                 $.get('${pageContext.request.contextPath}/jack/list',{},function (data) {
                    for (var i = 0; i < data.names.length; i++) {
                        $("#courseTypeId").append("<option value='"+data.names[i].courseTypeId+"'>"+data.names[i].courseTypeName+"</option>");
                    }
                    form.render("select");
                },'json');
                $("#addfrom")[0].reset();
                layui.form.render();
                layer.open({
                    type: 1,
                    title:'新增课程',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    //content: ['${pageContext.request.contextPath}/jack/test','no']
                    content: $('#addWin'),
                    cancel: function(index, layero){
                        $("#addfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        table.reload('Clist');
                        return false;
                    }
                });
            }
        });
    });
</script>
</html>
