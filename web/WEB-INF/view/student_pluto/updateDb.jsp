<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                                                                                                                                                        <%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/17
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <form class="layui-form" action="${pageContext.request.contextPath}/StudentScore/editReplyscore" id="form1" method="post">
        <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
            <input type="hidden" name="replyId" id="replyId" value="${p.replyId}"/>
            <input type="hidden" name="StudentId" id="StudentId" value="${p.studentId}"/>
            <input type="hidden" name="projectId" id="projectId" value="${p.projectId}"/>
            <input type="hidden" name="Score7" id="Score7" value="0"/>
            <tr>
                <th colspan="4">
                    <font style="font-size: 25px;">
                        修改学生答辩成绩
                    </font>
                </th>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">学&nbsp;生&nbsp;姓&nbsp;名:</label>

                </td>
                <td>
                    <label class="label-top">${s.stuname}</label>
                </td>
                <td>
                    <label class="label-top">答辩科目:</label>

                </td>
                <td>
                    <label class="label-top">${pro.projectName}</label>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">技术难度10:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="Score2" value="" id="Score2" editable="false"  ditable="false" style="width:290px;">
                        <option value="1"  <c:if test="${p.score2 eq 1}" >selected="selected"</c:if>>1</option>
                        <option value="2"  <c:if test="${p.score2 eq 2}" >selected="selected"</c:if>>2</option>
                        <option value="3"  <c:if test="${p.score2 eq 3}" >selected="selected"</c:if>>3</option>
                        <option value="4"  <c:if test="${p.score2 eq 4}" >selected="selected"</c:if>>4</option>
                        <option value="5"  <c:if test="${p.score2 eq 5}" >selected="selected"</c:if>>5</option>
                        <option value="6"  <c:if test="${p.score2 eq 6}" >selected="selected"</c:if>>6</option>
                        <option value="7"  <c:if test="${p.score2 eq 7}" >selected="selected"</c:if>>7</option>
                        <option value="8"  <c:if test="${p.score2 eq 8}" >selected="selected"</c:if>>8</option>
                        <option value="9"  <c:if test="${p.score2 eq 9}" >selected="selected"</c:if>>9</option>
                        <option value="10" <c:if test="${p.score2 eq 10}">selected="selected"</c:if>>10</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">界面完美10:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="Score3" value="" id="Score3" editable="false"  ditable="false" style="width:290px;">
                        <option value="1"  <c:if test="${p.score3 eq 1}"> selected="selected"</c:if>>1</option>
                        <option value="2"  <c:if test="${p.score3 eq 2}"> selected="selected"</c:if>>2</option>
                        <option value="3"  <c:if test="${p.score3 eq 3}"> selected="selected"</c:if>>3</option>
                        <option value="4"  <c:if test="${p.score3 eq 4}"> selected="selected"</c:if>>4</option>
                        <option value="5"  <c:if test="${p.score3 eq 5}"> selected="selected"</c:if>>5</option>
                        <option value="6"  <c:if test="${p.score3 eq 6}"> selected="selected"</c:if>>6</option>
                        <option value="7"  <c:if test="${p.score3 eq 7}"> selected="selected"</c:if>>7</option>
                        <option value="8"  <c:if test="${p.score3 eq 8}"> selected="selected"</c:if>>8</option>
                        <option value="9"  <c:if test="${p.score3 eq 9}"> selected="selected"</c:if>>9</option>
                        <option value="10" <c:if test="${p.score3 eq 10}">selected="selected"</c:if>>10</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">回答问题10:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="Score4" value="" id="Score4" editable="false"  ditable="false" style="width:290px;">
                        <option value="1"  <c:if test="${p.score4 eq 1}">  selected="selected"</c:if>>1</option>
                        <option value="2"  <c:if test="${p.score4 eq 2}">  selected="selected"</c:if>>2</option>
                        <option value="3"  <c:if test="${p.score4 eq 3}">  selected="selected"</c:if>>3</option>
                        <option value="4"  <c:if test="${p.score4 eq 4}">  selected="selected"</c:if>>4</option>
                        <option value="5"  <c:if test="${p.score4 eq 5}">  selected="selected"</c:if>>5</option>
                        <option value="6"  <c:if test="${p.score4 eq 6}">  selected="selected"</c:if>>6</option>
                        <option value="7"  <c:if test="${p.score4 eq 7}">  selected="selected"</c:if>>7</option>
                        <option value="8"  <c:if test="${p.score4 eq 8}">  selected="selected"</c:if>>8</option>
                        <option value="9"  <c:if test="${p.score4 eq 9}">  selected="selected"</c:if>>9</option>
                        <option value="10" <c:if test="${p.score4 eq 10}"> selected="selected"</c:if>>10</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">演示方法10:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="Score5" value="" id="Score5" editable="false"  ditable="false" style="width:290px;">
                        <option value="1"  <c:if test="${p.score5 eq 1}"> selected="selected"</c:if> >1</option>
                        <option value="2"  <c:if test="${p.score5 eq 2}"> selected="selected"</c:if> >2</option>
                        <option value="3"  <c:if test="${p.score5 eq 3}"> selected="selected"</c:if> >3</option>
                        <option value="4"  <c:if test="${p.score5 eq 4}"> selected="selected"</c:if> >4</option>
                        <option value="5"  <c:if test="${p.score5 eq 5}"> selected="selected"</c:if> >5</option>
                        <option value="6"  <c:if test="${p.score5 eq 6}"> selected="selected"</c:if> >6</option>
                        <option value="7"  <c:if test="${p.score5 eq 7}"> selected="selected"</c:if> >7</option>
                        <option value="8"  <c:if test="${p.score5 eq 8}"> selected="selected"</c:if> >8</option>
                        <option value="9"  <c:if test="${p.score5 eq 9}"> selected="selected"</c:if> >9</option>
                        <option value="10" <c:if test="${p.score5 eq 10}">selected="selected"</c:if> >10</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">语言表达10:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="Score6" value="" id="Score6" editable="false"  ditable="false" style="width:290px;">
                        <option value="1"  <c:if test="${p.score6 eq 1}"> selected="selected"</c:if>>1</option>
                        <option value="2"  <c:if test="${p.score6 eq 2}"> selected="selected"</c:if>>2</option>
                        <option value="3"  <c:if test="${p.score6 eq 3}"> selected="selected"</c:if>>3</option>
                        <option value="4"  <c:if test="${p.score6 eq 4}"> selected="selected"</c:if>>4</option>
                        <option value="5"  <c:if test="${p.score6 eq 5}"> selected="selected"</c:if>>5</option>
                        <option value="6"  <c:if test="${p.score6 eq 6}"> selected="selected"</c:if>>6</option>
                        <option value="7"  <c:if test="${p.score6 eq 7}"> selected="selected"</c:if>>7</option>
                        <option value="8"  <c:if test="${p.score6 eq 8}"> selected="selected"</c:if>>8</option>
                        <option value="9"  <c:if test="${p.score6 eq 9}"> selected="selected"</c:if>>9</option>
                        <option value="10" <c:if test="${p.score6 eq 10}">selected="selected"</c:if>>10</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">功能完善50:</label>
                </td>
                <td>
                    <input name="score1" id="score1" autocomplete="off" class="layui-input" value="${p.score1}"
                           style="width:290px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td>
                    <label class="label-top">评分老师:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="empId" value="" id="empId" editable="false"  ditable="false" style="width:290px;">
                        <c:forEach items="${eList}" var="e">
                            <option value="${e.empId}" <c:if test="${e.empId eq p.empId}">selected="selected"</c:if>>${e.empName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label class="label-top">备注:</label>
                </td>
                <td>
                    <textarea placeholder="请输入内容" name="Remark" class="layui-textarea">${p.remark}</textarea>
                </td>
            </tr>

            <tr style="height: 40px">
                <td colspan="4">
                    <center>
                        <button class="layui-btn" id="submit" lay-submit lay-filter="sub">保存</button>
                    </center>
                </td>
            </tr>
        </table>
    </form>
    <script>
        layui.use(['laydate','form'], function() {

            var laydate = layui.laydate;
            var form = layui.form;

            laydate.render({
                elem: '#Time'
                // ,format: 'yyyy年MM月dd日'
            });


            form.on('submit(sub)', function(data){
                var data = data.field;

                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/StudentScore/editReplyscore", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:data.field,
                    success: function(data){
                        document.getElementById("form1").reset();
                        layer.msg('修改成功！');
                    }
                });
                window.parent.location.reload();
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);//关闭当前页
            })
        })
    </script>
</body>

</html>