<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/23
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <table style="width:40%;margin-top: 1%;height:100%;text-align: center" align="center" border="1">
        <tr>
            <th colspan="4">学生信息</th>
        </tr>
        <tr>
            <td>学生姓名</td>
            <td>
                ${studentlist.stuname}
            </td>
            <td>出生年月</td>
            <td>
                <fmt:formatDate value="${studentlist.birthday}" type="date"></fmt:formatDate>
            </td>
        </tr>
        <tr>
            <td>毕业学校</td>
            <td>
                ${studentlist.middleschool}
            </td>
            <td>介绍老师</td>
            <td>
                ${studentlist.introduretech}
            </td>
        </tr>
        <tr>
            <td>户口性质</td>
            <td>
                ${studentlist.registration}
            </td>
            <td>籍贯</td>
            <td>
                ${studentlist.natives}
            </td>
        </tr>
        <tr>
            <td>身份证号</td>
            <td>
                ${studentlist.cardid}
            </td>
            <td>中专学校</td>
            <td>
                ${studentlist.vocationalsch}
            </td>
        </tr>
        <tr>
            <td>专业类别</td>
            <td>
                <c:if test="${studentlist.prolevel==1}">
                    高技
                </c:if>
                <c:if test="${studentlist.prolevel==2}">
                    中技
                </c:if>
                <c:if test="${studentlist.prolevel==3}">
                    3+2
                </c:if>
                <c:if test="${studentlist.prolevel==4}">
                    成人教育
                </c:if>
            </td>
            <td>学习类别</td>
            <td>
                全日制
            </td>
        </tr>
        <tr>
            <td>电话</td>
            <td>
                ${studentlist.phone}
            </td>
            <td>性别</td>
            <td>
                ${studentlist.sex}
            </td>
        </tr>
        <tr>
            <td>年龄</td>
            <td>
                ${studentlist.age}
            </td>
            <td>民族</td>
            <td>
                ${studentlist.nation}
            </td>
        </tr>
        <tr>
            <td>状态</td>
            <td id="stat" >
                <c:if test="${studentlist.stat==1}">
                    意向学生
                </c:if>
                <c:if test="${studentlist.stat==2}">
                    预定报名学生
                </c:if>
                <c:if test="${studentlist.stat==3}">
                    试学学生
                </c:if>
                <c:if test="${studentlist.stat==4}">
                    在读学生
                </c:if>
                <c:if test="${studentlist.stat==5}">
                    已毕业学生
                </c:if>
                <c:if test="${studentlist.stat==6}">
                    退学
                </c:if>

            </td>
            <td>省录取号</td>
            <td>
                ${studentlist.enrollno}
            </td>
        </tr>
        <tr>
            <td>欠款金额</td>
            <td>
                ${studentlist.qkMoney}
            </td>
            <td>录取成绩</td>
            <td>
                ${studentlist.score}
            </td>
        </tr>
        <tr>
            <td>是否低保</td>
            <td>
                ${studentlist.dibao}
            </td>
            <td>生源类型</td>
            <td>
                ${studentlist.sourceType}
            </td>
        </tr>
        <%--<tr>
            <th colspan="4">教育信息</th>
        </tr>--%>
        <tr>
            <td>老师电话</td>
            <td>
                ${studentlist.intrphone}
            </td>
            <td>就读专业</td>
            <td>
                ${studentlist.professional}
            </td>
        </tr>
        <tr>
            <td>担保人</td>
            <td>
                ${studentlist.guarantee}
            </td>
            <td>入学时间</td>
            <td>
                <fmt:formatDate value="${studentlist.entertime}" type="date"></fmt:formatDate>
            </td>
        </tr>
        <tr>
            <td>班级名称</td>
            <td>
                ${classname}
            </td>
            <td>宿舍名称</td>
            <td>
                ${hourname}
            </td>
        </tr>
        <tr>
            <td>面试人</td>
            <td>
                ${studentlist.audition}
            </td>
            <td>面试人意见</td>
            <td>
                ${studentlist.auditionoption}
            </td>
        </tr>
        <tr>
            <td>家长姓名</td>
            <td>
                ${studentlist.parents}
            </td>
            <td>家长电话</td>
            <td>
                ${studentlist.parentsphone}
            </td>
        </tr>
        <tr>
            <td>是否当兵</td>
            <td>
                ${studentlist.soldier}
            </td>
            <td>报名号</td>
            <td>
                ${studentlist.registration}
            </td>
        </tr>
        <tr>
            <td>是否住校</td>
            <td>
                ${studentlist.zhuxiao}
            </td>
            <td>备注</td>
            <td>
                ${studentlist.remark}
            </td>
        </tr>
        <tr>
            <td>退学</td>
            <td>
                ${studentlist.tuixue}
            </td>
            <td>休学</td>
            <td>
                ${studentlist.xiuxue}
            </td>
        </tr>
        <tr>
            <td>学号</td>
            <td>
                ${studentlist.stuno}
            </td>
            <td>是否送电脑</td>
            <td>
                ${studentlist.computer}
            </td>
        </tr>
        <tr>
            <td>是否领用</td>
            <td>
                ${studentlist.collar}
            </td>
            <td>助学金</td>
            <td>
                ${studentlist.grants}
            </td>
        </tr>
    </table>
</body>
</html>