<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/10
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生列表</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="setDorm">调整宿舍</button>
        <button class="layui-btn layui-btn-sm" lay-event="setClass">调整班级</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">设置毕业</button>
        <lable>

        </lable>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="tuixue">退学</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="chongzhi">重置密码</a>
</script>


<script src="//res.layui.com/layui/dist/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/student/returnData'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'Studid', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'stuname', title:'学生姓名', width:120, edit: 'text'}
                ,{field:'sex', title:'性别', width:80, edit: 'text'}
                ,{field:'middleschool', title:'毕业学校', width:100}
                ,{field:'birthday', title:'生日'}
                ,{field:'phone', title:'学生电话', width:80}
                ,{field:'addr', title:'家庭住址', width:120}
                ,{field:'clazz', title:'所在班级', width:100}
                ,{field:'cardid', title:'身份证号', width:160}
                ,{field:'huor', title:'宿舍房号', width:120}
                ,{field:'stat', title:'学生状态', width:120}
                ,{field:'computer', title:'是否送电脑',width:120}
                ,{field:'collar', title:'是否领用电脑', width:120}
                ,{field:'grants', title:'享受助学金', width:120}
                ,{field:'parents', title:'家长姓名', width:120}
                ,{field:'parentsphone', title:'家长电话', width:120}
                ,{field:'qkMoney', title:'欠款金额', width:120}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:240}
            ]]
            ,page: true
            ,done: function(res, page, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //分类显示中文名称
                $("[data-field='stat']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("在读学生")
                    }else if($(this).text()=='0'){
                        $(this).text("毕业生")
                    }
                })
            }
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
                });
            } else if(obj.event === 'edit'){

            }else if(obj.event === 'tuixue'){

            }else if(obj.event === 'chongzhi'){

            }
        });
    });
</script>
</body>
</html>
