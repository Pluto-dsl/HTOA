<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/16
  Time: 20:51
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
<table style="margin-top: 10px">
    <tr>
        <td>
            <form class="layui-form" id="myForm">
                <div class="layui-form-item">
                    <label class="layui-form-label">选择楼栋</label>
                    <div class="layui-input-inline">
                        <select name="floor">
                            <option value="">请选择楼栋</option>
                            <c:forEach items="${requestScope.floorList}" var="floor">
                                <option value="${floor.floorId}">${floor.floorName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <label class="layui-form-label">选择楼层</label>
                    <div class="layui-input-inline">
                        <select name="floorNum">
                            <option value="">请选择楼层</option>
                        </select>
                    </div>
                </div>
            </form>
        </td>
    </tr>
</table>
<table id="stuHour" lay-filter="test"></table>
</body>
<script>
    layui.use(['form','table'], function(){
        var form = layui.form,
            table = layui.table;
        var tableIns = table.render({//初始化表格
            elem: '#stuHour'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getStuHourData'
            ,cols: [[
                {field:'floorName', title:'宿舍楼栋', unresize: true, sort: true},
                {field:'addr', title:'宿舍地址'},
                {field:'hourName', title:'宿舍房号'},
                {field:'stuNum', title:'录入学生数', unresize: true, sort: true},
                {field:'numberBeds', title:'床位数', unresize: true, sort: true},
                {field:'surplus', title:'空位数', unresize: true, sort: true}
            ]]
            ,page: {limit: 15,limits:[5,10,15,20,30],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        form.on('select', function(data){
            if(data.elem.name === "floor"){
                if (data.value === null || data.value === ""){
                    loadingHour(0);
                }else {
                    loadingHour(data.value);
                }
                tableIns.reload({
                    where:{
                        floor:data.value,
                        floorNum:""
                    }
                });
            }else if (data.elem.name === "floorNum"){
                console.log(data);
                console.log(data.value);
                tableIns.reload({
                    where:{
                        floorNum:data.value
                    }
                });
            }
        });
    });
</script>
<script>
    function loadingHour(floorId) {
        var data = {floorId:floorId};
        $.post("${pageContext.request.contextPath}/systemLog/hourByFloor",data,function (data) {
            var html = "<option value=\"\">请选择楼层</option>";
            $(data.data).each(function (index,element) {
                html += "<option value=\""+element.floorNum+"\">"+element.floorNum+"楼</option>"
            });
            $("select[name='floorNum']").html(html);
            layui.use('form', function () {
                var form = layui.form;
                form.render();
            })
        },"json")
    }
</script>
</html>
