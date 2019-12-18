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
    <title>通知公告</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <button type="button" class="layui-btn" id="addNotice" style="margin-left: 25px;margin-top: 10px;" >
        <i class="layui-icon"></i> 添加
    </button>
    <table id="demo"  lay-filter="test"></table>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
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
            url:"${pageContext.request.contextPath}/selNotice",
            cols: [[ //标题栏
                {field: 'noticeId', title: '编号', width: 100, sort: true}
                ,{field: 'title', title: '标题', width: 300}
                ,{field: 'noticeType', title: '类别', width: 100}
                ,{field: 'empid', title: '发布人', width: 150}
                ,{field: 'noticeTime', title: '发布时间', width: 300}
               /* ,{field: 'count', title: '已读人数', width: 150}
                ,{field: 'addr', title: '未读人数', width: 150}*/
                ,{fixed: 'right',  title:'操作', toolbar: '#barDemo',width:300}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        <!--添加-->
        $("#addNotice").click(function () {
            layer.open({
                title:"发布公告",
                type:2,
                content:['${pageContext.request.contextPath}/toAddNotice'],
                area:['700','550'],
                resize:false
            })
        })
    })
</script>
</html>
