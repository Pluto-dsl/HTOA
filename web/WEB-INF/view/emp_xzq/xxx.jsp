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
    <meta charset="UTF-8">
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<%--<div style="margin-left: 5%">--%>
<%--    <form class="layui-form" action="${pageContext.request.contextPath}/jack/Attadd" method="post" >--%>
<%--        <h2 style="margin-left: 35%" >未打卡说明</h2>--%>
<%--        <br><br>--%>
<%--        未打卡日期：<div style="margin-right:10px" class="layui-inline">--%>
<%--        <input type="text" name="punckClockTime" class="layui-input" id="clockDate">--%>
<%--    </div>--%>
<%--        时间点:--%>
<%--        <div class="layui-input-inline">--%>
<%--            <select name="timeing" lay-filter="type">--%>
<%--                <option value="8:00">8:00</option>--%>
<%--                <option value="14:00">14:00</option>--%>
<%--                <option value="17:00">17:00</option>--%>
<%--                <option value="21:00">21:00</option>--%>
<%--            </select>--%>
<%--        </div>--%>
<%--        <br><br>说明原因:<div class="layui-input-inline"><input type="text" name="cause" required lay-verify="required" placeholder="请输入说明原因" autocomplete="off" class="layui-input"></div>--%>
<%--        <br><br><br><button style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>--%>
<%--    </form>--%>
<%--</div>--%>
<div id="windows2" style="margin-left: 5%;display: none">
    <form style="margin-left: 20%" id="Sform" class="layui-form" action="${pageContext.request.contextPath}/jack/AttUpdata" method="post" >
        <br><br>
        <input type="hidden" name="eid" id="eid" value="" />
        申请人:<div style="margin-right:30px;margin-left: 5px;" class="layui-inline"><h3 align="left" style="color:#FF5722" id="Nname" name="Nname">sdsadsa</h3></div>
            审核:
            <div class="layui-input-inline">
                <select name="state" lay-filter="type">
                    <option value="1">审核批准</option>
                    <option value="3">申请驳回</option>
                </select>
            </div>
        <br><br>审核说明:<div class="layui-input-inline"><input type="text" name="specification" required lay-verify="required" placeholder="请输入审核说明" autocomplete="off" class="layui-input"></div>
        <br><br><br><button style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
    </form>
</div>

<table class="layui-hide" id="test1" lay-filter="test1"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">审核</a>
</script>

</body>
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
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;



        table.render({
            elem: '#test1'
            ,url:'${pageContext.request.contextPath}/jack/Approver'
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
                ,{field:'examineTime',templet:function (d){
            return createTime(d.examineTime);
        } , title:'审核时间' ,width:180}
                ,{field:'examineExplain', title:'审核说明', width:120}
                ,{field:'state',templet:function (d) {
                        if (d.state === 1) {
                            return '通过审核'
                        }else if(d.state === 2) {
                            return '待审核'
                        }else if(d.state === 3){
                            return '审核失败'
                        }
                    },title:'状态', width:120}
                ,{title:'操作',align:'center' , width:80 , toolbar:'#barDemo'}]]
            ,page: false
        });

        //我的审核
        table.on('tool(test1)', function(obj){
            var data = obj.data;
            $('#Nname').html(data.empName);
            $('#eid').val(data.attId);
            if(obj.event == 'edit'){
                layer.open({
                    type:1,
                    title:'我的审核',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['600px', '300px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    //content: ['${pageContext.request.contextPath}/jack/test','no']
                    content: $('#windows2'),
                    cancel: function(index, layero){
                        $("#Sform")[0].reset();
                        layui.form.render();
                        layer.close(index);
                        return false;
                    }
                });
            }
        });

    });
</script>
</html>