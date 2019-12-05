<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/html" id="top">
        <form class="layui-form layui-form-pane"  accept-charset="UTF-8" οnsubmit="document.charset='UTF-8'"  action="<%=request.getContextPath()%>/zero/seek" method="post">
            部门名称:
            <select id="depId" name="depId" lay-verify="required" style="width:205px;">
                <c:forEach var="d" items="${dep}">
                    <option value="${d.depid}">${d.depName}</option>
                </c:forEach>
            </select>
            员工姓名:
            <input class="layui-input" name="empName" value="" style="width:200px;">
            手机号码:
            <input class="layui-input"  name="Phone" value="" style="width:200px;">
            状态:
            <select  name="status" lay-verify="required" style="width:205px;">
                <option value="100">--未选择--</option>
                <option value="1">启用</option>
                <option value="0">禁用</option>
            </select>
        </form>
        <a class="layui-btn layui-btn-primary layui-btn-xs layui-icon-add-1" lay-event="detail" href="<%=request.getContextPath()%>/zero/toaddemp">新增</a>
    </script>
    <table id="demo" lay-filter="test"></table>
    <script type="text/html" id="shezhi">
        <input checked="true" type="checkbox" id="state" lay-skin="switch" lay-text="启用|禁用"/>
    </script>
    <script type="text/html" id="pwd">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">重置密码</a>
    </script>
    <script type="text/html" id="barDemo">
        <%--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>--%>
        <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
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
            ,toolbar: '#top' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'empId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'empName', title: '员工姓名', width:100}
                ,{field: 'depName', title: '部门', width:100}
                ,{field: 'postName', title: '职务', width:160}
                ,{field: 'Sex', title: '性别', width:80,sort: true}
                ,{field: 'Phone', title: '手机号码', width: 150}
                ,{field: 'Address', title: '家庭地址', width: 200}
                //,{field: 'status', title: '状态', width: 80}
                ,{field: 'status', title: '设置状态', width: 100,toolbar:'#shezhi'}
                ,{field: 'reset', title: '初始密码',toolbar:'#pwd',width: 100}
                ,{field: 'caozuo', title: '操作',toolbar:'#barDemo', width: 150}
            ]]
            ,page: {limit:10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
            ,done: function(res, page, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //分类显示中文名称
                $("[data-field='status']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("启用")
                        $("#state").attr("checked",true);
                    }else if($(this).text()=='0'){
                        $(this).text("禁用")
                        $("#state").attr("checked",false);
                    }
                })
            }
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象

            if(layEvent === 'detail'){ //重置密码
                //layer.msg('查看');
                layer.confirm('确定重置此用户的密码吗?', function(index){
                    //向服务端发送修改指令
                    layer.close(index);
                    $.post("<%=request.getContextPath()%>/zero/resetPwd/"+data.empId,{},function (d) {
                    },"text")
                });
            } else if(layEvent === 'del'){ //删除
                layer.confirm('真的删除此条数据吗?', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    //向服务端发送删除指令
                    $.post("<%=request.getContextPath()%>/zero/deleteEmp",{empId:data.empId},function (d) {
                    },"text")
                });
            } else if(layEvent === 'edit'){ //修改
                //layer.msg('编辑');
                //同步更新缓存对应的值
                /*obj.update({
                    username: '123'
                    ,title: 'xxx'
                });*/
                window.location.href="<%=request.getContextPath()%>/zero/toupdate/"+data.empId;
            }
        });
    });


</script>
</html>
