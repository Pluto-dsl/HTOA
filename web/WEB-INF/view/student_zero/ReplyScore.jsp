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
    <title>答辩成绩</title>
    <jsp:include page="../include.jsp"/>

</head>
<body>
    <table id="demo" lay-filter="test"></table>
    <script type="text/html" id="top" lay-filter="top">
        <label  class="layui-form-item">
            <label class="layui-form-label" style="width: 90px">项目名称:</label>
            <div class="layui-input-inline">
                <select id="projectName" name="projectName">
                    <option value="0">--未选择--</option>
                    <c:forEach var="p" items="${project}">
                        <option value="${p.projectId}">${p.projectName}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label" style="width: 90px">班级名称:</label>
            <div class="layui-input-inline">
                <select id="className" name="className">
                    <option value="0">--未选择--</option>
                    <c:forEach var="c" items="${claes}">
                        <option value="${c.classId}">${c.className}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label" style="width: 90px">评分人员:</label>
            <div class="layui-input-inline">
                <select id="empName" name="empName">
                    <option value="0">--未选择--</option>
                    <c:forEach var="e" items="${teacher}">
                        <option value="${e.empId}">${e.empName}</option>
                    </c:forEach>
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
            url: '<%=request.getContextPath()%>/StudentScore/replyScore', //数据接口,
            id: "clientId",
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            page: true, //开启分页
            cols: [[ //表头
                {field: 'replyId', title: '序号', width: 70}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'className', title: '班级名称', width: 200}
                , {field: 'projectName', title: '项目名称', width: 130}
                , {field: 'score1',title:'功能完善50',width:103}
                , {field: 'Score2',title:'技术难度10',width:103}
                , {field: 'Score3',title:'界面完美10',width:103}
                , {field: 'Score4',title:'回答问题10',width:103}
                , {field: 'Score5',title:'演示方法10',width:103}
                , {field: 'Score6',title:'语言表达10',width:103}
                , {field: 'Score7',title:'总分100',width:100}
                , {field: 'Remark', title: '备注', width: 100}
            ]],
                limits: [10, 20, 30 , 40, 50]
        });
    })

    //条件搜索
    function seek() {
        //项目名称id
        var  projectId = $("#projectName").val();
        //班级id
        var  classId = $("#className").val();
        //评分人员
        var  empId = $("#empName").val();
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

        $("#projectName").val(projectId);
        $("#className").val(classId);
        $("#empName").val(empId);
    }
</script>
</html>
