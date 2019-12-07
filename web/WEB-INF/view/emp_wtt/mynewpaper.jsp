<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 19:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <h1 align="center">宏图软件工作周报</h1>
    <br><br>
    <h3 style="margin-left:36%">部门:教研部 &nbsp&nbsp&nbsp&nbsp 姓名:刘飞  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 时间:${list.workday}</h3>
    <table class="layui-table" style="width: 30%;margin-left:35%">
        <%--<input type="hidden"/>--%>
        <tr>
           <td rowspan="3">
                本周总结
           </td>
            <td>
                <div>
                    本周情况
                </div>
            </td>
            <td>
                <div style="width:400px;height:100px">
                    ${list.weekCur}
                </div>
            </td>
        </tr>
        <tr>
            <td>
                问题学生情况反馈
            </td>
            <td>
                <div style="width:400px;height:100px">
                    ${list.studentQuestion}
                </div>
            </td>
        </tr>
        <tr>
            <td>
                意见建议
            </td>
            <td>
                <div style="width:400px;height:100px">
                    ${list.idea}
                </div>
            </td>
        </tr>
        <tr>
            <td>
                下周计划
            </td>
            <td>
                下周计划
            </td>
            <td>
                <div style="width:400px;height:100px">
                    ${list.weekNext}
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                <button type="button" style="margin-left: 5%" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon layui-icon-return" onclick="get_back()"></i>返回</button>
            </td>
        </tr>
    </table>
</body>
<script language="JavaScript">
    function get_back() {
        location.href='<%=request.getContextPath()%>/emp/toEmpPaper'
    }
</script>
</html>