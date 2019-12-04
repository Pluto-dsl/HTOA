<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <form method="post" action="<%=request.getContextPath()%>/emp/addEmpPaper" class="layui-form">
        <table class="layui-table" style="width: 50%">
            <tr style="text-align: center">
                <td colspan="2">新增周报</td>
            </tr>
            <tr>
                <td>本周情况描述</td>
                <td>
                    <textarea rows="3" cols="40" name="weekCur"/></textarea>
                </td>
            </tr>
            <tr>
                <td>问题学生情况反馈</td>
                <td>
                    <textarea rows="3" cols="40" name="studentQuestion"/></textarea>
                </td>
            </tr>
            <tr>
                <td>意见建议</td>
                <td>
                    <textarea rows="3" cols="40" name="Idea"/></textarea>
                </td>
            </tr>
            <tr>
                <td>下周工作计划</td>
                <td>
                    <textarea rows="3" cols="40" name="weekNext"/></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                   <button class="layui-btn" type="submit">
                        <i class="layui-icon">&#xe608;</i>添加
                   </button>
                    <%--<input type="submit" value="新增"/>--%>
                </td>
            </tr>
        </table>
    </form>
</body><%--
<script>
    layui.use('element', function(){
        var element = layui.element;
    })
</script>--%>
</html>