<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/16
  Time: 9:28
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
    <title>Document</title>
    <jsp:include page="../include.jsp"/>
    <style>
        .empBar{
            width: 1700px;
            height: 280px;
            margin-bottom: 15px;
            float: left;
        }
        .empLine{
            width: 935px;
            height: 400px;
            float: left;
        }
        .titleBing{
            width: 500px;
            height: 400px;
            margin-left: 5%;
            float: left;
        }
    </style>
</head>
<body>
<div class="layui-tab">
    <ul class="layui-tab-title">
        <li id="empListTitle" class="layui-this">表格展示</li>
        <li id="stuListTitle">图例展示</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <table style="margin-top: 10px;margin-left: 10px">
                <tr>
                    <td>
                        员工姓名:
                        <div class="layui-inline" style="padding-right: 15px">
                            <input class="layui-input" name="empName" id="empName" autocomplete="off">
                        </div>
                    </td>
                    <td>
                        <form class="layui-form">
                            <input type="radio" name="month" value="${month.lastMonth}" title="上一月(${month.lastMonth}月)" checked="">
                            <input type="radio" name="month" value="${month.thisMonth}" title="本月(${month.thisMonth}月)">
                            <input type="radio" name="month" value="0" title="所有月份">
                        </form>
                    </td>
                    <td>
                        <button class="layui-btn menu" id="btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
                    </td>
                </tr>
            </table>
            <table id="holidayEmp" lay-filter="holidayEmp"></table>
            <table id="holidayInfo" lay-filter="holidayInfo"></table>
        </div>
        <div class="layui-tab-item">
            <div id="empBar" class="empBar" style="border-bottom: 1px solid #bfbfbf;"></div>
            <div id="empLine" class="empLine" style="border-right: 1px solid #bfbfbf;"></div>
            <div id="titleBing" class="titleBing"></div>
        </div>
    </div>
</div>
<script>
    layui.use(['form','table'], function () {
        var form = layui.form,
            table = layui.table;

        var holidayIns = table.render({
            elem: '#holidayEmp'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getHolidayEmp'
            ,cols: [[
                {field:'empId', title:'员工编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称'}
                ,{field:'holiCount', title:'请假次数', unresize: true, sort: true}
                ,{field:'holiday', title:'天数', unresize: true, sort: true}
                ,{field:'hour', title:'小时', unresize: true, sort: true}
            ]]
            ,height:'full-300'
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        var holidayTableIns = table.render({
            elem: '#holidayInfo'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getHolidayByEmp'
            ,cols: [[
                {field:'empName', title:'员工姓名', fixed: 'left', unresize: true, sort: true}
                ,{field:'holidayDay', title:'请假天数', unresize: true, sort: true}
                ,{field:'hour', title:'请假小时', unresize: true, sort: true}
                ,{field:'startTime', title:'开始时间',templet:function (d){return createTime(d.startTime);}, unresize: true, sort: true}
                ,{field:'endTime', title:'结束时间',templet:function (d){return createTime(d.endTime);}, unresize: true, sort: true}
                ,{field:'Title', title:'类型'}
                ,{field:'Remark', title:'备注'}
                ,{field:'status', title:'状态',templet:function (d) {
                        if (d.status === 1){
                            return '审批中';
                        }else if (d.status === 2){
                            return '已完成';
                        }else if (d.status === 3){
                            return '不批准';
                        }
                    }, unresize: true, sort: true}
            ]]
            ,height:'220'
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //监听行单击事件(员工列表)
        table.on('row(holidayEmp)', function(obj){
            var data = obj.data;//当前行数据
            var tr = obj.tr;//当前行对象
            holidayTableIns.reload({
                where:{
                    empId:data.empId
                }
            })
        });

        //重载表格
        $("#btn").click(function () {
            //获取条件
            var empName = $('input[name="empName"]').val();
            var month = $('input[name="month"]:checked').val();
            console.log(empName);
            console.log(month);
            //调用重载方法
            holidayIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    empName:empName,
                    month:month
                }
                ,method:'post'
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });
    });
    layui.use('element',function () {
        var $ = layui.jquery;
        var element = layui.element;
    })
</script>
<script>
    // 基于准备好的dom，初始化echarts实例
    $(document).ready(function () {
        $.post("${pageContext.request.contextPath}/echarts/getEmpBarData",{},function (data) {
            var myChart = echarts.init(document.getElementById('empBar'));
            // 指定图表的配置项和数据
            myChart.setOption({
                title: {
                    text: '员工请假次数'
                },
                tooltip: {},
                xAxis: {
                    type: 'category',
                    data: data.xAxis
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: data.data,
                    type: 'bar'
                }]
            });
        },"json");
        $.post("${pageContext.request.contextPath}/echarts/getEmpLineData",{},function (data) {
            var myChart = echarts.init(document.getElementById('empLine'));
            // 指定图表的配置项和数据
            myChart.setOption({
                title: {
                    text: '请假总数变化'
                },
                tooltip: {},
                xAxis: {
                    type: 'category',
                    data: data.xAxis
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: data.data,
                    type: 'line'
                }]
            });
        },"json");
        $.post("${pageContext.request.contextPath}/echarts/getTitleBingData",{},function (data) {
            var mychart = echarts.init(document.getElementById('titleBing'), 'shine');
            //给图表设置属性
            var option = {
                title: {
                    text: '请假类型比例',
                    x: 'left' //标题的水平显示位置 left默认  center right
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical', //设置图例的方向 vertical(垂直) horizontal(水平)
                    left: 'right',
                    data: data.selected
                },
                series: {
                    name: '访问来源',
                    type: 'pie',
                    radius: '100',//半径大小
                    center: ['50%', '50%'],//圆心位置
                    data: data.seriesData

                }
            };

            //把属性设置给图表
            mychart.setOption(option);
        },"json");
    });
</script>
<script type="text/javascript">
    function createTime(v){
        console.log(v);
        if(v == undefined || v ==''){
            return "";
        }else {
            var date = new Date(v);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? '0' + m : m;
            var d = date.getDate();
            d = d < 10 ? ("0" + d) : d;
            var h = date.getHours();
            h = h < 10 ? ("0" + h) : h;
            var M = date.getMinutes();
            M = M < 10 ? ("0" + M) : M;
            var str = y + "-" + m + "-" + d + " " + h + ":" + M;
            return str;
        }
    }
</script>
</body>
</html>