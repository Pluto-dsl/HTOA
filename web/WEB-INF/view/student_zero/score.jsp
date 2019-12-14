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
        <label class="layui-form-label" style="width: 90px">在读学期:</label>
        <div class="layui-input-inline">
            <select id="term" name="term">
                <option value="0">--未选择--</option>
                <c:forEach var="t" items="${term}">
                    <option value="${t.termid}">${t.termName}</option>
                </c:forEach>
            </select>
        </div>
        <label class="layui-form-label" style="width: 90px">班级名称:</label>
        <div class="layui-input-inline">
            <select id="className" name="className" style="width: 100px">
                <option value="0">--未选择--</option>
                <c:forEach var="c" items="${claes}">
                    <option value="${c.classId}">${c.className}</option>
                </c:forEach>
            </select>
        </div>
        <label class="layui-form-label" style="width: 90px">考试类别:</label>
        <div class="layui-input-inline">
            <select id="stype" name="stype">
                <option value="0">--未选择--</option>
                <option value="1">笔试</option>
                <option value="2">机试</option>
                <option value="3">模拟面试</option>
            </select>
        </div>
        <label class="layui-form-label" style="width: 90px">课程名称:</label>
        <div class="layui-input-inline">
            <select id="courseName" name="courseName">
                <option value="0">--未选择--</option>
                <c:forEach var="c" items="${course}">
                    <option value="${c.courseId}">${c.courseName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="layui-input-inline">
            <button id="seek"  class="layui-btn" onclick="seek()">搜索</button>
        </div>
    </label>
</script>
</body>
<script>
    var table;
    layui.use(['table'], function() {
        table = layui.table;
        table.render({
            elem: '#demo',
            height: 600,
            url: '<%=request.getContextPath()%>/StudentScore/score', //数据接口,
            id: "tt",
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            page: true, //开启分页
            cols: [[ //表头
                {field: 'scoreId', title: '序号', width: 100,sort:'true'}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'score', title: '学生成绩', width: 120,sort:'true'}
                , {field: 'Rescore', title: '补考分数', width: 120,sort:'true'}
                , {field: 'courseName',title:'课程名称',width:120}
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
        table.on('toolbar(top)', function(obj){

        })
    })

    //条件搜索
    function seek() {
        //在读学期
        var term = $("#term").val();
        //班级id
        var  classId = $("#className").val();
        //考试类别
        var type = $("#stype").val();
        //课程名称
        var course = $("#courseName").val();
        table.reload('tt',{
            url:'<%=request.getContextPath()%>/StudentScore/scoreseek',
            where:{
                term:term,
                classId:classId,
                type:type,
                course:course
            },
            page: {
                curr: 1 //重新从第 1 页开始
            },done: function(res, page, count){
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
        }
        })
        $("#term").val(term);
        $("#className").val(classId);
        $("#stype").val(type);
        $("#courseName").val(course);
    }
</script>
</html>
