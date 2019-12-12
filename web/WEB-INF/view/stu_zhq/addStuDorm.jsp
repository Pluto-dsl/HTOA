<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/11
  Time: 8:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加宿舍</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
<!--添加弹出窗-->
<form class="layui-form" action="'${pageContext.request.contextPath}/addDorm">
    <div class="layui-form-item">
        <label class="layui-form-label">宿舍楼栋：</label>
        <div class="layui-input-block">
            <select name="floorId" lay-filter="parentId">
                <c:forEach items="${list}" var="l">
                    <option value="${l.floorId}">${l.floorName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">宿舍房号：</label>
        <div class="layui-input-inline">
            <input type="text" name="huorName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">床位数：</label>
        <div class="layui-input-inline">
            <input type="text" name="numberBeds" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">宿舍地址：</label>
        <div class="layui-input-inline">
            <input type="text" name="addr" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
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
                url: "${pageContext.request.contextPath}/addDorm",
                type: "post",
                async:true,
                dataType: "json",
                data:{
                    floorId:fd.floorId,
                    huorName:fd.huorName,
                    addr:fd.addr,
                    count:0,
                    numberBeds:fd.numberBeds,
                    huoeIddsc:0
                },
                success: function (data) {
                    layer.msg('添加成功',{
                        time:1000//设置等待时间
                    },function () {
                        window.parent.location.reload();
                    });
                },
                error:function () {
                    layer.msg('添加失败');
                }
            });
            return false;
        });

    });
</script>
</html>
