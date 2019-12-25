<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/23
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<form id="addfrom" action="${pageContext.request.contextPath}/jack/addEnrollment" class="layui-form" method="post" >
    <table align="center" style="border-collapse: separate;border-spacing: 10px 30px;">
            <tr align="center">
                <td>新生姓名:</td>
                <td><input type="text" name="studName" required lay-verify="required" placeholder="请输入新生姓名" autocomplete="off" class="layui-input"/></td>
                <td>身份证:</td>
                <td><input type="text" name="card" required lay-verify="identity" placeholder="请输入身份证" autocomplete="off" class="layui-input"/></td>
            </tr>
            <tr align="center">
                <td>性别:</td>
                <td>
                    <input type="radio" name="sex" value="男" title="男" checked="" />
                    <input type="radio" name="sex" value="女" title="女" />
                </td>
                <td>手机号:</td>
                <td><input type="text" name="tell" required lay-verify="phone" placeholder="请输入手机号" autocomplete="off" class="layui-input" /></td>
            </tr>
            <tr align="center">
                <td>QQ账号:</td>
                <td><input type="text" name="qq" id="qq" placeholder="请输入QQ账号" autocomplete="off" class="layui-input" /></td>
                <td>就读学校:</td>
                <td><input type="text" name="school" required lay-verify="required" placeholder="请输入身份证" autocomplete="off" class="layui-input" /></td>
            </tr>
            <tr align="center">
                <td>所在班级:</td>
                <td><input type="text" name="classes" required lay-verify="required" placeholder="请输入所在班级" autocomplete="off" class="layui-input" /></td>
                <td>录取成绩:</td>
                <td><input type="text" name="score" required lay-verify="number" placeholder="请输入录取成绩" autocomplete="off" class="layui-input" /></td>
            </tr>
            <tr align="center">
                <td>学生备注:</td>
                <td><input type="text" name="remark" id="remark" placeholder="请输入学生备注" autocomplete="off" class="layui-input" /></td>
                <td>班级类别:</td>
                <td>
                    <select id="studType" name="studType" lay-verify="required"/>
                        <option value="">选择班级类别</option>
                    </select>
                </td>
            </tr>
            <tr align="center">
                <td>学生专业:</td>
                <td>
                    <select id="majorId" name="majorId" lay-verify="required">
                        <option value="">选择学生专业</option>
                    </select>
                </td>
                <td>招生老师:</td>
                <td><input type="text" name="negativeName" required lay-verify="required" placeholder="请输入招生老师" autocomplete="off" class="layui-input"></td>
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
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        $("#qq").on('click',function () {
            layer.tips('可不填', '.qq');
        });
        $("#remark").on('click',function () {
            layer.tips('可不填', '.remark');
        });

        form.on('submit(Asubmit)',function () {
        window.parent.location.reload();//刷新父页面
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.table.reload('test');
        parent.layer.close(index);
        });

        //班级类别
        $.get('${pageContext.request.contextPath}/jack/toClassTypeList',{},function (data) {
            for (var i = 0; i < data.names.length; i++) {
                $("#studType").append("<option value='"+data.names[i].classTypeId+"'>"+data.names[i].classTypeName+"</option>");
            }
            form.render("select");
        },"json");

        //学生专业
        $.get('${pageContext.request.contextPath}/jack/toMajorList',{},function (data) {
            for (var i = 0; i < data.names.length; i++) {
                $("#majorId").append("<option value='"+data.names[i].majorid+"'>"+data.names[i].majorName+"</option>");
            }
            form.render("select");
        },"json");

    });
</script>
</html>
