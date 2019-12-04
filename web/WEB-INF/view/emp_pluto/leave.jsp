<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/4
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工请假页面</title>
    <jsp:include page="../include.jsp" />
</head>
<body>

<table class="layui-hide" id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    layui.config({
        version: '1575404972583' //为了更新 js 缓存，可忽略
    });

    layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function(){
        var laypage = layui.laypage //分页
            ,layer = layui.layer //弹层
            ,table = layui.table //表格

        //分页
        laypage.render({
            elem: 'pageDemo' //分页容器的id
            ,count: 100 //总页数
            ,skin: '#1E9FFF' //自定义选中色值
            //,skip: true //开启跳页
            ,jump: function(obj, first){
                if(!first){
                    layer.msg('第'+ obj.curr +'页', {offset: 'b'});
                }
            }
        });

        //执行一个 table 实例
        table.render({
            elem: '#demo'
            ,height: 420
            ,url: '${pageContext.request.contextPath}/empLeave/returnData' //数据接口
            ,title: '用户表'
            ,page: true //开启分页
            ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            ,totalRow: true //开启合计行
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'holidayid', title: 'ID', width:80, sort: true, fixed: 'left', totalRowText: '合计：'}
                ,{field: 'Empid', title: '请假人', width:80}
                ,{field: 'holidayDay', title: '请假时长', width: 90, sort: true, totalRow: true}
                ,{field: 'startTime', title: '开始时间', width:80, sort: true}
                ,{field: 'endTime', title: '结束时间', width: 80, sort: true, totalRow: true}
                ,{field: 'status', title: '状态', width: 200}
                ,{field: 'Remark', title: '内容', width: 100}
                ,{fixed: '', width: 165, align:'center', toolbar: '#barDemo'}
            ]]
        });

        //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    layer.msg('添加');
                    break;
                case 'update':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        layer.alert('编辑 [id]：'+ checkStatus.data[0].id);
                    }
                    break;
                case 'delete':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else {
                        layer.msg('删除');
                    }
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.msg('查看操作');
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                });
            } else if(layEvent === 'edit'){
                layer.msg('编辑操作');
            }
        });

        //底部信息
        var footerTpl = lay('#footer')[0].innerHTML;
        lay('#footer').html(layui.laytpl(footerTpl).render({}))
            .removeClass('layui-hide');
    });
</script>
</body>
</html>
