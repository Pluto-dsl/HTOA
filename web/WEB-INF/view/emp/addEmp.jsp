<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/4
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增员工</title>
    <jsp:include page="../include.jsp"/>
</head>
<style>
    .layui-form-select{
        width: 200px;
    }
</style>
<body>
<center>
    <h1>新增员工资料</h1>
    <form  class="layui-form layui-form-pane"  accept-charset="UTF-8" οnsubmit="document.charset='UTF-8'"  action="<%=request.getContextPath()%>/zeroEmp/addemp" method="post">
        <table style="height: 370px;width: 800px;margin-top: 10px;border-collapse:separate; border-spacing:10px;" border="0" >
            <tr style="height: 40px">
                <td align="right">员工姓名:</td>
                <td align="left">
                    <input maxlength="10" class="layui-input" lay-verify="required"  id="empName" name="empName" placeholder="请输入员工姓名"
                           value="" style="width:200px;float: left">
                    <font style="color: red;float: left;margin-top: 5px">&nbsp;*必填</font>
                </td>
                <td align="right">部门名称:</td>
                <td align="left">
                    <select id="depId" name="depId" lay-verify="required" style="float: left;width:50px;">
                        <c:forEach var="d" items="${dep}">
                            <option value="${d.depid}">${d.depName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr  style="height: 40px">
                <td align="right">职务名称:</td>
                <td align="left">
                    <select id="post" name="postId" lay-verify="required" style="float: left;width:50px;">
                        <c:forEach var="p" items="${post}">
                            <option value="${p.postId}">${p.postName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td align="right">家庭地址:</td>
                <td align="left">
                    <input type="text" maxlength="20"  class="layui-input" lay-verify="required" name="address" id="address" value="" placeholder="请输入家庭地址"  style="float: left;width:200px;">
                    <font style="color: red;float: left;margin-top: 5px">&nbsp;*必填</font>
                </td>
            </tr>
            <tr style="height: 40px">
                <td align="right">性别:</td>
                <td align="left">
                        <input type="radio" name="sex" value="男" title="男" checked>
                        <input type="radio" name="sex" value="女" title="女">
                </td>
                <td align="right">身份证号:</td>
                <td align="left">
                    <input lay-verify="required|identity" type="text" class="layui-input" id="cardNo"  name="cardNo" value=""placeholder="请输入身份证号" style="float: left;width:200px;">
                    <font style="color: red;float: left;margin-top: 5px">&nbsp;*必填</font>
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">出生日期:</td>
                <td align="left">
                    <input autocomplete="off" lay-verify="required|date" class="layui-input" type="text" id="birthday" name="birthday" value="" placeholder="请选择出生日期"  style="float: left;width:200px;">
                    <%--<input class="layui-input" type="button"  onclick="hqbirthday();" value="获取日期" style="height: 33px;width: 60px;">--%>
                    <font style="color: red;float: left;margin-top: 5px">&nbsp;*必填</font>
                </td>
                <td align="right">籍贯:</td>
                <td align="left">
                    <input placeholder="请输入籍贯" maxlength="20" class="layui-input" type="text" id="nation" name="nation" value=""   style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">手机号码:</td>
                <td align="left">
                    <input lay-verify="required|phone" onchange="judgePhone()" class="layui-input" type="text" id="phone" name="phone" value="" placeholder="请输入手机号"  style="float: left;width:200px;">
                    <font style="color: red;float: left;margin-top: 5px">&nbsp;*必填</font>
                </td>
                <td align="right">QQ号码:</td>
                <td align="left">
                    <input class="layui-input" maxlength="13" onkeyup="value=value.replace(/\D/g,'')" onafterpaste="value=value.replace(/\D/g,'')" type="text" id="qqCode"  name="qqCode" value=""placeholder="请输入QQ号码" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">微信号码:</td>
                <td align="left">
                    <input class="layui-input" maxlength="20" type="text" id="weixin" name="weixin" value="" placeholder="请输入微信号码"  style="width:200px;">
                </td>
                <td align="right">邮箱地址:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input" lay-verify="email" type="text" id="email"  name="email" value="" placeholder="请输入邮箱地址" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">婚姻状况:</td>
                <td align="left">
                    <select  id="married" name="married"  style="width:205px;" >
                        <option value="" >--未选择--</option>
                        <option value="已婚" >已婚</option>
                        <option value="单身" >单身</option>
                        <option value="离异" >离异</option>
                        <option value="丧偶" >丧偶</option>
                    </select>
                </td>
                <td align="right">毕业学校:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input" type="text" id="university"  name="university" value=""placeholder="请输入毕业学校" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">入职日期:</td>
                <td align="left">
                    <input placeholder="请输选择入职日期" autocomplete="off" type="text"  lay-verify="required" class="layui-input" id="joindate" style="float: left;width: 200px">
                    <font style="color: red;float: left;margin-top: 5px">&nbsp;*必填</font>
                </td>
                <td align="right">学历:</td>
                <td align="left">
                    <select id="education" name="education" name="married" name="depId" style="width:150px">
                        <option value="" >--未选择--</option>
                        <option value="高中以下" >高中以下</option>
                        <option value="专科" >专科</option>
                        <option value="本科" >本科</option>
                        <option value="本科以上" >本科以上</option>
                    </select>
                </td>
            </tr>


            <tr style="height: 40px">
                <td align="right">开户银行:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input" type="text" id="bank"  name="bank" value="" placeholder="请输入开户银行" style="width:200px;">
                </td>
                <td align="right">账户名称:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input" type="text" id="accountName"  name="accountName" value="" placeholder="请输入账户名称" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">银行账号:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input"  onkeyup="value=value.replace(/\D/g,'')" onafterpaste="value=value.replace(/\D/g,'')" type="text" id="bankNumber"  name="bankNumber" value="" placeholder="请输入银行账号" style="width:200px;">
                </td>
                <td align="right">支付宝号:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input" type="text" id="alipay"  name="alipay" value="" placeholder="请输入支付宝账号" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">专业:</td>
                <td align="left">
                    <input maxlength="20" class="layui-input" type="text" id="major"  name="major" value=""placeholder="请输入专业" style="width:200px;">
                </td>
                <td align="right">登录密码:</td>
                <td align="left">
                    <input type="text" class="layui-input" disabled placeholder="默认密码为123456" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">说明:</td>
                <td align="left" colspan="3">
                    <textarea maxlength="100" name="remark"  placeholder="请输入说明" class="layui-textarea"style="width:500px; height: 60px;"></textarea>
                </td>
            </tr>
            <tr style="height:90px">
                <td>
                </td>
                <td>
                    <center> <button type="submit" class="layui-btn layui-btn-normal layui-btn-radius" lay-submit="">保 存</button>
                    </center>
                </td>
                <td align="left">
                    <a href="javascript:void(0);"onclick="exit()">
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-radius">返 回</button>
                    </a>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </form>
</center>
</body>
<script>
    //加载表单控件
    layui.use('form', function(){
        var form = layui.form;
        form.render();
    });
    //日期
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#joindate' //指定元素
        });
        laydate.render({
            elem: '#birthday' //指定元素
        });
    });
    function exit() {//返回员工资料页
        window.location.href="<%=request.getContextPath()%>/zeroEmp/toemp";
    }

    function judgePhone() {
        var phone = $("#phone").val();
        $.post("<%=request.getContextPath()%>/student/judgePhone",{iphone:phone},function (data) {
            if(data=="1"){
                $("#phone").val("");
                layer.msg("已有此号码，请重新输入！")
            }
        },"text")
    }
</script>
</html>

<%--
        //重载数据表格
        table.reload('test',{  });

        //表初始化
        var createTable = function () {
            table.init('EditListTable', tableOptions);
        };
        //表刷新方法
        var reloadTable = function (item) {
            table.reload("listReload", { //此处是上文提到的 初始化标识id
                where: {
                    //key: { //该写法上文已经提到
                        type: item.type, id: item.id
                    //}
                }
            });
        };


--%>
