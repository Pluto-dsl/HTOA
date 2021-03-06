<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/23
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<form id="addfrom" lay-filter="addfrom" action="${pageContext.request.contextPath}/jack/EditEnrollment" class="layui-form" method="post" >
    <table align="center" style="border-collapse: separate;border-spacing: 10px 30px;">
            <tr align="center">
                <input name="enrollmentid" type="hidden"/>
                <td>新生姓名:</td>
                <td><input type="text" name="studName" id="studName" required lay-verify="required" placeholder="请输入新生姓名" autocomplete="off" class="layui-input"/></td>
                <td>身份证:</td>
                <td><input type="text" name="card" id="card" required lay-verify="required" maxlength="18" placeholder="请输入身份证" autocomplete="off" class="layui-input"/></td>
            </tr>
            <tr align="center">
                <td>性别:</td>
                <td>
                    <input type="radio" name="sex" class="sex" value="男" title="男" checked="" />
                    <input type="radio" name="sex" class="sex" value="女" title="女" />
                </td>
                <td>手机号:</td>
                <td><input type="text" name="tell"  required lay-verify="required" maxlength="11" placeholder="请输入手机号" autocomplete="off" class="layui-input" /></td>
            </tr>
            <tr align="center">
                <td>QQ账号:</td>
                <td><input type="text" name="qq" placeholder="请输入QQ账号" autocomplete="off" class="layui-input" /></td>
                <td>就读学校:</td>
                <td><input type="text" name="school" required lay-verify="required" placeholder="请输入就读学校" autocomplete="off" class="layui-input" /></td>
            </tr>
            <tr align="center">
                <td>录取成绩:</td>
                <td><input type="text" name="score" id="score"  required lay-verify="number" placeholder="请输入录取成绩" autocomplete="off" class="layui-input" /></td>
                <td>学生备注:</td>
                <td><input type="text" name="remark" id="remark" placeholder="请输入学生备注" autocomplete="off" class="layui-input" /></td>
            </tr>
            <tr align="center">
                <td>学生专业:</td>
                <td>
                    <select id="majorId" name="majorId" lay-verify="required">
                        <option value="">选择学生专业</option>
                    </select>
                </td>
                <td>招生老师:</td>
                <td><input type="text" name="negativeName" id="negativeName"  required lay-verify="required" placeholder="请输入招生老师" autocomplete="off" class="layui-input"></td>
            </tr>
            <tr align="center">
                <td>学生入学状态:</td>
                <td>
                    <select id="status" name="status" lay-verify="required">
                        <option value="">选择学生状态</option>
                        <option value="1">意向学生</option>
                        <option value="2">预定报名学生</option>
                        <option value="3">试学学生</option>
                        <option value="4">在读学生</option>
                        <option value="6">退学</option>
                    </select>
                </td>
                <td>是否送电脑:</td>
                <td>
                    <input type="radio" name="computer" value="是" title="是" checked="">
                    <input type="radio" name="computer" value="否" title="否">
                </td>
            </tr>
            <tr align="center">
                <td colspan="4"> <button lay-submit lay-filter="Asubmit" id="Asubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button></td>
            </tr>

    </table>
    </form>
</body>
<script>
    var index;
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2

        $.ajaxSettings.async = false;

        //学生专业
        $.post('${pageContext.request.contextPath}/jack/toMajorList',{},function (data) {
            for (var i = 0; i < data.names.length; i++) {
                $("#majorId").append("<option value='"+data.names[i].majorid+"'>"+data.names[i].majorName+"</option>");
            }
            layer.close(index);
            form.render("select");
        },"json");

        $("#qq").on('click',function () {
            layer.tips('可不填', '.qq');
        });
        $("#remark").on('click',function () {
            layer.tips('可不填', '.remark');
        });

        form.on('submit(Asubmit)',function () {
        window.parent.location.reload();//刷新父页面
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.layer.close(index);
        });

        LoadData();
        function LoadData() {
            var aa = parent.xxx();
            form.val("addfrom", { //formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
                "studName": aa.studName // "name": "value"
                , "card": aa.card
                , "enrollmentid": aa.enrollmentid
                , "sex": aa.sex
                , "tell": aa.tell
                , "qq": aa.qq
                , "school": aa.school
                , "score": aa.score
                , "remark": aa.remark
                , "studType": aa.studType
                , "majorId": aa.majorId
                , "status": aa.status
                , "negativeName": aa.negativeName
                , "computer": aa.computer
            });
        }
    });
</script>
</html>
