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
            <form class="layui-form">
                时间:
                <div class="layui-inline" style="padding-right: 15px">
                    <select name="depId" lay-verify="required">
                        <option value="0" selected>全部月份</option>
                        <c:forEach items="${month}" var="m">
                            <option value="${m}">${m}月</option>
                        </c:forEach>
                    </select>
                </div>
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
        var empIns = table.render({
            elem: '#empList'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getEveryDayData'
            ,cols: [[
                {field:'empId', title:'员工编号', fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称'}
                ,{field:'depName', title:'部门名称'}
                ,{field:'Sex', title:'性别'}
                ,{field:'Phone', title:'手机号'}
                ,{field:'scores', title:'考核总分', fixed: 'right'}
            ]]
            ,height:'full-300'
            ,page: {limit: 10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        //重载表格
        $("#btn").click(function () {
            /*//获取条件
            var empName = $('input[name="empName"]').val();
            var depId = $('select[name="depId"] option:selected').val();
            //调用重载方法
            empIns.reload({
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