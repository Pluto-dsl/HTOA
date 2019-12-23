<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/23
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <table class="layui-hide" id="test" lay-filter="test"></table>
</body>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="addEnr" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-add-1" style="font-size: 30px;"></i>添加</button>
        <button lay-event="del" class="layui-btn layui-btn-sm layui-btn-danger" ><i class="layui-icon layui-icon-delete"></i>批量删除</button>
    </div>
</script>
<script type="text/html" id="toolDemo">

    <button lay-event="edit" class="layui-btn layui-btn-sm layui-btn-danger" ><i class="layui-icon layui-icon-edit"></i>编辑</button>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        //执行一个laydate实例
        laydate.render({
            elem: '#clockDate' //指定元素
        });

        //考勤列表
        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/jack/Enrollment'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'enrollmentid', title:'编号', width:80, fixed: 'left', unresize:true,sort: true}
                ,{field:'studName', title:'员工姓名', width:120}
                ,{field:'card', title:'员工姓名', width:120}
                ,{field:'sex', title:'员工姓名', width:120}
                ,{field:'tell', title:'员工姓名', width:120}
                ,{field:'qq', title:'员工姓名', width:120}
                ,{field:'school', title:'员工姓名', width:120}
                ,{field:'classes', title:'员工姓名', width:120}
                ,{field:'amount', title:'员工姓名', width:120}
                ,{field:'computer', title:'员工姓名', width:120}
                ,{field:'testTime', title:'员工姓名', width:120}
                ,{field:'startTime', title:'员工姓名', width:120}
                ,{field:'signdate', title:'员工姓名', width:120}
                ,{field:'empid', title:'员工姓名', width:120}
                ,{field:'status', title:'员工姓名', width:120}
                ,{field:'remark', title:'员工姓名', width:120}
                ,{field:'studType', title:'员工姓名', width:120}
                ,{field:'paymentTime', title:'员工姓名', width:120}
                ,{field:'score', title:'员工姓名', width:120}
                ,{field:'enrollMoney', title:'员工姓名', width:120}
                ,{field:'enrollMoneyTime', title:'员工姓名', width:120}
                ,{field:'reviewStatus', title:'员工姓名', width:120}
                ,{field:'negativeName', title:'员工姓名', width:120}
                ,{field:'reviewer', title:'员工姓名', width:120}
                ,{field:'reviewerTime', title:'员工姓名', width:120}
                ,{field:'majorId', title:'员工姓名', width:120}
                ,{toolbar:'#toolDemo',fixed: 'right', title:'操作', width:100}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 25, 35, 45, 55]
            // ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            //     layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            //     //,curr: 1 //设定初始在第 1 页
            //     ,groups: 3 //只显示 1 个连续页码
            //     ,first: true //不显示首页
            //     ,last: true //不显示尾页
            // }

        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            if(obj.event === 'del'){
                var cid = data.attId;
                layer.confirm('真的删除行么', function(index){
                    $.get("${pageContext.request.contextPath}/jack/delAtt?cid="+cid,function (d) {
                        if(d > 0){
                            layer.msg('删除成功');
                            table.reload('test');
                        }else if (d === null){
                            layer.msg('删除失败');
                            table.reload('test');
                        }
                        table.reload('test');
                    });
                    table.reload('test');
                    layer.close(index);
                });
            }
        });

        //未打卡说明、我的审核   监听表格头的按钮'toolbar(test)'
        table.on('toolbar(test)', function(obj){
            var data = obj.data;
            if(obj.event == 'punching'){
                layer.open({
                    type: 1,
                    title:'未打卡说明',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    //content: ['${pageContext.request.contextPath}/jack/test','no']
                    content: $('#windows1'),
                    cancel: function(index, layero){
                        $("#Wfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        table.reload('test');
                        return false;
                    }
                });
            }else if(obj.event == 'MyApproval'){
                layer.open({
                    type: 2,
                    title:'我的审核',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['1000px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/xxx','no'],
                    cancel: function(index, layero){
                        table.reload('test');
                    }
                });
            }
        });
    });
</script>
</html>
