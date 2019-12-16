<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/6
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <table class="layui-hide" lay-filter="test" id="test"></table>
    <script type="text/html" id="barDemo">
        <!--查看批注-->
        <button type="button" <%--lay-event="select" --%>class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon layui-icon-search"></i>查看批注</button>
    </script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','laypage'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laypage = layui.laypage;
        var laydate = layui.laydate;
        table.render({
            elem:'#test',
            height:500,
            url:'<%=request.getContextPath()%>/student/selectleave',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'holidayid',title:'编号', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'StudentIdd', title:'请假人', width:100}
                ,{field:'holidayDay', title:'假期天数', width:170,sort:true}
                ,{field:'startTime', title:'开始时间', width:200,templet:'<div>{{ layui.util.toDateString(d.startTime,"yyyy-MM-dd HH:mm:ss")}}</div>'}
                ,{field:'endTime', title:'结束时间', width:200,templet:'<div>{{ layui.util.toDateString(d.endTime,"yyyy-MM-dd HH:mm:ss")}}</div>'}
                ,{field:'Title', title:'标题',width:200}
                ,{field:'Remark', title:'备注', width:200}
                ,{field:'Status', title:'状态', width:200}
                ,{fixed: '', width:300, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            ,page:true,
            limits:[5,10,15,25]
        });
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
            /*if(event=='select'){
                var id = obj.data.weeklogid;
                location.href='<%=request.getContextPath()%>/emp/lookEmpPaperPage/'+id;
            }*/
        });
    })
</script>
</html>