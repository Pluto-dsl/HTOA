<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/18
  Time: 8:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的任务页面</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <table class="layui-hide" id="test" lay-filter="test" style="text-align: center;"></table>
</body>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看详情</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="办理进度">查看详情</a>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        //日期
        laydate.render({
            elem: '#startDate',
            type: 'date',
            done: function (value) {
                startdate=value;
            }
        });

        laydate.render({
            elem: '#endDate',
            type: 'date',
            done: function (value) {
                enddate = value;
                var day = getDaysBetween(startdate,enddate);
                day = Math.ceil(day)
                document.getElementById("days").value=day;
            }
        })
        function getDaysBetween(dateString1,dateString2){
            var  startDate = Date.parse(dateString1);
            var  endDate = Date.parse(dateString2);
            var days=(endDate - startDate)/(1*24*60*60*1000);
            return  days;
        }

        table.render({
            elem: '#test'
            ,height:600
            ,url:'${pageContext.request.contextPath}/zeroLeave/returnData'
            ,toolbar: '#topBar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {field: 'holidayid', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'Empid', title: 'id', width:100,hide:'true'}
                ,{field: 'empName', title: '请假人', width:100}
                ,{field: 'holidayDay', title: '请假时长', width:110, sort: true, totalRow: true}
                ,{field: 'startTime', title: '开始时间', width:150, sort: true,templet : "<div>{{layui.util.toDateString(d.startDate, 'yyyy年MM月dd日')}}</div>"}
                ,{field: 'endTime', title: '结束时间', width: 150, sort: true, totalRow: true,templet : "<div>{{layui.util.toDateString(d.endTime, 'yyyy年MM月dd日')}}</div>"}
                ,{field: 'status', title: '状态', width: 100,templet:""}
                ,{field: 'Remark', title: '内容', width: 100}
                ,{fixed: '', title:'操作', width: 150, align:'center', toolbar: '#barDemo'}
            ]]
            ,page: true
            ,done: function(res, page, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //分类显示中文名称
                $("[data-field='status']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("审批中")
                    }else if($(this).text()=='2'){
                        $(this).text("已完成")
                    }else if($(this).text()=='3'){
                        $(this).text("不批准")
                    }
                })
            }
        });
    })
</script>
</html>
