<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/6
  Time: 19:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>

    <!--添加弹出窗-->
    <form class="layui-form" action="'${pageContext.request.contextPath}/addDep">
        <div class="layui-form-item">
            <label class="layui-form-label">部门名称：</label>
            <div class="layui-input-inline">
                <input type="text" name="deptName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">上级部门：</label>
            <div class="layui-input-block">
                <select name="parentId" lay-filter="parentId">
                    <c:forEach items="${depList}" var="dep">
                        <option value="${dep.depid}">${dep.depName}</option>
                    </c:forEach>
                </select>
        </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label" style="margin-right: -30px;left: -20px;width: 100px;">部门负责人：</label>
            <div class="layui-input-block">
                <select name="chairman" lay-filter="chairman">
                    <c:forEach items="${empList}" var="emp">
                        <option value="${emp.empName}">${emp.empName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">备注：</label>
            <div class="layui-input-block">
                <textarea name="remark" placeholder="请输入内容" lay-verify="required" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit="" lay-filter="sub">确定</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</body>
<script>

    layui.use(['form', 'layer'], function(){
        var form = layui.form
            ,layer = layui.layer;
        //监听提交
       form.on('submit(sub)', function(data){
            console.log(data.field);
            var fd = data.field;
            var lod = layer.load();
            //部门数据
            $.ajax({
                url: "${pageContext.request.contextPath}/addDep",
                type: "post",
                async:true,
                dataType: "json",
                data:{
                    depName:fd.deptName,
                    parentId:fd.parentId,
                    chairman:fd.chairman,
                    personnel:0,
                    remark:fd.remark
                },
                success: function (data) {
                    layer.msg('添加成功',{
                        time:1000//设置等待时间
                    },function () {
                        window.parent.location.reload();
                    });
                },
                error:function () {
                    layer.msg('添加成功',{
                        time:1000//设置等待时间
                    },function () {
                        window.parent.location.reload();
                    });
                }
            });
            return false;
        });

    });








    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
    })
</script>
</html>
