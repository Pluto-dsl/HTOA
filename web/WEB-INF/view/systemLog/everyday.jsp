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
        .menu{
            margin-top: 8px;
            margin-left: 15px;
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
            <button class="layui-btn menu" id="btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
        </td>
    </tr>
</table>
<table id="empList" lay-filter="test"></table>
<div style="width: 100%;height: 234px">
    <table id="everyDay" lay-filter="every"></table>
</div>
<script type="text/html" id="toolbarDemo">
    员工考核详情报表
</script>
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

        var everyIns = table.render({
            elem: '#everyDay'
            ,method:"post"
            ,url:'${pageContext.request.contextPath}/systemLog/getEveryList'
            ,title: '员工考核详情报表'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,cols: [[
                {field:'aduitLogid', hide:true}
                ,{field:'empName', title:'员工名称', fixed: 'left'}
                ,{field:'aduitName', title:'考核内容', fixed: 'left'}
                ,{field:'Scores', title:'考核分数', unresize: true, sort: true}
                ,{field:'auditDate', title:'考核时间',templet:function (d){return createTime(d.auditDate);}, unresize: true, sort: true}
                ,{field:'auditPerson', title:'录入人员'}
                ,{field:'Remark', title:'说明'}
                ,{field:'Image', title:'说明',templet:function (d) {
                        return "单击此行显示图片"
                    }
                }
            ]]
            ,height:'220'
        });



        //监听行工具事件
        table.on('tool(test)', function(obj){

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

        //监听行单击事件(员工考核详情报表)
        //137
        table.on('row(every)', function(obj){
            var data = obj.data;//当前行数据
            var tr = obj.tr;//当前行对象
            $.getJSON('${pageContext.request.contextPath}/systemLog/getImg/'+data.aduitLogid, function(json){
                layer.photos({
                    photos: json
                    ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
                });
            });
        });
        //重载表格
        $("#btn").click(function () {
            //获取条件
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
</html>