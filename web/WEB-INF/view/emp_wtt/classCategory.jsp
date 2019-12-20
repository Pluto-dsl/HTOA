<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/20
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <!--点击新增弹出来的框-->
    <div id="windows" style="margin-left:5%; margin-top:1%; display: none;">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/student/addcate">
            <table align="center" style="border-collapse:separate; border-spacing:0px 20px;">
                <tr>
                    <td>班级类别名称:</td>
                    <td colspan="2">
                        <input type="text" name="classTypeName"/>
                    </td>
                </tr>
                <tr align="center">
                   <td colspan="2">
                       <button style="text-align: center;" class="layui-btn layui-btn-xs" type="submit" ><i class="layui-icon layui-icon-ok" ></i>添加</button>
                   </td>
                </tr>
            </table>
        </form>
    </div>
    <!--点击编辑弹出来的框-->
    <div id="updatewindows" style="margin-left:5%; margin-top:1%; display: none;">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/student/updatecate" style="text-align: center" lay-filter="formTestFilter">
            <input type="hidden" name="classTypeId">
            <table align="center" style="border-collapse:separate; border-spacing:0px 20px;">
                <tr>
                    <td>班级类别名称:</td>
                    <td colspan="2">
                        <input type="text" name="classTypeName" autocomplete="off"/>
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <button style="text-align: center;" class="layui-btn layui-btn-xs" type="submit" ><i class="layui-icon layui-icon-ok" ></i>修改</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <script type="text/html" id="toolbar">
        <button lay-event="add" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left: 50%;"><i class="layui-icon layui-icon-add-circle"></i>添加</button>
    </script>
    <table class="layui-hide" lay-filter="test" id="test"></table>
    <script type="text/html" id="barDemo">
        <!--编辑-->
        <button type="button" lay-event="edit" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>编辑</button>
    </script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','laypage'],function () {
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var table_overloading =  table.render({
            elem:'#test',
            height:500,
            title:'添加班级类别',
            toolbar:"#toolbar",
            url:'<%=request.getContextPath()%>/student/selectCategory',
            cols:[[
                {field:'classTypeId',title:'编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'classTypeName', title:'班级类别名称'}
                ,{fixed: 'right', width:300, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            ,page:true,
            limits:[5,10,15,25]
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data =checkStatus.data;
            switch(obj.event){
                case 'add':
                    layer.open({
                    type: 1,
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['400px', '300px'],
                    fixed: false, //不固定
                    maxmin: true,
                    content: $('#windows'),
                    shadeClose: true, //开启遮罩关闭
                });
            };
        });
        //行工具栏
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
            if(event == 'edit'){
                layer.open({
                    type: 1,
                    title:'班级类别修改',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['400px', '300px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#updatewindows')
                });
                setFormValue(datas);//动态向表单赋值
            }
        });
        //获取该id的数据
        function setFormValue(data){
            console.log(data)
            form.val("formTestFilter", {
                "classTypeId":data.classTypeId,
                "classTypeName":data.classTypeName
            });
            form.render(null,'formTestFilter')
        }
    })
</script>
</html>