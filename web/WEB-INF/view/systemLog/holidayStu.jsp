<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/18
  Time: 9:46
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
            学生姓名:
            <div class="layui-inline" style="padding-right: 15px">
                <input class="layui-input" name="stuName" id="stuName" autocomplete="off">
            </div>
        </td>
        <td>
            <form class="layui-form">
                <input type="radio" name="month" value="${month.lastMonth}" title="上一月(${month.lastMonth}月)">
                <input type="radio" name="month" value="${month.thisMonth}" title="本月(${month.thisMonth}月)">
                <input type="radio" name="month" value="0" title="所有月份" checked="">
            </form>
        </td>
        <td>
            <button class="layui-btn menu" id="btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
        </td>
    </tr>
</table>
<table id="holidayEmp" lay-filter="holidayEmp"></table>
<table id="holidayInfo" lay-filter="holidayInfo"></table>
<script>
    layui.use(['form','table'], function () {
        var form = layui.form,
            table = layui.table;

        var holidayIns = table.render({
            elem: '#holidayEmp'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getHolidayStu'
            ,cols: [[
                {field:'Studid', title:'学生编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'stuname', title:'学生名称'}
                ,{field:'holiday', title:'请假次数', unresize: true, sort: true}
            ]]
            ,height:'full-300'
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        var holidayTableIns = table.render({
            elem: '#holidayInfo'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getHolidayByStu'
            ,cols: [[
                {field:'stuname', title:'学生姓名', fixed: 'left', unresize: true, sort: true}
                ,{field:'holidayid', title:'请假天数', unresize: true, sort: true}
                ,{field:'startTime', title:'请假开始时间',templet:function (d){return createTime(d.startTime);}, unresize: true, sort: true}
                ,{field:'endTime', title:'请假结束时间',templet:function (d){return createTime(d.endTime);}, unresize: true, sort: true}
                ,{field:'Title', title:'标题'}
                ,{field:'Remark', title:'备注'}
                ,{field:'Status', title:'状态', unresize: true, sort: true}
            ]]
            ,height:'220'
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //监听行单击事件(员工列表)
        table.on('row(holidayEmp)', function(obj){
            var data = obj.data;//当前行数据
            var tr = obj.tr;//当前行对象
            console.log(data.Studid);
            holidayTableIns.reload({
                where:{
                    stuId:data.Studid
                }
            })
        });

        //重载表格
        $("#btn").click(function () {
            //获取条件
            var stuName = $('input[name="stuName"]').val();
            var month = $('input[name="month"]:checked').val();
            console.log(stuName);
            console.log(month);
            //调用重载方法
            holidayIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    stuName:stuName,
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