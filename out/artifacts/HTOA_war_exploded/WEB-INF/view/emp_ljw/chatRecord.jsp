<%--
  Created by IntelliJ IDEA.
  User: norman
  Date: 2019/12/4
  Time: 11:20
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
    <title>谈心记录</title>
    <jsp:include page="${pageContext.request.contextPath}/toPage/include"/>
</head>
<body>
    <table id="chatRecordList" lay-filter="test"></table>
    <div id="test1"></div>

    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm">删除所选数据</button>
            <button class="layui-btn layui-btn-sm">新增谈心记录</button>
        </div>
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
</body>
<script>
    $.post("");
    layui.use('table', function(){
        var table = layui.table;
        table.render({
            elem: '#chatRecordList'
            ,url:'${pageContext.request.contextPath}/ljw/getChatRecordData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print']
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'chatid', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'sayface', title:'学生', width:80, fixed: 'left'}
                ,{field:'teacher', title:'员工', width:80, fixed: 'left'}
                ,{field:'addr', title:'地址', width:80, fixed: 'left'}
                ,{field:'sayscon', title:'谈心内容',width: '56%', minWidth: 200, fixed: 'left'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:200}
            ]]
            ,page: {limit:5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                    console.log(obj.data.chatid);
                    delChatRecord(obj.data.chatid)
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        });
    });
</script>
<script language="JavaScript">
    function delChatRecord(id) {
        var data = {id:id};
        $.post("${pageContext.request.contextPath}/ljw/delChatRecord",data,function (data) {
            console.log(data)
        },"json");
    }
</script>
</html>