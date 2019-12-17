<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/16
  Time: 8:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
<div id="windows" style="margin-left:5%; margin-top:1%; display: none;">
    <form method="post" class="layui-form" enctype="multipart/form-data" action="<%=request.getContextPath()%>/studentduan/addstudentleave">
        <table style="border-collapse:separate;border-spacing:0px 20px;margin-left: 15%">
            <tr>
                <th>请假类型:</th>
                <td>
                    <select name="Title">
                        <option value="">--请选择请假类型--</option>
                        <option value="事假">事假</option>
                        <option value="病假">病假</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>开始时间:</th>
                <td>
                    <input type="text" id="startTime" class="layui-input" name="startTime" autocomplete="off">
                </td>
            </tr>
            <tr>
                <th>结束时间:</th>
                <td>
                    <input type="text" id="endTime" class="layui-input" name="endTime" autocomplete="off">
                </td>
            </tr>
            <tr>
                <th>请假天数:</th>
                <td>
                    <input type="text" class="layui-input" name="holidayDay" >
                </td>
            </tr>
            <tr>
                <th>请假事由:</th>
                <td>
                    <textarea rows="5" cols="50" name="Remark" /></textarea>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <button id="tijiao" style="text-align: center" style="margin-left: 25%" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>申请</button>
                </td>
            </tr>
        </table>
    </form>
</div>
    <!--申请请假按钮-->
    <script type="text/html" id="toolbar">
        <button style="margin-left: 40%;margin-top:3%" type="button" lay-event="leave" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>申请请假</button>
    </script>
    <table class="layui-hide" lay-filter="test" id="test">

    </table>
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
            height:500,
            toolbar: '#toolbar',
            url:'<%=request.getContextPath()%>/studentduan/studentselectleave',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'holidayid',title:'编号', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'stuname', title:'请假人', width:100}
                ,{field:'holidayDay', title:'假期天数', width:170,sort:true}
                ,{field:'startTime', title:'开始时间', width:200,templet:'<div>{{ layui.util.toDateString(d.startTime,"yyyy-MM-dd HH:mm:ss")}}</div>'}
                ,{field:'endTime', title:'结束时间', width:200,templet:'<div>{{ layui.util.toDateString(d.endTime,"yyyy-MM-dd HH:mm:ss")}}</div>'}
                ,{field:'Title', title:'请假类型',width:200}
                ,{field:'Remark', title:'请假事由', width:200}
                ,{field:'Status', title:'状态', width:200}
            ]]
            ,page:true,
            limits:[5,10,15,25]
        });

        //头工具栏
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch (obj.event) {
                case 'leave':
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '650px'],
                        fixed: false, //不固定
                        maxmin: true,
                        content: $('#windows'),
                        shadeClose: true, //开启遮罩关闭
                    });
                    break;
            };
        });
        //时间选择器
        laydate.render({
            elem: '#startTime',
            type: 'datetime',
            format:'yyyy/MM/dd',
            done: function (value) {
                startdate=value;
            }
        });
        //时间选择器
        laydate.render({
            elem: '#endTime',
            type: 'datetime',
            format:'yyyy/MM/dd',
            done: function (value) {
                startdate=value;
            }
        });
    })
</script>
</html>