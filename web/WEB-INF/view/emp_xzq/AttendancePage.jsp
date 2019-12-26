<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/4
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考勤管理</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<%--未打卡弹出层--%>
<div id="windows1" style="margin-left:11%;display:none;">
    <form id="Wfrom" class="layui-form" action="${pageContext.request.contextPath}/jack/Attadd" method="post" >
        <br><br>
        未打卡日期：<div style="margin-right:10px" class="layui-inline">
        <input type="text"  autocomplete="off" name="punckClockTime" class="layui-input" id="clockDate">
    </div>
        时间点:
        <div class="layui-input-inline">
            <select name="timeing" lay-verify="required">
                <option>请选择时间</option>
                <option value="8:00">8:00</option>
                <option value="14:00">14:00</option>
                <option value="17:00">17:00</option>
                <option value="21:00">21:00</option>
            </select>
        </div>
        <br><br>说明原因:<input type="text" name="cause" style="width: 75%" required lay-verify="required" placeholder="请输入说明原因" autocomplete="off" class="layui-input">
        <br><br><br><button style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
    </form>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table>

<%--表格头部按钮--%>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="punching" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-add-1" style="font-size: 30px;"></i>未打卡说明</button>
        <button lay-event="MyApproval" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-notice" style="font-size: 30px;"></i>我的审批</button>
    </div>
</script>
<script type="text/html" id="toolDemo">
    <button lay-event="del" class="layui-btn layui-btn-sm layui-btn-danger" ><i class="layui-icon layui-icon-delete"></i>删除</button>
</script>
<script type="text/javascript">
    function createTime(v){
        console.log(v);
        if(v == undefined || v ==''){
            return "";
        }else {
            var date = new Date(v);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? '0' + m : m;
            var d = date.getDate();
            d = d < 10 ? ("0" + d) : d;
            var h = date.getHours();
            h = h < 10 ? ("0" + h) : h;
            var M = date.getMinutes();
            M = M < 10 ? ("0" + M) : M;
            var str = y + "-" + m + "-" + d + " " + h + ":" + M;
            return str;
        }
    }
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

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
                ,{field:'examineTime',templet:function (d){return createTime(d.examineTime);},title:'审核时间' ,width:200}
                ,{field:'examineExplain', title:'审核说明', width:120}
                ,{field:'status',templet:function (d) {
                        if (d.status === 1) {
                            return '通过审核'
                        }else if(d.status === 2) {
                            return '待审核'
                        }else if(d.status === 3){
                            return '申请失败'
                        }
                    },title:'状态', width:120}
                ,{toolbar:'#toolDemo',fixed: 'right', title:'操作', width:100}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 25, 35, 45, 55]
            // ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            //     layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            //     //,curr: 1 //设定初始在第 1 页
            //     ,groups: 3 //只显示 1 个连续页码
            //     ,first: true //不显示首页
            //     ,last: true //不显示尾页
            // }

        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            if(obj.event === 'del'){
                var cid = data.attId;
                layer.confirm('真的删除行么', function(index){
                    $.get("${pageContext.request.contextPath}/jack/delAtt?cid="+cid,function (d) {
                        if(d > 0){
                            layer.msg('删除成功');
                            table.reload('test');
                        }else if (d === null){
                            layer.msg('删除失败');
                            table.reload('test');
                        }
                        table.reload('test');
                    });
                    table.reload('test');
                    layer.close(index);
                });
            }
        });

        //未打卡说明、我的审核   监听表格头的按钮'toolbar(test)'
        table.on('toolbar(test)', function(obj){
            var data = obj.data;
            if(obj.event == 'punching'){
                layer.open({
                type: 1,
                title:'未打卡说明',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['600px', '450px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: false, //开启遮罩关闭
                //content: ['${pageContext.request.contextPath}/jack/test','no']
                content: $('#windows1'),
                cancel:function(index, layero){
                        $("#Wfrom")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        table.reload('test');
                        return false;
                    }
                });
            }else if(obj.event == 'MyApproval'){
                var index = layer.open({
                    type: 2,
                    title:'我的审核',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['1000px', '450px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/xxx','no'],
                    cancel: function(index, layero){
                        table.reload('test');
                    }
                });
                layer.full(index);
            }
        });
    });
</script>
</body>
</html>
