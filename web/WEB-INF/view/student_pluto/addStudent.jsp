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
<form  id="form1" class="layui-form" action="${pageContext.request.contextPath}/student/addStu" <%--onSubmit="return beforeSubmit(this);"--%> method="post">
    <div >
        <center>
            <table id="td" border="0" style="border-collapse:separate; border-spacing:20px;" >
                <input type="hidden" name="Studid" id="stuId" value="0"/>
                <input type="hidden" name="password" value="123456"/>
                <input type="hidden" name="stat" value="4"/>
                <input type="hidden" name="prolevel" value="0"/>
                <input type="hidden" name="studytype" value="0"/>
                <input type="hidden" name="qkMoney" value="0.00"/>
                <input type="hidden" name="score" value="0.00"/>
                <input type="hidden" name="sourceType" value="普通生源"/>
                <input type="hidden" name="soldier" value="否"/>
                <input type="hidden" name="zhuxiao" value="否"/>
                <input type="hidden" name="tuixue" value="否"/>
                <input type="hidden" name="xiuxue" value="否"/>
                <%--            <input type="hidden" name="stuno" value="否"/>--%>
                <input type="hidden" name="computer" value="否"/>
                <input type="hidden" name="collar" value="否"/>
                <input type="hidden" name="grants" value="否"/>
                <input type="hidden" name="professional" value=""/>

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
                        <input class="layui-input" lay-verify="required" lay-verify="stuname" maxlength="10"  value="" autocomplete="off" name="stuname" id="stuname"
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
                               onchange="judgeIdentity()"
                               maxlength="18"
                               autocomplete="off"
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
                        <input class="layui-input" value=""  maxlength="3"  id="age" name="age"
                               style="width:290px;">
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td>
                        <label class="label-top">出&nbsp;生&nbsp;日&nbsp;期:</label>
                    </td>
                    <td>
                        <input class="layui-input" type="text" placeholder="请选择出生日期" value="" autocomplete="off" name="birt" id="birt"
                               editable="false"  style="width:290px;">
                    </td>
                    <td>
                        <label class="label-top">学生电话:</label>
                    </td>
                    <td>
                        <input class="layui-input" lay-verify="required|phone" onchange="judgePhone(),judgeParen(this)" autocomplete="off" value="" name="phone" id="phone"
                               style="width:290px;">
                    </td>
                </tr>
                <tr style="height: 40px">

                    <td>
                        <label class="label-top">入学时间:</label>
                    </td>
                    <td>
                        <input class="layui-input" type="text" value="" placeholder="请选择入学时间" autocomplete="off" name="ents" id="ents"
                               editable="false"  style="width:290px;">
                    </td>
                    <td>
                        <label class="label-top">老&nbsp;师&nbsp;电&nbsp;话:</label>
                    </td>
                    <td>
                        <input  name="intrphone" lay-verify="phone" id="intrphone" onchange="judgeTeacherParen(this)" value="" class="layui-input"
                                style="width:290px;">
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td>
                        <label class="label-top">添&nbsp;加&nbsp;宿&nbsp;舍:</label>
                    </td>
                    <td>
                        <select class="layui-form-label" name="huor" id="hour" editable="false" value="1" ditable="false" style="width:290px;">
                            <c:forEach items="${hList}" var="ss" >
                                <option value="${ss.hourid}" <c:if test="${s.huor == ss.hourid}">selected="selected"</c:if>>${ss.huorName}</option>
                            </c:forEach>
                        </select>
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
                        <input  name="nation" id="nation"  maxlength="5"  value="" class="layui-input"
                                style="width:290px;">
                    </td>
                    <td>
                        <label class="label-top">籍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贯:</label>
                    </td>
                    <td>
                        <input  name="natives" id="natives"  maxlength="10"  class="layui-input" value="" editable="false"
                                style="width:190px;">
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
                        <label class="label-top">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
                    </td>
                    <td>
                        <input  name="stuno" id="stuno" lay-verify="number" <%--placeholder="学号将自动生成"--%> maxlength="20"  autocomplete="off" value="" class="layui-input"
                                style="width:290px;">
                    </td>
                    <input type="hidden" name="studytype" value="1">
                </tr >
                <tr style="height: 40px">
                    <td>
                        <label class="label-top">家&nbsp;长&nbsp;姓&nbsp;名:</label>
                    </td>
                    <td>
                        <input name="parents" id="parents"  maxlength="5"  autocomplete="off" class="layui-input" value=""
                               style="width:290px;">
                    </td>
                    <td>
                        <label class="label-top">家长电话:</label>
                    </td>
                    <td>
                        <input class="layui-input" onchange="judgeParen(this)" autocomplete="off" lay-verify="phone" placeholder="  请输入家长电话" name="parentsphone" id="parentsphone" value=""
                               style="width:290px;">
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td>
                        <input type="hidden" name="isvocational" value="1">
                        <label class="label-top">中&nbsp;专&nbsp;学&nbsp;籍:</label>
                    </td>
                    <td>
                        <select class="layui-form-label" name="vocationalflag" id="vocationalflag" editable="false" value="1" ditable="false"
                                style="width:290px;">
                            <option value="1" selected="selected">已退</option>
                            <option value="2">保留</option>
                        </select>
                    </td>
