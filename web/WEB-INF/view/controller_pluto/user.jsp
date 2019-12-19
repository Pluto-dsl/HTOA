<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/18
  Time: 15:22
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
    <title>权限管理</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
        </div>
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑权限</a>
        <a class="layui-btn layui-btn-xs" lay-event="shouquan">用户授权</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <div style="width: 100%;height: 100%">
        <table class="layui-hide" id="quanxian" lay-filter="quanxian"></table>
    </div>

    <script>
        layui.use('table', function(){
            var table = layui.table;

            table.render({
                elem: '#quanxian'
                ,url:'${pageContext.request.contextPath}/controller/getUserData'
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,title: '用户数据表'
                ,cellMinWidth: 80
                ,cols: [[
                    {type: 'radio', fixed: 'left'}
                    ,{field:'characterId', title:'ID',  fixed: 'left', unresize: true, sort: true}
                    ,{field:'characterName', title:'角色名'}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo',width:250}
                ]]
                ,page: true
            });

            //头工具栏事件
            table.on('toolbar(quanxian)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'add':
                        // var data = checkStatus.data;
                        layer.open({
                            type: 2,
                            title: '新增学生',
                            shadeClose: true,
                            shade: 0.4,
                            shadeclose:true,
                            area: ['450px', '250px'],
                            content: '${pageContext.request.contextPath}/controller/toAddUser' //iframe的url
                        });

                        break;
                };
            });

            //监听行工具事件
            table.on('tool(quanxian)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'del'){
                    layer.confirm('真的删除行么', function(index){
                        $.post("${pageContext.request.contextPath}/controller/delUser",{id:data.characterId},function (data) {
                            table.reload('quanxian');
                            layer.msg('删除成功！')
                        },"text");

                    });
                }else if(obj.event === 'exit'){

                }else if(obj.event === 'shouquan'){

                }
            });
        });
    </script>
</body>
</html>