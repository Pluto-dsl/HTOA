<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/17
  Time: 8:47
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<table class="layui-hide" id="teacherList" lay-filter="teacherList"></table>
</body>
    <script>
        layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
            var element = layui.element;
            var layer = layui.layer;
            var table = layui.table;
            var form = layui.form;
            var laydate = layui.laydate;
            var upload = layui.upload;

            table.render({
                elem: '#teacherList'
                ,url:'${pageContext.request.contextPath}/jack/ScoreDetails'
                ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                ,title: '用户数据表'
                ,skin:'line'
                ,cols: [[
                    {field:'TeachertotalId', title:'编号', width:80}
                    ,{field:'evaluationName', title:'考评内容', width:180}
                    ,{field:'evaluationType',templet:function (d) {
                            if(d.evaluationType == 1){
                                return "授课老师";
                            }else if(d.evaluationType == 2){
                                return "班主任";
                            }
                        }, title:'员工类型', width:200}
                    ,{field:'empName', title:'班主任/授课老师', width:150}
                    ,{field:'className', title:'班级名称', width:260}
                    ,{field:'teacherScore', title:'评分', width:100}
                    ,{field: 'Optime',templet:'<div>{{layui.util.toDateString(d.punckClockTime,"yyyy-MM-dd HH:mm:ss")}}</div>',title:'考评时间',width: 150}
                ]]
                ,page: false

            });

        });
    </script>
</html>
