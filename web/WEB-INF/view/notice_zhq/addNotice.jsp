<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/17
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发布通告</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <!--添加弹出窗-->
    <form class="layui-form" action="'${pageContext.request.contextPath}/addNotice">
        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">标题：</label>
            <div class="layui-input-block">
                <input type="text" name="title" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类别：</label>
            <div class="layui-input-inline">
                <select name="noticeType" lay-filter="parentId">
                    <option value="1" selected>全体学生</option>
                    <option value="2">全体员工</option>
                    <option value="0">所有员工学生</option>
                </select>
            </div>
        </div>

        <textarea id="demo" name="content" style="display: none;"></textarea>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="sub">发布</button>
                <button type="" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','layedit'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var layedit =layui.layedit;

        layedit.build('demo'); //建立编辑器

    })
</script>
</html>