<%--                    <td>--%>
<%--                        <label class="label-top">省录取号:</label>--%>
<%--                    </td>--%>
<%--                    <td>--%>
<%--                        <input  name="enrollno" id="enrollno" lay-verify="number" maxlength="20" onchange="judgeEnr()" autocomplete="off" class="layui-input" value="0"--%>
<%--                                style="width:290px;">--%>
<%--                    </td>--%>
                    <input type="hidden" name="enrollno" value="0"/>
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
                </tr>
                <tr style="height: 40px">
                    <td>
                        <label class="label-top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:</label>
                    </td>
                    <td>
                        <input  name="remark" autocomplete="off"  maxlength="50"  id="remark" value="" class="layui-input"
                                style="width:290px;">
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td colspan="4">
                        <center>
<%--                            <button type="submit" class="layui-btn layui-btn-normal">提交</button>--%>
                            <button class="layui-btn" id="submit" lay-submit lay-filter="sub">保存</button>

                        </center>
                    </td>
                </tr>
            </table>
        </center>
    </div>
</form>
</body>
<script>
    layui.use(['laydate','form'], function() {
        var laydate = layui.laydate;
        var form = layui.form;

        var day2 = new Date();
        day2.setTime(day2.getTime());
        var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();

        //自定义格式
        laydate.render({
            elem: '#ents'
            ,max:s2
            // ,format: 'yyyy年MM月dd日'
        });
        laydate.render({
            elem: '#birt'
            ,max:s2
            // ,format: 'yyyy年MM月dd日'
        });

        form.on('submit(sub)', function(data){
            console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            // return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });


        <%--//新增教育背景--%>
        <%--form.on('submit(sub)', function(data){--%>

        <%--    &lt;%&ndash;$.ajax({&ndash;%&gt;--%>
        <%--    &lt;%&ndash;    type: 'post',&ndash;%&gt;--%>
        <%--    &lt;%&ndash;    url: "${pageContext.request.contextPath}/student/addStu", // ajax请求路径&ndash;%&gt;--%>
        <%--    &lt;%&ndash;    dataType: "text",&ndash;%&gt;--%>
        <%--    &lt;%&ndash;    data:data.field,&ndash;%&gt;--%>
        <%--    &lt;%&ndash;    success: function(data){&ndash;%&gt;--%>
        <%--    &lt;%&ndash;        document.getElementById("form1").reset();&ndash;%&gt;--%>
        <%--    &lt;%&ndash;    }&ndash;%&gt;--%>
        <%--    &lt;%&ndash;});&ndash;%&gt;--%>
        <%--    document.getElementById("form1").reset();--%>
        <%--    window.parent.location.reload();--%>
        <%--    let index = parent.layer.getFrameIndex(window.name);--%>
        <%--    parent.layer.close(index);--%>
        <%--    //关闭当前页--%>
        <%--})--%>

    })

    function judgePhone() {
        var phone = $("#phone").val();
        $.post("<%=request.getContextPath()%>/student/judgePhone",{iphone:phone},function (data) {
            if(data=="1"){
                $("#phone").val("");
                layer.msg("此号码已存在，请重新输入！")
            }
        },"text")
    }


    function judgeParen(obj) {
        var stu = $("#phone").val();
        var prent = $("#parentsphone").val();
        var teacherPhone = $("#intrphone").val()
        if(stu==prent || stu==teacherPhone){
            layer.msg("学生号码不可跟家长或老师号码相同！");
            $(obj).val("");
        }
    }

    function judgeTeacherParen(obj) {
        var stu = $("#phone").val();
        var teacherPhone = $("#intrphone").val()
        if(stu==teacherPhone){
            layer.msg("老师号码不可跟学生号码相同！");
            $(obj).val("");
        }
    }

    function judgeIdentity() {
        var cardid = $("#cardid").val();
        $.post("<%=request.getContextPath()%>/student/judgeCardid",{cid:cardid},function (data) {
            if(data=="0"){
                $("#cardid").val("");
                layer.msg("此身份证号已存在，请重新输入！")
            }
        },"text")

    }

    // function beforeSubmit(form) {
    //     var stuname = form.stuname.value;
    //     var cardid = form.cardid.value;
    //     var stuname = form.stuname.value;
    //     var stuname = form.stuname.value;
    //     var stuname = form.stuname.value;
    //
    // }
</script>
<%--<script>--%>
<%--    document.getElementById("form1").reset();--%>
<%--    window.parent.location.reload();--%>
<%--    let index = parent.layer.getFrameIndex(window.name);--%>
<%--    parent.layer.close(index);--%>
<%--</script>--%>
</html>