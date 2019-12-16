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
</head>
<body>
<table>
    <tr>
        <td>
            员工姓名:
            <div class="layui-inline" style="padding-right: 15px">
                <input class="layui-input" name="empName" id="empName" autocomplete="off">
            </div>
        </td>
        <td>
            <input type="radio" name="month" value="${month.lastMonth}" title="上一月(${month.lastMonth})" checked="">
            <input type="radio" name="month" value="${month.lastMonth}" title="本月(${month.lastMonth})">
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
                {field:'empId', title:'未打卡编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称'}
                ,{field:'depName', title:'申请时间',unresize: true, sort: true}
                ,{field:'depName', title:'未打卡时间',unresize: true, sort: true}
                ,{field:'Sex', title:'原因'}
                ,{field:'Phone', title:'审核人'}
                ,{field:'scores', title:'审核说明'}
                ,{field:'scores', title:'审核时间',unresize: true, sort: true}
                ,{field:'scores', title:'审核状态'}
            ]]
            ,height:'full-200'
            ,page: {limit: 20,limits:[5,10,15,20,30],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        //重载表格
        $("#btn").click(function () {
            /*//获取条件
            var empName = $('input[name="empName"]').val();
            var depId = $('select[name="depId"] option:selected').val();
            //调用重载方法
            workTime.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    empName:empName,
                    depId:depId
                }
                ,method:'post'
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });*/
        });
    });
</script>
</html>