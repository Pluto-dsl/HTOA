<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/4
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../include.jsp"/>
<head>
    <title>员工展示页</title>
</head>
<body>
    <a class="layui-btn layui-btn-primary layui-btn-xs layui-icon-add-1" lay-event="detail" href="<%=request.getContextPath()%>/zero/toaddemp">新增</a>
    <table id="demo" lay-filter="test"></table>
    <script type="text/html" id="pwd">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">重置密码</a>
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '<%=request.getContextPath()%>/zero/allemp' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'empId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'empName', title: '员工姓名', width:100}
                ,{field: 'depName', title: '部门', width:100, sort: true}
                ,{field: 'postName', title: '职务', width:160}
                ,{field: 'Sex', title: '性别', width:80}
                ,{field: 'Phone', title: '手机号码', width: 150, sort: true}
                ,{field: 'Address', title: '家庭地址', width: 200, sort: true}
                ,{field: 'status', title: '状态', width: 80,templet:'#state'}
                ,{field: 'reset', title: '初始密码',toolbar:'#pwd',width: 100}
                ,{field: 'caozuo', title: '操作',toolbar:'#barDemo', width: 200}/*
                ,{field: '',toolbar:'#add', width: 200,align:'center'}*/
            ]]
            ,done: function(res, page, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //分类显示中文名称
                $("[data-field='status']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("启用")
                    }else if($(this).text()=='0'){
                        $(this).text("禁用")
                    }
                })
            }
        });

    });

</script>
</html>
