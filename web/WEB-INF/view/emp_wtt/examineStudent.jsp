<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/16
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <form method="post" action="<%=request.getContextPath()%>/student/complete">
        <input type="hidden" name="taskid" value="${taskid}">
        <input type="hidden" name="id" value="${leavevo.holidayid}">
        <table class="layui-table" style="width:50%;height: 50%;margin-left:25%" >
            <tr>
                <td>请假人</td>
                <td>
                    ${name}
                </td>
            </tr>
            <tr>
                <td>请假天数</td>
                <td>
                    ${leavevo.holidayDay}
                </td>
            </tr>
            <tr>
                <td>开始时间</td>
                <td>
                    ${leavevo.startTime}
                </td>
            </tr>
            <tr>
                <td>结束时间</td>
                <td>
                    ${leavevo.endTime}
                </td>
            </tr>
            <tr>
                <td>请假事由</td>
                <td>
                    ${leavevo.remark}
                </td>
            </tr>
            <tr >
                <td>是否批准</td>
                <td>
                    <select name="opinion">
                        <option value="同意">同意</option>
                        <option value="拒绝">拒绝</option>
                    </select>
                </td>
            </tr>
            <tr bgcolor="white">
                <td>备注</td>
                <td>
                    <textarea cols="30" rows="10" name="comment"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="审批">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>