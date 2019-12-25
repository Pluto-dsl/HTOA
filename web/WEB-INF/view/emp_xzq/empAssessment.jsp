<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/10
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
    <style>
        .layui-form-label{
            padding: 9px 0px;
        }
        .layui-form-item{
            margin-top: 15px;
            margin-bottom: 5px;
        }
        .layui-form-item .layui-inline {
            margin-bottom: -5px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="layui-form-item">

        <div class="layui-inline ">
            <form class="layui-form">
                <label class="layui-form-label">员工姓名:</label>
                <div class="layui-input-inline">
                    <input type="text" id="empName" placeholder="请输入员工姓名搜索" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label">部门名称:</label>
                <div class="layui-input-inline">
                    <select id="dep" lay-verify="type">
                        <option value="">请选择部门</option>
                    </select>
                </div>
                <label class="layui-form-label">开始日期:</label>
                <div class="layui-input-inline">
                        <input type="text" autocomplete="off" class="layui-input" id="startDate">
                </div>

                <label class="layui-form-label">结束日期:</label>
                <div class="layui-input-inline">
                        <input type="text" autocomplete="off" class="layui-input" id="EndDate">
                </div>
            </form>
            <div style="float: right;position: absolute;width: 100px;" class="layui-input-inline">
                <button lay-event="search" id="search" style="float: right;" class="layui-btn layui-btn layui-btn-warm"><i class="layui-icon layui-icon-search"></i>搜索</button>
            </div>
        </div>

    </div>

    <table class="layui-hide" id="AduitLoglist" lay-filter="AduitLoglist"></table>
</body>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="batchDel" class="layui-btn layui-btn-sm layui-btn-danger" ><i class="layui-icon layui-icon-prev" style="font-size: 30px;"></i>批量删除</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-normal" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</button>
    <button class="layui-btn layui-btn-xs layui-btn layui-btn-danger" lay-event="sel"><i class="layui-icon layui-icon-edit"></i>图片及详情预览</button>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        // var date = new Date();
        // var EndDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate(); //获取当天的下一天
        // date.setDate(1);
        // var startDate = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate(); //获取当月的第一天


        //执行一个laydate实例
        laydate.render({
            elem: '#startDate', //指定元素
            //value:startDate
        });

        laydate.render({
            elem: '#EndDate', //指定元素
           //value:EndDate
        });

        //查询部门列表
        $.get('${pageContext.request.contextPath}/jack/depList',{},function (datas) {
            for (var i = 0; i < datas.Names.length; i++) {
                $("#dep").append("<option value='"+datas.Names[i].depid+"'>"+datas.Names[i].depName+"</option>");
            }
            form.render("select");
        },'json');

        //员工考核列表
        table.render({
            elem: '#AduitLoglist'
            ,url:'${pageContext.request.contextPath}/jack/AduitLogList'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,skin:'nob'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'aduitLogid', title:'编号', width:80,unresize:true,sort: true}
                ,{field:'aduitName', title:'考核内容', width:200}
                ,{field:'empName', title:'员工', width:150}
                ,{field:'Scores', title:'考核分数  ', width:100}
                ,{field:'auditDate', title:'考核时间 ',templet : "<div>{{layui.util.toDateString(d.auditDate, 'yyyy年MM月dd日')}}</div>" , width:150}
                ,{field:'auditPerson', title:'录入人员', width:120}
                ,{field:'Remark', title:'说明', width:200}
                ,{title:'操作',toolbar:'#barDemo',fixed: 'right',width:250}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]

        });

        //搜索
        $("#search").on("click",function () {
            var empName = $("#empName").val();
            var dep = $("#dep").val();
            var startDate = $("#startDate").val();
            var EndDate = $("#EndDate").val();
            table.render({
                elem: '#AduitLoglist'
                ,url:'${pageContext.request.contextPath}/jack/searchSel?empName='+empName+'&dep='+dep+'&startDate='+startDate+'&EndDate='+EndDate
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                ,title: '用户数据表'
                ,skin:'nob'
                ,cols: [[
                    {type: 'checkbox', fixed: 'left'}
                    ,{field:'aduitLogid', title:'编号', width:80,unresize:true,sort: true}
                    ,{field:'aduitName', title:'考核内容', width:200}
                    ,{field:'empName', title:'员工', width:150}
                    ,{field:'Scores', title:'考核分数  ', width:100}
                    ,{field:'auditDate', title:'考核时间 ',templet : "<div>{{layui.util.toDateString(d.auditDate, 'yyyy年MM月dd日')}}</div>" , width:150}
                    ,{field:'auditPerson', title:'录入人员', width:120}
                    ,{field:'Remark', title:'说明', width:200}
                    ,{title:'操作',toolbar:'#barDemo',width:250}
                ]]
                ,page: true
                ,limit:15
                ,limits: [15, 20, 30, 40, 50]

            });
        });

        table.on('toolbar(AduitLoglist)',function (obj) {
            var checkStatus = table.checkStatus('AduitLoglist');
            //批量删除
            if(obj.event === 'batchDel'){
                var ids = [];
                $(checkStatus.data).each(function (i, o) {//o即为表格中一行的数据
                    ids.push(o.aduitLogid);
                });
                console.log(JSON.stringify(ids));
                if (ids.length < 1) {
                    layer.msg('无选中项');
                    return false;
                }
                layer.confirm('真的删除行么', function(index){
                    for(var a= 0;a<ids.length;a++){
                        $.get("${pageContext.request.contextPath}/jack/delAduitLog?type=duo&cid="+ids[a],function (d) {
                            layer.msg('删除成功');
                            window.location.reload();
                        });
                    }
                    window.location.reload();
                    layer.close(index);
                });
            }
        });

        table.on('tool(AduitLoglist)',function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                var cid = data.aduitLogid;
                layer.confirm('真的删除行么', function(index){
                    $.get("${pageContext.request.contextPath}/jack/delAduitLog?cid="+cid,function (d) {
                        if(d > 0){
                            layer.msg('删除成功');
                            window.location.reload();
                        }else if (d === null){
                            layer.msg('删除失败');
                            window.location.reload();
                        }
                    });
                    window.location.reload();
                    layer.close(index);
                });
            }else if(obj.event === 'sel'){
                layer.open({
                    type:2,
                    title:'考核详情',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['1000px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/toSelAduitLog?aduitLogid='+data.aduitLogid,'no'],
                    cancel: function(index, layero){
                        layer.close(index);
                        return false;
                    }
                });
            }
        })

    });
</script>
</html>
