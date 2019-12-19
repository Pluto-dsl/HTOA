<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/16
  Time: 9:41
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
<table id="workTime" lay-filter="test"></table>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var workTime = table.render({
            elem: '#workTime'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getWorkTimeData'
            ,cols: [[
                {field:'attId', title:'未打卡编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称'}
                ,{field:'applyTime', title:'申请时间',templet:function (d){return createTime(d.applyTime);},unresize: true, sort: true}
                ,{field:'punckClockTime', title:'未打卡时间',templet:function (d){return createTime(d.punckClockTime);},unresize: true, sort: true}
                ,{field:'cause', title:'原因'}
                ,{field:'auditor', title:'审核人'}
                ,{field:'examineExplain', title:'审核说明'}
                ,{field:'examinTime', title:'审核时间',templet:function (d){return createTime(d.examinTime);},unresize: true, sort: true}
                ,{field:'status', title:'审核状态',templet:function (d) {
                        if (d.status === 1){
                            return "通过审核"
                        }else if (d.status === 2){
                            return "待审核"
                        }else if (d.status === 3){
                            return "申请失败"
                        }
                    }}
            ]]
            ,page: {limit: 15,limits:[5,10,15,20,30],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        //重载表格
        $("#btn").click(function () {
            //获取条件
            var empName = $('input[name="empName"]').val();
            var month = $('input[name="month"]:checked').val();
            console.log(empName);
            console.log(month);
            //调用重载方法
            workTime.reload({
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
    layui.use('form', function () {
        var form = layui.form;
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
</html>