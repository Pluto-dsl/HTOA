<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/16
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传流程图</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
<button type="button" class="layui-btn" id="addFlow" style="margin-top: 10px;margin-left: 25px;" >
    <i class="layui-icon"></i> 上传流程图
</button>

<table id="demo"  lay-filter="test"></table>

<div  id="windows"  style="display: none;">
    <form method="post" class="layui-form" lay-filter="aaa" enctype="multipart/form-data" action="${pageContext.request.contextPath}/addFlow">

        <div class="layui-upload uploadbuchong" style="margin-top: 20px;margin-left: 60px;">
            <button type="button" class="layui-btn layui-btn-normal" id="test8" name="file">选择文件</button>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" id="test9" class="layui-btn" lay-submit="" lay-filter="sub" style="margin-left: 200px;">确定</button>
            </div>
        </div>
    </form>
</div>
</body>
<script type="text/html" id="barDemo">
    <a  class="layui-btn  layui-btn-xs" lay-event="download">下载流程图</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="sel">查看流程图</a>

</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var $ = layui.jquery
            ,upload = layui.upload;
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //执行渲染
        table.render({
            elem: '#demo', //指定原始表格元素选择器（推荐id选择器）
            height: 356, //容器高度
            title:'宿舍管理',
            url:"${pageContext.request.contextPath}/selFlow",
            cols: [[ //标题栏
                {field: 'ID_', title: '流程编号', width: 300, sort: true}
                ,{field: 'NAME_', title: '流程名称', width: 300}
                ,{field: 'KEY_', title: '流程KEY', width: 300}
                ,{fixed: 'right',  title:'操作', toolbar: '#barDemo',width:400}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            if(obj.event ==='download'){
                location.href = '${pageContext.request.contextPath}/toExport?id='+data.ID_;
            }else if(obj.event ==='sel'){
                location.href = '${pageContext.request.contextPath}/viewProcessImage?did='+data.DEPLOYMENT_ID_+'&imageName='+data.DGRM_RESOURCE_NAME_;
            }
        });

        $("#addFlow").click(function () {
            layer.open({
                type: 1,
                title:'上传文件',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['400px', '200px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: true, //开启遮罩关闭
                content: $('#windows')
            })
        });

        <!--文件上传-->
        //选完文件后不自动上传
        upload.render({
            elem: '#test8'
            ,auto: false//非自动上传
            ,accept:'file'
        });

    })
</script>
</html>
