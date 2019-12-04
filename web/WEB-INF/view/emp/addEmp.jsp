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
<body>
<center>
    <form name="form1" id="form1"  action="/htoffice/admin/emp/save">
        <table style="height: 370px;width: 700px;margin-top: 10px" border="0">
            <input type="hidden" id="empId" name="empId" value=""/>
            <tr style="height: 40px">
                <td align="right">员工姓名:</td>
                <td align="left"><input id="empName" name="empName" placeholder="请输入员工姓名"
                                        value="" style="width:200px;"></td>
                <td align="right">部门名称:</td>
                <td align="left">
                    <select  id="depId" name="depId"  style="width:205px;" >
                        <option value="1">宏图软件</option>
                        <option value="2">教研部</option>
                        <option value="11">行政部</option>
                        <option value="12">后勤部</option>
                        <option value="13">学工部</option>
                        <option value="14">招生部</option>
                        <option value="20">赣州地区</option>
                        <option value="21">招生2部</option>
                        <option value="22">社招部1</option>
                        <option value="23">社招部2</option>
                        <option value="24">财务部</option>
                    </select>
                </td>
            </tr>
            <tr  style="height: 40px">
                <td align="right">职务名称:</td>
                <td align="left">
                    <input type="text"  name="postName" id="postName" value="" placeholder="请输入职务名称" style="width:200px;">
                </td>
                <td align="right">家庭地址:</td>
                <td align="left">
                    <input type="text"  name="address" id="address" value="" placeholder="请输入家庭地址"  style="width:200px;">
                </td>
            </tr>
            <tr style="height: 40px">
                <td align="right">性别:</td>
                <td align="left">
                    <select  id="sex" name="sex"    style="width:205px;">
                        <option value="男" >男</option>
                        <option value="女" >女</option>
                    </select>
                </td>
                <td align="right">身份证号:</td>
                <td align="left">
                    <input type="text" id="cardNo"  name="cardNo" value=""placeholder="请输入身份证号" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">出生日期:</td>
                <td align="left">
                    <input type="text" id="birthday" name="birthday" value="" placeholder="可根据身份证号获取出生日期"  style="width:140px;">
                    <input type="button"  onclick="hqbirthday();" value="获取日期" style="height: 33px;width: 60px;">
                </td>
                <td align="right">籍贯:</td>
                <td align="left">
                    <input  type="text" id="nation" name="nation" value=""   style="width:140px;">
                    <input type="button"  onclick="addcity();" value="选择籍贯" style="height: 33px;width: 60px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">手机号码:</td>
                <td align="left">
                    <input type="text" id="phone" name="phone" value="" placeholder="请输入手机号"  style="width:200px;">
                </td>
                <td align="right">QQ号码:</td>
                <td align="left">
                    <input type="text" id="qqCode"  name="qqCode" value=""placeholder="请输入QQ号码" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">微信号码:</td>
                <td align="left">
                    <input type="text" id="weixin" name="weixin" value="" placeholder="请输入微信号码"  style="width:200px;">
                </td>
                <td align="right">邮箱地址:</td>
                <td align="left">
                    <input type="text" id="email"  name="email" value=""placeholder="请输入邮箱地址" style="width:200px;">
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
                    <input type="text" id="university"  name="university" value=""placeholder="请输入毕业学校" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">专业:</td>
                <td align="left">
                    <input type="text" id="major"  name="major" value=""placeholder="请输入专业" style="width:200px;">
                </td>
                <td align="right">学历:</td>
                <td align="left">
                    <select  id="education" name="education"   style="width:205px;">
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
                    <input type="text" id="bank"  name="bank" value=""placeholder="请输入开户银行" style="width:200px;">
                </td>
                <td align="right">账户名称:</td>
                <td align="left">
                    <input type="text" id="accountName"  name="accountName" value=""placeholder="请输入账户名称" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">银行账号:</td>
                <td align="left">
                    <input type="text" id="bankNumber"  name="bankNumber" value=""placeholder="请输入银行账号" style="width:200px;">
                </td>
                <td align="right">支付宝号:</td>
                <td align="left">
                    <input type="text" id="alipay"  name="alipay" value=""placeholder="请输入支付宝账号" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">入职日期:</td>
                <td align="left">
                    <input class="easyui-datebox" id="hireDay"  name="hireDay" value="" editable="false"  style="width:200px;">
                </td>
                <td align="right">登录密码:</td>
                <td align="left">
                    <input type="text" disabled placeholder="默认密码为123456" style="width:200px;">
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right">说明:</td>
                <td align="left" colspan="3">
                    <textarea  id="remark"  name="remark" placeholder="请输入说明" style="width:500px; height: 60px;"></textarea>
                </td>
            </tr>

            <tr style="height: 40px">
                <td align="right" colspan="2">
                    <a class="easyui-linkbutton" icon="icon-save"  plain="true" href="javascript:void(0);"
                       onclick="saveEmp();">保 存</a>
                    <a class="easyui-linkbutton" icon="icon-undo"  plain="true" href="javascript:void(0);"
                       onclick="exit();">返 回</a>
            </tr>
        </table>
    </form>
</center>
<div class="easyui-window" title="选择籍贯" id="editBx" style="width: 320px; height: 245px;" mode="true" closed="true" modal="true"
     href="/htoffice/admin/emp/cityAdd" >
</div>
</body>
</html>
