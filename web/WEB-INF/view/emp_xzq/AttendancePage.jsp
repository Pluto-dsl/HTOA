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
<%--未打卡弹出层--%>
<div id="windows1" style="margin-left: 5%;display:none;">
    <form id="Wfrom" class="layui-form" action="${pageContext.request.contextPath}/jack/Attadd" method="post" >
        <br><br>
        未打卡日期：<div style="margin-right:10px" class="layui-inline">
        <input type="text" name="punckClockTime" class="layui-input" id="clockDate">
    </div>
        时间点:
        <div class="layui-input-inline">
            <select name="timeing" lay-filter="type">
                <option value="8:00">8:00</option>
                <option value="14:00">14:00</option>
                <option value="17:00">17:00</option>
                <option value="21:00">21:00</option>
            </select>
        </div>
        <br><br>说明原因:<input type="text" name="cause" required lay-verify="required" placeholder="请输入说明原因" autocomplete="off" class="layui-input">
        <br><br><br><button style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
    </form>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table>

<%--表格头部按钮--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="punching" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-add-1" style="font-size: 30px;"></i>未打卡说明</button>
        <button lay-event="MyApproval"  class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-notice" style="font-size: 30px;"></i>我的审批</button>
    </div>
</script>

<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#clockDate' //指定元素
        });

        //考勤列表
        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/jack/Att'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'attId', title:'编号', width:80, fixed: 'left', unresize:true,sort: true}
                ,{field:'empName', title:'员工姓名', width:120}
                //日期转换
                ,{field:'punckClockTime',templet:'<div>{{layui.util.toDateString(d.punckClockTime,"yyyy-MM-dd HH:mm:ss")}}</div>', title:'打卡时间', width:200, }
                ,{field:'cause', title:'原因说明', width:120}
                ,{field:'auditor', title:'审核人', width:100}
                ,{field:'examineTime',templet:'', title:'审核时间' ,width:200}
                ,{field:'examineExplain', title:'审核说明', width:120}
                ,{field:'state',templet:function (d) {
                        if (d.state === 1) {
                            return '通过审核'
                        }else if(d.state === 2) {
                            return '待审核'
                        }else if(d.state === 3){
                            return '申请失败'
                        }
                    },title:'状态', width:120}
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

        //未打卡说明、我的审核
        table.on('toolbar(test)', function(obj){
            var data = obj.data;
            if(obj.event == 'punching'){
                layer.open({
                type: 1,
                title:'未打卡说明',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['700px', '450px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: false, //开启遮罩关闭
                //content: ['${pageContext.request.contextPath}/jack/test','no']
                content: $('#windows1'),
                cancel: function(index, layero){
                        $("#Wfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        return false;
                    }
                });
            }else if(obj.event == 'MyApproval'){
                layer.open({
                    type: 1,
                    title:'我的审核',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['800px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/xxx','no']
                    // content: $('#windows2')
                });
            }
        });
    });
</script>
</body>
</html>
