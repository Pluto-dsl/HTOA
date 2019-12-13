<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/13
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考试成绩</title>
    <jsp:include page="../include.jsp"/>

</head>
<body>
<table id="demo" lay-filter="test"></table>
<script type="text/html" id="top" lay-filter="top">
    <label  class="layui-form-item">
        <label class="layui-form-label" style="width: 50px">在读学期:</label>
        <div class="layui-input-inline">
            <select id="projectName" name="projectName">
                <option value="0">--未选择--</option>
            </select>
        </div>
        <label class="layui-form-label" style="width: 100px">班级名称:</label>
        <div class="layui-input-inline">
            <select id="className" name="className">
                <option value="0">--未选择--</option>
                <c:forEach var="c" items="${claes}">
                    <option value="${c.classId}">${c.className}</option>
                </c:forEach>
            </select>
        </div>
        <label class="layui-form-label" style="width: 80px">考试类别:</label>
        <div class="layui-input-inline">
            <select id="empName" name="empName">
                <option value="0">--未选择--</option>

            </select>
        </div>
        <label class="layui-form-label" style="width: 80px">课程名称:</label>
        <div class="layui-input-inline">
            <select id="Name" name="empName">
                <option value="0">--未选择--</option>

            </select>
        </div>
        <div class="layui-input-inline">
            <button id="seek" type="submit" class="layui-btn" onclick="seek()">搜索</button>
        </div>
    </label>
</script>
</body>
<script>
    var table;
    layui.use(['table', 'form'], function() {
        var form = layui.form;
        table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo',
            height: 600,
            url: '<%=request.getContextPath()%>/StudentScore/score', //数据接口,
            id: "clientId",
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            page: true, //开启分页
            cols: [[ //表头
                {field: 'scoreId', title: '序号', width: 70}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'score', title: '学生成绩', width: 90}
                , {field: 'Rescore', title: '补考分数', width: 100}
                , {field: 'courseName',title:'课程名称',width:103}
                , {field: 'testType',title:'考试类别',width:103}
                , {field: 'termName',title:'在读学期',width:103}
                , {field: 'scoreTime',title:'考试时间',width:150,templet : "<div>{{layui.util.toDateString(d.scoreTime,'yyyy年MM月dd日')}}</div>"}
                , {field: 'empName',title:'录入人员',width:103}
                , {field: 'Remark', title: '备注', width: 150}
            ]]
            ,done: function(res, page, count){
            //如果是异步请求数据方式，res即为你接口返回的信息。
            //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
            //分类显示中文名称
                $("[data-field='testType']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("笔试")
                    }else if($(this).text()=='2'){
                        $(this).text("机试")
                    }else if($(this).text()=='3'){
                        $(this).text("模拟面试")
                    }
                })
            },
            limits: [10, 20, 30 , 40, 50]
        });
    })

    //条件搜索
    function seek() {

        //班级id
        var  classId = $("#className").val();

        table.reload('clientId',{
            url:'<%=request.getContextPath()%>/StudentScore/seek',
            where:{
                projectId:projectId,
                classId:classId,
                empId:empId,
            }, page: {
                curr: 1 //重新从第 1 页开始
            }
        })


        $("#className").val(classId);

    }
</script>
</html>
