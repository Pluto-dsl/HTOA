<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/4
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工请假页面</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<div id="windows" style="margin-left: 5%;display: none;">
    <form class="layui-form" action="${pageContext.request.contextPath}/jack/Attadd" method="post" >
        <h2 style="margin-left: 35%" >未打卡说明</h2>
        <br><br>
        未打卡日期：<div style="margin-right:10px" class="layui-inline">
        <input type="text" name="punckClockTime" class="layui-input" id="clockDate">
    </div>
        时间点:
        <div class="layui-input-inline">
            <select name="timeing" lay-filter="type">
                <option value="8:00">8:00</option>
                <option value="14:00">14:00</option>
                <option value="17:00">17:00</option>
                <option value="21:00">21:00</option>
            </select>
        </div>
        <br><br>说明原因:<input type="text" name="cause" required lay-verify="required" placeholder="请输入说明原因" autocomplete="off" class="layui-input">
        <br><br><br><button style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
    </form>
</div>
<table class="layui-hide" id="test" lay-filter="test" style="text-align: center;"></table>

<div id="page"></div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="topBar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add">添加</a>
</script>
<%-------------------------------------------------------------%>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;


        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/empLeave/returnData'
            ,toolbar: '#topBar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {field: 'holidayid', title: 'ID', width:200, sort: true, fixed: 'left', totalRowText: '合计：'}
                ,{field: 'Empid', title: '请假人', width:200}
                ,{field: 'holidayDay', title: '请假时长', width: 200, sort: true, totalRow: true}
                ,{field: 'startTime', title: '开始时间', width:200, sort: true}
                ,{field: 'endTime', title: '结束时间', width: 200, sort: true, totalRow: true}
                ,{field: 'status', title: '状态', width: 200}
                ,{field: 'Remark', title: '内容', width: 200}
                ,{fixed: '', title:'操作', width: 270, align:'center', toolbar: '#barDemo'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1,
                        title:'添加未打卡说明',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '450px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        //content: ['${pageContext.request.contextPath}/jack/test','no']
                        content: $('#windows')
                    });
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        })
    })
</script>
</body>
</html>
