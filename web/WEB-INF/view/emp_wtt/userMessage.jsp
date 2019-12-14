<%@ page import="java.util.List" %>
<%@ page import="com.publics.vo.empModel.emp.EmpVo" %><%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/14
  Time: 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <table style="width: 30%;margin-top: 1%" align="center" border="1">
        <tr>
            <th colspan="4">员工信息</th>
        </tr>
        <tr>
            <td>员工姓名</td>
            <td>
                ${list.empName}
            </td>
            <td>部门名称</td>
            <td>
                <%--${list.depId}--%>
            </td>
        </tr>
    </table>
</body>
<script type="javascript">
    console.log(${list})
</script>
</html>