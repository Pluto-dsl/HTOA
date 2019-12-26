<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/14
  Time: 18:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增学生</title>
    <jsp:include page="../include.jsp"/>
    <style>
        input{
            width: 320px;
        }
    </style>
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/student/updateStu" id="form1" method="post">
        <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" align="center">
            <input type="hidden" name="Studid" id="stuId" value="${s.studid}"/>
            <input type="hidden" name="password" value="${s.password}"/>
            <input type="hidden" name="oldss" value="${s.huor}"/>
            <tr>
                <th colspan="4">
                    <font style="font-size: 25px;">
                        修改学生信息
                    </font>
                </th>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">学&nbsp;生&nbsp;姓&nbsp;名:</label>

                </td>
                <td>
                    <input class="layui-input" maxlength="10"  lay-verify="required" value="${s.stuname}" autocomplete="off" name="stuname" id="stuname"
                           style="width:290px;">
                </td>
                <td>
                    <label class="label-top">身份证号:</label>
                </td>
                <td>
                    <input class="textbox layui-input"
                           lay-verify="required|identity"
                           name="cardid" id="cardid"
                           value="${s.cardid}"
                           autocomplete="off"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">担&nbsp;&nbsp;&nbsp;&nbsp;保&nbsp;&nbsp;&nbsp;人:</label>
                </td>
                <td>
                    <input  name="guarantee"  maxlength="10"  id="guarantee" value="${s.guarantee}" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">毕业学校:</label>
                </td>
                <td>
                    <input  name="middleschool"  maxlength="20"  value="${s.guarantee}" id="middleschool" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;:</label>
                </td>
                <td>
                    <select class="layui-form-label"  id="sex" editable="false" name="sex" style="width:290px;">
                        <option value="男" <c:if test="${s.sex == '男'}">selected="selected"</c:if>>男</option>
                        <option value="女" <c:if test="${s.sex == '女'}">selected="selected"</c:if>>女</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄:</label>
                </td>
                <td>
                    <input class="layui-input"  maxlength="3"  value="${s.age}" id="age" name="age"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">出&nbsp;生&nbsp;日&nbsp;期:</label>
                </td>
                <td>
                    <input class="layui-input" type="text" placeholder="请选择出生日期" value="${s.birthday}" autocomplete="off" name="bir" id="birthday"
                           editable="false"  style="width:290px;">
                </td>
                <td>
                    <label class="label-top">学生电话:</label>
                </td>
                <td>
                    <input class="layui-input" lay-verify="required|phone" autocomplete="off" value="${s.phone}" name="phone" id="phone"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">家&nbsp;庭&nbsp;地&nbsp;址:</label>
                </td>
                <td>
                    <input  name="addr" id="addr"  maxlength="20" value="${s.addr}" class="layui-input" autocomplete="off"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">入学时间:</label>
                    <%--                    <input type="text" class="layui-input" id="test1" placeholder="yyyy-MM-dd">--%>
                </td>
                <td>
                    <input class="layui-input" type="text" value="${s.entertime}" placeholder="请选择入学时间" autocomplete="off" name="ent" id="entertime"
                           editable="false"  style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">介&nbsp;绍&nbsp;老&nbsp;师:</label>
                </td>
                <td>
                    <input  name="introduretech" maxlength="10"  id="introduretech" value="${s.introduretech}" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">户口性质:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="residence" value="" id="residence" editable="false"  ditable="false" style="width:290px;">
                        <option value="1" <c:if test="${s.residence == 1}">selected="selected"</c:if>>农村户口</option>
                        <option value="2" <c:if test="${s.residence == 2}">selected="selected"</c:if>>县镇户口</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族:</label>
                </td>
                <td>
                    <input  name="nation"  maxlength="5"  id="nation" value="${s.nation}" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯:</label>
                </td>
                <td>
                    <input  name="natives" id="natives"  maxlength="10" class="layui-input" value="${s.natives}" editable="false"
                            style="width:190px;">
                    <%--                    <button type="button" style="width: 100px;float: right;margin-top: -13%;" class="layui-btn layui-btn-primary">选择籍贯</button>--%>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">修&nbsp;改&nbsp;宿&nbsp;舍:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="huor" id="huor" editable="false" value="1" ditable="false" style="width:290px;">
                        <c:forEach items="${ssList}" var="ss" >
                            <option value="${ss.hourid}" <c:if test="${s.huor == ss.hourid}">selected="selected"</c:if>>${ss.huorName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label class="label-top">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="stat" id="stat" editable="false" value="1" ditable="false"
                            style="width:290px;">
<%--                        //    状态名称：1意向学生、2预定报名学生、3试学学生、4在读学生、5已毕业学生--%>
                        <option value="1" <c:if test="${s.stat == 1}">selected="selected"</c:if> >意向学生</option>
                        <option value="2" <c:if test="${s.stat == 2}">selected="selected"</c:if> >预定报名学生</option>
                        <option value="3" <c:if test="${s.stat == 3}">selected="selected"</c:if> >试学学生</option>
                        <option value="4" <c:if test="${s.stat == 4}">selected="selected"</c:if> >在读学生</option>
                        <option value="5" <c:if test="${s.stat == 5}">selected="selected"</c:if> >已毕业学生</option>
                        <option value="6" <c:if test="${s.stat == 5}">selected="selected"</c:if> >退学</option>
                    </select>
                </td>
            </tr >            <tr style="height: 40px">
                <td>
                    <label class="label-top">专&nbsp;业&nbsp;类&nbsp;别:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="prolevel" id="prolevel" editable="false" value="1" ditable="false" style="width:290px;">
                        <c:forEach items="${xList}" var="x">
                            <option value="${x.deptid}" <c:if test="${s.prolevel == x.deptid}">selected="selected"</c:if>>${x.deptName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label class="label-top">学习类别:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="studytype" id="studytype" editable="false" value="1" ditable="false"
                            style="width:290px;">
                        <option value="1" <c:if test="${s.studytype == 1}">selected="selected"</c:if>>全日制</option>
                        <option value="2" <c:if test="${s.studytype == 2}">selected="selected"</c:if>>非全日制</option>
                    </select>
                </td>
            </tr >
            <tr style="height: 40px">
                <td>
                    <label class="label-top">家&nbsp;长&nbsp;姓&nbsp;名:</label>
                </td>
                <td>
                    <input name="parents" id="parents"  maxlength="10"  autocomplete="off" class="layui-input" value="${s.parents}"
                           style="width:290px;">
                </td>
                <td>
                    <label class="label-top">家长电话:</label>
                </td>
                <td>
                    <input class="layui-input" autocomplete="off" lay-verify="required|phone" placeholder="  请输入家长电话" name="parentsphone" id="parentsphone" value="${s.parentsphone}"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">老&nbsp;师&nbsp;电&nbsp;话:</label>
                </td>
                <td>
                    <input  name="intrphone" lay-verify="phone" id="intrphone" value="${s.intrphone}" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">&nbsp;面&nbsp;试&nbsp;人&nbsp;:</label>
                </td>
                <td>
                    <input  name="audition"  maxlength="10"  id="audition" value="${s.audition}" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">是&nbsp;否&nbsp;中&nbsp;专:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="isvocational" id="isvocational" editable="false" value="1" ditable="false"
                            style="width:290px;">
                        <option value="1" <c:if test="${s.isvocational == 1}">selected="selected"</c:if>>是</option>
                        <option value="2" <c:if test="${s.isvocational == 2}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">中专学校:</label>
                </td>
                <td>
                    <input  name="vocationalsch"  maxlength="10"  autocomplete="off" id="vocationalsch" class="layui-input" value="${s.vocationalsch}"
                            style="width:290px;">
                </td>
            </tr>

            <ul>
                <li></li>
            </ul>

            <tr style="height: 40px">
                <td>
                    <label class="label-top">中&nbsp;专&nbsp;学&nbsp;籍:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="vocationalflag" id="vocationalflag" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="1" <c:if test="${s.vocationalflag == 1}">selected="selected"</c:if>>已退</option>
                        <option value="2" <c:if test="${s.vocationalflag == 2}">selected="selected"</c:if>>保留</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">省录取号:</label>
                </td>
                <td>
                    <input  name="enrollno"  maxlength="20"  id="enrollno" autocomplete="off" class="layui-input" value="${s.enrollno}"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">面试人意见:</label>
                </td>
                <td>
                    <select class="layui-input" name="auditionoption" id="auditionoption" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="同意" <c:if test="${s.auditionoption == '同意'}">selected="selected"</c:if>>同意</option>
                        <option value="拒绝" <c:if test="${s.auditionoption == '拒绝'}">selected="selected"</c:if>>拒绝</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
                </td>
                <td>
                    <input  name="stuno" id="stuno"  maxlength="20"  autocomplete="off" value="${s.stuno}" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">报&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;号:&nbsp;</label>
                </td>
                <td>
                    <input  name="registration"  maxlength="20"  autocomplete="off" id="registration" value="${s.registration}" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">低&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;保:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="dibao" id="dibao" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.dibao == '是'}">selected="selected"</c:if> >是</option>
                        <option value="否" <c:if test="${s.dibao == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
            </tr>
<%--            --------------------------------------%>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">是否住校:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="zhuxiao" id="zhuxiao" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.zhuxiao == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.zhuxiao == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">是否当兵:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="soldier" id="soldier" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.soldier == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.soldier == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
            </tr>

            <tr style="height: 40px">
                <td>
                    <label class="label-top">是否退学:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="tuixue" id="tuixue" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.tuixue == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.tuixue == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">是否休学:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="xiuxue" id="xiuxue" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.xiuxue == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.xiuxue == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
            </tr>

            <tr style="height: 40px">
                <td>
                    <label class="label-top">是否送电脑:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="computer" id="computer" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.computer == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.computer == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">是否领用电脑:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="collar" id="collar" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.collar == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.collar == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
            </tr>

            <tr style="height: 40px">
                <td>
                    <label class="label-top">助学金:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="grants" id="grants" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" <c:if test="${s.grants == '是'}">selected="selected"</c:if>>是</option>
                        <option value="否" <c:if test="${s.grants == '否'}">selected="selected"</c:if>>否</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">班&nbsp;级&nbsp;选&nbsp;择:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="clazz" id="clazz" editable="false"  ditable="false"
                            style="width:290px;">
                        <c:forEach items="${classList}" var="c">
                            <option value="${c.classId}" <c:if test="${s.clazz==c.classId}">selected="selected"</c:if>>${c.className}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
<%--            --------------------------------------%>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">就&nbsp;读&nbsp;专&nbsp;业:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="professional" id="professional" editable="false"  ditable="false"
                            style="width:290px;">
                        <c:forEach items="${zyList}" var="z">
                            <option value="${z.majorName}" <c:if test="${s.professional==z.majorName}">selected="selected"</c:if>>${z.majorName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label class="label-top">欠&nbsp;款&nbsp;金&nbsp;额&nbsp;:</label>
                </td>
                <td>
                    <input  name="qkMoney"  maxlength="10"  autocomplete="off" id="qkMoney" value="${s.qkMoney}" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</label>
                </td>
                <td>
                    <input  name="remark" maxlength="50"  autocomplete="off" id="remark" value="${s.remark}" class="layui-input"
                            style="width:290px;">
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
    <script>
        layui.use(['laydate','form'], function() {
            var laydate = layui.laydate;
            var form = layui.form;

            //自定义格式
            laydate.render({
                elem: '#entertime'
                // ,format: 'yyyy年MM月dd日'
            });
            laydate.render({
                elem: '#birthday'
                // ,format: 'yyyy年MM月dd日'
            });

            //新增教育背景
            form.on('submit(sub)', function(data){
                var data = data.field;
                console.log(data);

                $.each(data,function (index,elemnt) {
                    console.log(index)
                    console.log(elemnt);
                });

                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/student/updateStu", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:data.field,
                    success: function(data){
                        document.getElementById("form1").reset();
                    }
                });
                parent.location.reload();//刷新父页面，注意一定要在关闭当前iframe层之前执行刷新
                // window.parent.location.reload();
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);//关闭当前页
                // return false;
            })
        })
    </script>
</form>
</body>
</html>