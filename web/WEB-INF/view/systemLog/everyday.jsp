<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/13
  Time: 19:50
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
        .top{
            width: 100%;
            height: 60%;
        }
        .menu{
            margin-top: 8px;
            margin-left: 15px;
        }
        .layui-table-view{
        }
    </style>
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
                部门名称:
                <div class="layui-inline" style="padding-right: 15px">
                    <select name="depId" lay-verify="required">
                        <option value="0" selected>所有部门</option>
                        <c:forEach items="${requestScope.depList}" var="dep">
                            <option value="${dep.depid}">${dep.depName}</option>
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
<table id="empList" lay-filter="test"></table>
<div style="width: 100%;height: 234px;background-color: #9F9F9F">
    <table id="everyDay" lay-filter="every"></table>
</div>
<%--<div id="layer-photos-demo" class="layer-photos-demo">
    <img layer-src="" src="" alt="图片名">
</div>
<script>
    //调用示例
    layer.photos({
        photos: '#layer-photos-demo'
        ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
    });
</script>--%>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var tableIns = table.render({
            elem: '#empList'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getEveryDayData'
            ,title: '员工考核总表'
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

        //监听行工具事件
        table.on('tool(test)', function(obj){

        });
        //监听行单击事件
        table.on('row(test)', function(obj){
            var data = obj.data;//当前行数据
            var tr = obj.tr;//当前行对象
            console.log(data);
            console.log(data.empId);
            //getEveryList(data.empId);

        });
        //重载表格
        $("#btn").click(function () {
            /*console.log("fasfd");
            //获取条件
            var empName = $('input[name="empName"]').val();
            var depId = $('select[name="depId"] option:selected').val();
            var startDay = $('input[name="startDay"]').val();
            var endDay = $('input[name="endDay"]').val();
            //调用重载方法
            tableIns.reload({
                where: { //设定异步数据接口的额外参数，任意设
                    empName:empName,
                    depId:depId,
                    startDay:startDay,
                    endDay:endDay
                }
                ,method:'post'
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
            });*/
        });
    });
</script>
<script>
    function getEveryList(empId) {
        $.ajax("${pageContext.request.contextPath}/systemLog/getEveryList",{empId:empId},function (data) {
            console.log(data);
            $(data).each(function (index,element) {
                console.log(element)
            })
        },"json")
    }
</script>
</html>