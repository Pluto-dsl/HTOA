<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/12
  Time: 9:09
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
<form class="layui-form" action="${pageContext.request.contextPath}/student/addStu" id="form1" method="post">

    <center>
        <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" >
            <input type="hidden" name="Studid" id="stuId" value="0"/>
            <input type="hidden" name="password" value="123456"/>
            <input type="hidden" name="huor" value="0"/>
            <input type="hidden" name="stat" value="4"/>
            <input type="hidden" name="prolevel" value="0"/>
            <input type="hidden" name="studytype" value="0"/>
            <input type="hidden" name="qkMoney" value="0.00"/>
            <input type="hidden" name="score" value="0.0"/>
            <input type="hidden" name="sourceType" value="普通生源"/>
            <input type="hidden" name="soldier" value="否"/>
            <input type="hidden" name="zhuxiao" value="否"/>
            <input type="hidden" name="tuixue" value="否"/>
            <input type="hidden" name="xiuxue" value="否"/>
<%--            <input type="hidden" name="stuno" value="否"/>--%>
            <input type="hidden" name="computer" value="否"/>
            <input type="hidden" name="collar" value="否"/>
            <input type="hidden" name="grants" value="否"/>
            <input type="hidden" name="professional" value="2019"/>

            <tr>
                <th colspan="4">
                    <font style="font-size: 25px;">
                        新增学生
                    </font>
                </th>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">学&nbsp;生&nbsp;姓&nbsp;名:</label>

                </td>
                <td>
                    <input class="layui-input" lay-verify="required" value="" autocomplete="off" name="stuname" id="stuname"
                           style="width:290px;">
                </td>
                <td>
                    <label class="label-top">身份证号:</label>
                </td>
                <td>
                    <input class="textbox layui-input"
                           lay-verify="required"
                           name="cardid" id="cardid"
                           value=""
                           autocomplete="off"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">担&nbsp;&nbsp;&nbsp;&nbsp;保&nbsp;&nbsp;&nbsp;人:</label>
                </td>
                <td>
                    <input  name="guarantee" id="guarantee" value="" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">毕业学校:</label>
                </td>
                <td>
                    <input  name="middleschool" value="" id="middleschool" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别&nbsp;&nbsp;&nbsp;:</label>
                </td>
                <td>
                    <select class="layui-form-label"  id="sex" editable="false" name="sex" style="width:290px;">
                        <option value="男" selected="selected">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄:</label>
                </td>
                <td>
                    <input class="layui-input" value="" id="age" name="age"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">出&nbsp;生&nbsp;日&nbsp;期:</label>
                </td>
                <td>
                    <input class="layui-input" type="text" placeholder="请选择出生日期" value="" autocomplete="off" name="bir" id="birthday"
                           editable="false"  style="width:290px;">
                </td>
                <td>
                    <label class="label-top">学生电话:</label>
                </td>
                <td>
                    <input class="layui-input" lay-verify="required|phone" autocomplete="off" value="" name="phone" id="phone"
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">家&nbsp;庭&nbsp;地&nbsp;址:</label>
                </td>
                <td>
                    <input  name="addr" id="addr" value="" class="layui-input" autocomplete="off"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">入学时间:</label>
<%--                    <input type="text" class="layui-input" id="test1" placeholder="yyyy-MM-dd">--%>
                </td>
                <td>
                    <input class="layui-input" type="text" value="" placeholder="请选择入学时间" autocomplete="off" name="ent" id="entertime"
                           editable="false"  style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">介&nbsp;绍&nbsp;老&nbsp;师:</label>
                </td>
                <td>
                    <input  name="introduretech" id="introduretech" value="" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">户口性质:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="residence" value="" id="residence" editable="false"  ditable="false" style="width:290px;">
                        <option value="1" selected="selected">农村户口</option>
                        <option value="2" >县镇户口</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族:</label>
                </td>
                <td>
                    <input  name="nation" id="nation" value="" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯:</label>
                </td>
                <td>
                    <input  name="natives" id="natives" class="layui-input" value="" editable="false"
                            style="width:190px;">
