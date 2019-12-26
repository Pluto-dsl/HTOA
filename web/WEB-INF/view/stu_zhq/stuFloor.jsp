<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/9
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>楼栋管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <button type="button" class="layui-btn" id="add1" style="margin-left: 25px;" >
        <i class="layui-icon"></i> 添加
    </button>
    <table id="demo2"  lay-filter="test"></table>

    <!--弹出窗-->
    <div  id="windows"  style="margin-left: 5%;display: none;">
        <form class="layui-form" method="post" action="${pageContext.request.contextPath}/zhq/addStuFloor" lay-filter="example" style="margin-right: 100px;margin-top: 35px;" >
            <div class="layui-form-item">
                <label class="layui-form-label">楼栋名称</label>
                <div  class="layui-input-block">
                    <input id="floorName" type="text" name="floorName" required lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="sub">保存</button>
                    <button type="button" class="layui-btn" lay-submit="" lay-filter="demo1">重置</button>
                </div>
            </div>
        </form>
    </div>
</body>
    <script>
        layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
            var element = layui.element;
            var layer = layui.layer;
            var table = layui.table;
            var form = layui.form;
            var laydate = layui.laydate;

            //执行渲染
            table.render({
                elem: '#demo2', //指定原始表格元素选择器（推荐id选择器）
                height: 'auto', //容器高度
                title:'楼栋管理',
                url:"${pageContext.request.contextPath}/zhq/selFloor",
                cols: [[ //标题栏
                    {field: 'floorId', title: '楼栋ID', width: 500, sort: true}
                    ,{field: 'floorName', title: '楼栋名称', width: 500}
                    ,{fixed: 'right',  title:'操作', toolbar: '#barDemo',width:200}
                ]]
                ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
            });

            table.on('tool(test)',function (obj) {
                var data = obj.date;
                console.log(data);
                if(obj.event ==='del'){
                    layer.confirm('真的删除行么', function(index){
                        $.ajax({
                            url:"${pageContext.request.contextPath}/zhq/deleteStu",
                            type:"post",
                            data:{
                                floorId:obj.data.floorId
                            },
                            dataType:"json",
                            success: function (data){
                                if(data==1){
                                    obj.del();
                                    layer.close(index);
                                    layer.msg('删除成功');
                                    table.reload("demo2");
                                }
                                if(data==0){
                                    obj.del();
                                    layer.close(index);
                                    layer.msg('删除失败,该楼栋有宿舍，不能删哦！');
                                    table.reload("demo2");
                                }
                            }
                        })
                    });
                }
            });

        }),
        <!--添加部门-->
        $("#add1").click(function () {
            layer.open({
                type: 1,
                title:'部门管理',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['700px', '200px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: false, //开启遮罩关闭
                content: $('#windows')
            });
        });



    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
</html>
