<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/10
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <table class="layui-hide" id="AduitLoglist" lay-filter="AduitLoglist"></table>
</body>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-normal" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</button>
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-danger" lay-event="sel"><i class="layui-icon layui-icon-edit"></i>图片及详情预览</button>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        //员工考核列表
        table.render({
            elem: '#AduitLoglist'
            ,url:'${pageContext.request.contextPath}/jack/AduitLogList'
            ,toolbar: '#toolbarT' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'aduitLogid', title:'编号', width:80,unresize:true,sort: true}
                ,{field:'aduitName', title:'考核内容', width:200}
                ,{field:'empName', title:'员工', width:150}
                ,{field:'Scores', title:'考核分数  ', width:100}
                ,{field:'auditDate', title:'考核时间 ',templet : "<div>{{layui.util.toDateString(d.auditDate, 'yyyy年MM月dd日')}}</div>" , width:150}
                ,{field:'auditPerson', title:'录入人员', width:120}
                ,{field:'Remark', title:'说明', width:200}
                ,{title:'操作',toolbar:'#barDemo',width:250}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]

        });

        table.on('tool(AduitLoglist)',function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                var cid = data.aduitLogid;
                layer.confirm('真的删除行么', function(index){
                    $.get("${pageContext.request.contextPath}/jack/delCourse?cid="+cid,function (d) {
                        if(d > 0){
                            layer.msg('删除成功');
                            table.reload('AduitLoglist');
                        }else if (d === null){
                            layer.msg('删除失败');
                            table.reload('AduitLoglist');
                        }
                    });
                    layer.close(index);
                });
            }else if(obj.event === 'sel'){
                layer.open({
                    type:2,
                    title:'考核详情',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '400px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/toSelAduitLog?aduitLogid='+data.aduitLogid,'no'],
                    cancel: function(index, layero){
                        layer.close(index);
                        return false;
                    }
                });
            }
        })

    });
</script>
</html>
