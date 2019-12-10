
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/8
  Time: 20:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>维修管理</title>
    <jsp:include page="${pageContext.request.contextPath}/toPage/include"/>
</head>
<body>

<table id="repair" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="delChatRecordList">删除所选数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="newChatRecord">新增谈心记录</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</body>
<script>
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#repair'
            ,url:'${pageContext.request.contextPath}/logs/getRepairData'
            ,title: '维修管理'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'chatId', title:'ID', width:60, fixed: 'left', unresize: true, sort: true}

            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'newChatRecord':
                    layer.open({
                        type: 1,
                        title:'添加谈心记录',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //是否显示关闭按钮
                        area: ['700px', '420px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: false, //是否点击遮罩时关闭
                        content: $('#windows'),
                        cancel: function(index, layero){
                            $("#MyForm")[0].reset();
                            layui.form.render();
                            layer.close(index);
                            return false;
                        }
                    });
                    break;
                case 'delChatRecordList':
                    var data = checkStatus.data;
                    var msg = "是要删除ID为：";
                    $(data).each(function (index,elemnt) {
                        console.log(elemnt.chatId);
                        msg +=elemnt.chatId+"、";
                    });
                    msg = msg.substr(0,msg.length-1);
                    msg +="的记录吗?";
                    layer.confirm(msg, {
                        btn: ['是的','取消'] //按钮
                    }, function(){
                        $(data).each(function (index,elemnt) {
                            delChatRecord(elemnt.chatId)
                        });
                    }, function(){

                    });
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                    delChatRecord(obj.data.chatid)
                });
            } else if(obj.event === 'edit'){
                console.log(data);
                //重置表单数据
                $("#MyForm")[0].reset();
                layui.form.render();
                //为表单赋值
                $("#chatId").val(data.chatId);
                $("#chatDate").val(data.chatDate);
                $("#addr").val(data.addr);
                $("#sayscon").val(data.sayscon);
                $("#teacher").children().each(function (index,element) {
                    if ($(element).text() === data.teacher) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });

                $("#sayface").children().each(function (index,element) {
                    if ($(element).text() === data.sayface) {
                        $(element).attr("selected","selected");
                    }else {
                        $(element).removeAttr("selected")
                    }
                });

                //重新渲染表单
                layui.use('form', function() {
                    var element = layui.form;
                    element.render();
                });

                //打开窗口
                layer.open({
                    type: 1,
                    title:'添加谈心记录',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //是否显示关闭按钮
                    area: ['700px', '420px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //是否点击遮罩时关闭
                    content: $('#windows'),
                    cancel: function(index, layero){//点击关闭按钮时触发
                        //重置表单数据
                        $("#MyForm")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        return false;
                    }
                });
            }
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#chatDate' //指定元素
            ,format:'yyyy/MM/dd'
        });
    });
</script>
<script>
    function delChatRecord(id) {
        var data = {id:id};
        $.post("${pageContext.request.contextPath}/ljw/delChatRecord",data,function (data) {
            console.log(data)
        },"json");
    }
</script>
</html>