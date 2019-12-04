<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <button id="addpaper" type="button" class="layui-btn layui-btn-danger" style="margin-left: 50%">新增</button>
    <table class="layui-table" lay-even="" lay-skin="row" lay-size="lg">
        <thead>
            <tr>
                <th>编号</th>
                <th>员工名称</th>
                <th>意见建议</th>
                <th>填写日期</th>
                <th>本周情况描述</th>
                <th>问题学生情况反馈</th>
                <th>下周工作计划</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="paperlist">
                <tr>
                    <td>${paperlist.weeklogid}</td>
                    <td>${paperlist.Empid}</td>
                    <td>${paperlist.Idea}</td>
                    <td>${paperlist.Workday}</td>
                    <td>${paperlist.weekCur}</td>
                    <td>${paperlist.studentQuestion}</td>
                    <td>${paperlist.weekNext}</td>
                    <td>
                        <!--删除-->
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>删除</button>
                        <!--编辑-->
                        <button type="button" id="xiugai" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>修改</button>
                        <!--查看周报-->
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-sm "><i class="layui-icon layui-icon-search"></i>查看周报 </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
<script>
    //点击新增去到新增页面
    $("#addpaper").click(function () {
        location.href="<%=request.getContextPath()%>/emp/addEmpPaperPage";
    })

    //弹出层
    $("#xiugai").click(function () {
        layui.use('layer',function () {
            var layer = layui.layer;
            layer.open({
                type:2,
                title:'周报修改',
                content:'<%=request.getContextPath()%>/emp/updateEmpPaperPage'
            })
        })
    })

</script>
</html>