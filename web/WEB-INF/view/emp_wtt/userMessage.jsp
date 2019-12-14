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

            <tr>
                <td>公司名称</td>
                <td>
                        <%--${education.collegeName}--%>
                    ${joblist.companyName}
                </td>
                <td>岗位</td>
                <td>
<%--                        ${education.}--%>
                    ${joblist.degree}
                </td>
            </tr>


            <tr>
                <td>入职时间</td>
                <td>
                        <%--${job.companyName}--%>
                    ${joblist.startDate}
                </td>
                <td>离职时间</td>
                <td>
                        <%--                ${list.phone}--%>
                    ${joblist.endDate}
                </td>
            </tr>

        <tr>
            <th colspan="4">教育背景</th>
        </tr>
        <%--<c:forEach items="${education}" var="educationlist">--%>
            <tr>
                <td>学校名称</td>
                <td>
<%--                    ${educationlist.collegeName}--%>
                    ${education.collegeName}
                </td>
                <td>学历</td>
                <td>
                    ${education.degree}
                </td>
            </tr>
            <tr>
                <td>入校时间</td>
                <td>
<%--                   ${educationlist.startDate}--%>
                        ${education.startDate}
                </td>
                <td>毕业时间</td>
                <td>
                    <%--${educationlist.endDate}--%>
                        ${education.endDate}
                </td>
            </tr>
        <%--</c:forEach>--%>
        <tr>
            <th colspan="4">家庭联系信息</th>
        </tr>
        <tr>
            <td>联系人名称</td>
            <td>
                ${famliy.contactName}
            </td>
            <td>与员工信息</td>
            <td>
                ${famliy.relationship}
            </td>
        </tr>
        <tr>
            <td>联系电话</td>
            <td colspan="3">
                ${famliy.Phone}
            </td>
        </tr>
    </table>
</body>
</html>