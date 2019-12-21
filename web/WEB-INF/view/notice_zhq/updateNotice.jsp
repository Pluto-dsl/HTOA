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

    <form class="layui-form"  lay-filter="update" <%--method="post" action="${pageContext.request.contextPath}/toUpdateNotice"--%>>
        <input type="hidden" id="noticeId" name="noticeId" value="${notice.noticeId}">
        <input type="hidden" id="noticeType" name="noticeType" value="${notice.noticeType}">
        <input type="hidden" id="empid" name="empid" value="${notice.empid}">
        <input type="hidden" id="noticeTime" name="noticeTime" value="${notice.noticeTime}">
        <input type="hidden" id="trueContent" name="trueContent" value="${notice.trueContent}">
        <input type="hidden" id="falseContent" name="falseContent"value="${notice.falseContent}">
        <div class="layui-form-item" style="width: 500px;">
            <label class="layui-form-label">标题：</label>
            <div class="layui-input-block">
                <input type="text" name="title"id="title" value="${notice.title}" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
            </div>
        </div>

        <textarea id="demo" name="noticeContent"  style="display: none;">${notice.content}</textarea>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit lay-filter="sub">确定</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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

        var cor = layedit.build('demo'); //建立编辑器


        form.on('submit(sub)',function(data){
            //发异步，把数据提交给后台
            $.ajax({
                url:'${pageContext.request.contextPath}/zhq/toUpdateNotice',
                type:'post',
                data:{
                    noticeId:$('#noticeId').val(),
                    empid:$('#empid').val(),
                    time:$('#noticeTime').val(),
                    trueContent:$('#trueContent').val(),
                    falseContent:$('#falseContent').val(),
                    title:$('#title').val(),
                    content:layedit.getContent(cor),
                    noticeType:$('#noticeType').val()
                },
                dataType:'json',
                success:function (data){
                    var index = parent.layer.getFrameIndex(window.name);
                    //关闭当前frame
                    parent.layer.close(index);
                    setTimeout(function () {
                        window.parent.location.reload(); //修改成功后刷新父界面
                    });
                },
                error:function () {
                    var index = parent.layer.getFrameIndex(window.name);
                    //关闭当前frame
                    parent.layer.close(index);
                    setTimeout(function () {
                        window.parent.location.reload(); //修改成功后刷新父界面
                    });
                }
            });
            return false;
        });
    })
</script>
</html>
