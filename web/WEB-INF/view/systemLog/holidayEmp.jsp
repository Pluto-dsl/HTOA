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
</head>
<body>
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
            <button class="layui-btn menu" id="btn">搜索</button>
        </td>
    </tr>
</table>
<table id="holiday" lay-filter="test"></table>
<script>
    layui.use(['form','table'], function () {
        var form = layui.form,
            table = layui.table;

        var holidayIns = table.render({
            elem: '#holiday'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getHolidayEmp'
            ,cols: [[
                {field:'empId', title:'员工编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称'}
                ,{field:'holiCount', title:'请假次数'}
                ,{field:'holiday', title:'天数'}
                ,{field:'hour', title:'小时'}
            ]]
            ,height:'full-300'
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        var holidayTableIns = table.render({
            elem: '#holiday'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getHolidayByEmp'
            ,cols: [[
                {field:'empId', title:'员工姓名', fixed: 'left', unresize: true, sort: true}
                ,{field:'holidayDay', title:'请假天数'}
                ,{field:'hour', title:'请假小时'}
                ,{field:'startTime', title:'开始时间'}
                ,{field:'endTime', title:'结束时间'}
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
                    }}
            ]]
            ,height:'220'
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //监听行单击事件(员工列表)
        table.on('row(test)', function(obj){
            var data = obj.data;//当前行数据
            var tr = obj.tr;//当前行对象
            everyIns.reload({
                where:{
                    empId:data.empId
                }
            });
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
</script>
</body>
</html>