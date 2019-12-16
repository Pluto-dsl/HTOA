<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <table style="width:40%;margin-top: 1%;height:80%;text-align: center" align="center" border="1">
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
               ${depname}
            </td>
        </tr>
        <tr>
            <td>出生日期</td>
            <td>
                ${list.birthday}
            </td>
            <td>身份证号</td>
            <td>
                ${list.cardno}
            </td>
        </tr>
        <tr>
            <td>籍贯</td>
            <td>
                ${list.nation}
            </td>
            <td>手机号码</td>
            <td>
                ${list.phone}
            </td>
        </tr>


        <tr>
            <th colspan="4">工作经历</th>
        </tr>
        <c:forEach items="${joblist}" var="list">
            <tr>
                <td>公司名称</td>
                <td>
                    ${list.companyName}
                </td>
                <td>岗位</td>
                <td>
                    ${list.degree}
                </td>
            </tr>


            <tr>
                <td>入职时间</td>
                <td>
                    ${list.startDate}
                </td>
                <td>离职时间</td>
                <td>
                    ${list.endDate}
                </td>
            </tr>
        </c:forEach>


        <tr>
            <th colspan="4">教育背景</th>
        </tr>
        <c:forEach items="${education}" var="educationlist">
            <tr>
                <td>学校名称</td>
                <td>
                    ${educationlist.collegeName}
                </td>
                <td>学历</td>
                <td>
                    ${educationlist.degree}
                </td>
            </tr>
            <tr>
                <td>入校时间</td>
                <td>
                    ${educationlist.startDate}
                </td>
                <td>毕业时间</td>
                <td>
                    ${educationlist.endDate}
                </td>
            </tr>
        </c:forEach>

        <tr>
            <th colspan="4">家庭联系信息</th>
        </tr>
        <c:forEach items="${famliy}" var="famliylist">
        <tr>
            <td>联系人名称</td>
            <td>
                ${famliylist.contactName}
            </td>
            <td>与员工信息</td>
            <td>
                ${famliylist.relationship}
            </td>
        </tr>
        <tr>
            <td>联系电话</td>
            <td colspan="3">
                ${famliylist.Phone}
            </td>
        </tr>
        </c:forEach>
    </table>
</body>
</html>