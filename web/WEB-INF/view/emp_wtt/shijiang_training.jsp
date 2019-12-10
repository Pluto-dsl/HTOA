<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/6
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <!--点击新增弹出来的框-->
    <div id="windows" style="margin-left:5%;/*margin-top:2%;height:30%;*/display: none;">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/">
            日期：<div></div>
        </form>
    </div>
<script type="text/html" id="toolbar">
    <button lay-event="add" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left: 50%"><i class="layui-icon layui-icon-add-circle"></i>添加</button>
</script>

<table class="layui-hide" lay-filter="test" id="test"></table>

<script type="text/html" id="barDemo">
    <!--删除-->
    <button type="button" lay-event="del" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>删除</button>
</script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','laypage'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laypage = layui.laypage;
        var laydate = layui.laydate;
        table.render({
            elem:'#test',
            toolbar:'#toolbar',
            height:500,
            title:'试讲培训',
            url:'<%=request.getContextPath()%>/training/selectshijiang',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'trialId',title:'编号', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'date', title:'日期', width:120,templet:'<div>{{ layui.util.toDateString(d.date,"yyyy-MM-dd HH:mm:ss")}}</div>'}
                ,{field:'time', title:'时间(星期一---星期日)', width:170,sort:true}
                ,{field:'courseId', title:'关联课程/章节id', width:200}
                ,{field:'type', title:'授课类型', width:200}
                ,{field:'empId', title:'授课老师',width:200}
                ,{field:'remark', title:'备注', width:200}
                ,{fixed: '', width:300, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            ,page:true,
            limits:[5,10,15,25]
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1,
                        title:'新增试讲培训',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                    });
                    break;
            };
        });

        //行工具栏
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
            if(event=='add'){

            }
        });
    })
</script>
</html>