<%--                    <button type="button" style="width: 100px;float: right;margin-top: -13%;" class="layui-btn layui-btn-primary">选择籍贯</button>--%>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">专&nbsp;业&nbsp;类&nbsp;别:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="prolevel" id="prolevel" editable="false" value="1" ditable="false" style="width:290px;">
                        <c:forEach items="${zyList}" var="z">
                            <option value="${z.majorid}">${z.majorName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label class="label-top">学习类别:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="studytype" id="studytype" editable="false" value="1" ditable="false"
                            style="width:290px;">
                        <option value="1" selected="selected">全日制</option>
                    </select>
                </td>
            </tr >
            <tr style="height: 40px">
                <td>
                    <label class="label-top">家&nbsp;长&nbsp;姓&nbsp;名:</label>
                </td>
                <td>
                    <input name="parents" id="parents" autocomplete="off" class="layui-input" value=""
                           style="width:290px;">
                </td>
                <td>
                    <label class="label-top">家长电话:</label>
                </td>
                <td>
                    <input class="layui-input" autocomplete="off" lay-verify="required|phone" placeholder="  请输入家长电话" name="parentsphone" id="parentsphone" value=""
                           style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">老&nbsp;师&nbsp;电&nbsp;话:</label>
                </td>
                <td>
                    <input  name="intrphone" lay-verify="phone" id="intrphone" value="" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">&nbsp;面&nbsp;试&nbsp;人&nbsp;:</label>
                </td>
                <td>
                    <input  name="audition"  id="audition" value="" class="layui-input"
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
                        <option value="1" selected="selected">是</option>
                        <option value="2">否</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">中专学校:</label>
                </td>
                <td>
                    <input  name="vocationalsch" autocomplete="off" id="vocationalsch" class="layui-input" value=""
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
                        <option value="1" selected="selected">已退</option>
                        <option value="2">保留</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">省录取号:</label>
                </td>
                <td>
                    <input  name="enrollno" id="enrollno" autocomplete="off" class="layui-input" value=""
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
                        <option value="同意" >同意</option>
                        <option value="拒绝" selected="selected">拒绝</option>
                    </select>
                </td>
                <td>
                    <label class="label-top">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
                </td>
                <td>
                    <input  name="stuno" id="stuno" autocomplete="off" value="" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">报&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;号:&nbsp;</label>
                </td>
                <td>
                    <input  name="registration" autocomplete="off" id="registration" value="" class="layui-input"
                            style="width:290px;">
                </td>
                <td>
                    <label class="label-top">低&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;保:</label>
                </td>
                <td>
                    <select class="layui-form-label" name="dibao" id="dibao" editable="false" value="" ditable="false"
                            style="width:290px;">
                        <option value="是" >是</option>
                        <option value="否" selected="selected">否</option>
                    </select>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    <label class="label-top">班&nbsp;级&nbsp;选&nbsp;择:&nbsp;</label>
                </td>
                <td>
                    <select class="layui-form-label" name="clazz" id="clazz" editable="false"  ditable="false"
                            style="width:290px;">
                        <c:forEach items="${classList}" var="c">
                            <option value="${c.classId}">${c.className}</option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label class="label-top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</label>
                </td>
                <td>
                    <input  name="remark" autocomplete="off" id="remark" value="" class="layui-input"
                            style="width:290px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td colspan="4">
                    <center>
                        <button class="layui-btn" id="submit" lay-submit lay-filter="sub">立即提交</button>
                    </center>
                </td>
            </tr>
        </table>
    </center>
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
                    url: "${pageContext.request.contextPath}/student/addStu", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:data.field,
                    success: function(data){
                        document.getElementById("form1").reset();
                    }
                });
                window.parent.location.reload();
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);//关闭当前页
            })
        })
    </script>
</form>
</body>
</html>
