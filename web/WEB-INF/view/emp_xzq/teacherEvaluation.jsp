<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/13
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>教师考评</title>
    <jsp:include page="../include.jsp" />
    <style>
        .layui-input, .layui-textarea {
            display: block;
            width: 140px;
            padding-left: 10px;
        }
    </style>
</head>
<body>
<from class="layui-form">
<div style="margin-left: 30px;margin-top: 15px;" class="demoTable">
    <table style="margin-bottom: -60px;margin-top: -3%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <td><span  style="float:left;line-height: 3;" >姓名-</span></td>
                <td><input type="text" style="float:left;" class="layui-input" autocomplete="off" name="Name" id="Name"/></td>
                <td><span style="margin-left: 15px;float: left;line-height: 3;">职务类型-</span></td>
                <td>
                    <select name="duties" id="duties">
                        <option value="">请选择职务</option>
                        <option value="1">授课老师</option>
                        <option value="2">班主任</option>
                    </select>
                </td>
                <td><button style="float: left;" type="submit" lay-submit lay-filter="Esubmit" class="layui-btn" ><i class="layui-icon layui-icon-search" ></i>搜索</button></td>
            <tr>
    </table>
</div>
</from>
<table class="layui-hide" id="teacherList" lay-filter="teacherList"></table>
<script type="text/html" id="barDemo">
    <button class="layui-btn layui-btn-sm layui-btn layui-btn-normal" lay-event="ScoreDetails"><i class="layui-icon layui-icon-survey"></i>老师评分详情</button>
    <button class="layui-btn layui-btn-sm layui-btn layui-btn-danger" lay-event="ReportForm"><i class="layui-icon layui-icon-chart"></i>统计报表</button>
</script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        table.on('row(teacherList)',function(obj){
            var oo = obj.tr; //得到当前行元素对象
            var data = obj.data; //得到当前行数据
            selected =  data;
            //选中行样式
            obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
            //选中radio样式
            obj.tr.find('i[class="layui-anim layui-icon"]').trigger("click");
            settable(data.Studid);
        });

        //员工考核列表
        table.render({
            elem: '#teacherList'
            ,url:'${pageContext.request.contextPath}/jack/teacherListE'
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,toolbar:'#barDemo'
            ,title: '用户数据表'
            ,skin:'nob'
            ,cols: [[
                {type:'radio'}
                ,{field:'teacherTotalid', title:'编号', width:80 ,event: 'setSign'}
                ,{field:'evaluationType',templet:function (d) {
                        if(d.evaluationType == 1){
                            return "授课老师";
                        }else if(d.evaluationType == 2){
                            return "班主任";
                        }
                    }, title:'员工类型', width:200}
                ,{field:'empName', title:'班主任/授课老师', width:150}
                ,{field:'className', title:'班级名称', width:260}
                ,{field:'sum', title:'总评分', width:150}
                ,{field: 'classTeacher', width: 50,style:'display:none;'}
                ,{field: 'classId', width: 50,style:'display:none;'}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 20, 30, 40, 50]

        });

        table.on('toolbar(teacherList)',function (obj) {
            var checkStatus = table.checkStatus('teacherList');
            var classid = "";
            var teacherid = "";
            if(obj.event === 'ScoreDetails'){
                if (checkStatus.data.length <= 0) {
                    layer.msg('未选择');
                } else {
                    var data = checkStatus.data;
                    console.log(checkStatus.data);
                    $.each(data,function (index,elemt) {
                        classid = data[index].classId;
                        teacherid = data[index].classTeacher;
                    });
                    var index = layer.open({
                        type: 2,
                        title:'老师考评详情',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['auto', 'auto'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: false, //开启遮罩关闭
                        content: ['${pageContext.request.contextPath}/jack/toScoreDetails?classid='+classid+'&teacherid='+teacherid,'no']
                    });
                    layer.full(index);

                }
            }else if(obj.event === 'ReportForm'){
                var index = layer.open({
                    type: 2,
                    title:'考评报表',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['auto', 'auto'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/toReportForm','no']
                });
                layer.full(index);
            }

        });

        form.on('submit(Esubmit)',function (data) {
            var Name = $("#Name").val();
            var duties = $("#duties").val();
            table.render({
                elem: '#teacherList'
                ,url:'${pageContext.request.contextPath}/jack/teacherListE?Name='+Name+'&duties='+duties
                ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                ,title: '用户数据表'
                ,toolbar:'#barDemo'
                ,skin:'nob'
                ,cols: [[
                    {type:'radio'},
                    {field:'teacherTotalid', title:'编号', width:80 ,event: 'setSign'}
                    ,{field:'evaluationType',templet:function (d) {
                            if(d.evaluationType == 1){
                                return "授课老师";
                            }else if(d.evaluationType == 2){
                                return "班主任";
                            }
                        }, title:'员工类型', width:200}
                    ,{field:'empName', title:'班主任/授课老师', width:150}
                    ,{field:'className', title:'班级名称', width:260}
                    ,{field:'sum', title:'总评分', width:150}
                    ,{field: 'classTeacher', width: 50,style:'display:none;'}
                    ,{field: 'classId', width: 50,style:'display:none;'}
                ]]
                ,page: true
                ,limit:15
                ,limits: [15, 20, 30, 40, 50]

            });
        })

    });
</script>
</html>
