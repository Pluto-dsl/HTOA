<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/4
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考勤管理</title>
    <jsp:include page="../include.jsp" />
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="punching" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-add-1" style="font-size: 30px;"></i>未打卡说明</button>
        <button lay-event="MyApproval"  class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-notice" style="font-size: 30px;"></i>我的审批</button>
    </div>
</script>

<script src="//res.layui.com/layui/dist/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/jack/Att'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'},
                {field:'attId', title:'编号', width:80, fixed: 'left', unresize:true,sort: true}
                ,{field:'empName', title:'员工姓名', width:120}
                ,{field:'punckClockTime',templet:'<div>{{ layui.util.toDateString(d.punckClockTime,"yyyy-MM-dd HH:mm:ss")}}</div>', title:'打卡时间', width:200, }
                ,{field:'cause', title:'原因说明', width:120}
                ,{field:'auditor', title:'审核人', width:100}
                ,{field:'examineTime',templet:'<div>{{ layui.util.toDateString(d.examineTime,"yyyy-MM-dd HH:mm:ss") }}</div>', title:'审核时间' ,width:200}
                ,{field:'examineExplain', title:'审核说明', width:120}
                ,{field:'state', title:'状态', width:120}
            ]]
            ,page: true
            ,limits: [5, 15, 20, 30, 40, 50]
            // ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            //     layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            //     //,curr: 1 //设定初始在第 1 页
            //     ,groups: 3 //只显示 1 个连续页码
            //     ,first: true //不显示首页
            //     ,last: true //不显示尾页
            // }

        });

        //头部工具按钮监听
        table.on('toolbar(test)', function(obj){
            var data = obj.data;
            if(obj.event == 'punching'){
                layer.open({
                    type: 1,
                    content: '传入任意的文本或html' //这里content是一个普通的String
                });
            }else if(obj.event == 'punching'){
                layer.open({
                    type: 1,
                    content: '传入任意的文本或html' //这里content是一个普通的String
                });
            }
        });
    });
</script>
</body>
</html>
