<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/4
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工请假页面</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<div id="windows" style="margin-left: 5%;display: none;">
        <table align="center" style="width:55%;margin-top: -2%;border-collapse:separate; border-spacing:0px 20px;">
            <tr>
                <th colspan="2">
                    <font style="text-align: center">员工请假</font>
                </th>
            </tr>
            <tr>
                <th>请假类型：</th>
                <td class="layui-form">
                    <select name="Title" id="Title" lay-filter="请假事由" lay-search>
                        <option value="事假">事假</option>
                        <option value="病假">病假</option>
                        <option value="四小时带薪假">四小时带薪假</option>
                        <option value="婚假">婚假</option>
                        <option value="产假">产假</option>
                        <option value="陪产">陪产假</option>
                        <option value="其他">其他</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>开始时间：</th>
                <td>
                    <input type="text" class="layui-input" name="startTime" id="startDate" placeholder="选择开始时间">
<%--                    <input type="text" name="startDate"  autocomplete="off" class="layui-input shij">--%>
                </td>
            </tr>
            <tr>
                <th>结束时间：</th>
                <td>
                    <input type="text" class="layui-input" name="endTime" id="endDate" placeholder="选择结束时间">
<%--                    <input type="text" name="startDate"  autocomplete="off" class="layui-input shij">--%>
                </td>
            </tr>
            <tr>
                <th>
                    请假时长：
                </th>
                <td style="">
                    <input type="text" id="days" name="holidayDay" style="width: 50px;height: 30px;" >天,
                    <select name="hour" id="hour" style="width: 80px;height: 30px;">
                        <option value="0">默认</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                    </select>小时
                </td>
            </tr>
            <tr>
                <th>请假事由：</th>
                <td>
                    <textarea name="Remark" id="Remark" rows="3" cols="25"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <button type="button" class="layui-btn" style="width: 100px;" onclick="submitleave()">提交</button>
                    <button type="button" class="layui-btn layui-btn-normal" style="width: 100px;">取消</button>
                </td>
            </tr>
        </table>
</div>
<table class="layui-hide" id="test" lay-filter="test" style="text-align: center;"></table>

<div id="page"></div>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="topBar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add">添加</a>
</script>
<%-------------------------------------------------------------%>
<script>
    function submitleave(){
        params = {
            Title:document.getElementById("Title").value,
            startTime:$("#startDate").val(),
            endTime:$("#endDate").val(),
            holidayDay:$("#days").val(),
            hour:$("#hour").val(),
            Remark:$("#Remark").val(),
            type:'empleave'

        }

        back = function(data){
            $("#windows").css("display","none")
        }

        $.post("${pageContext.request.contextPath}/empLeave/addLeave",params,back,"text");
    }


    var startdate = "";
    var enddate = "";

    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#startDate',
            type: 'date',
            done: function (value) {
                startdate=value;
            }
        });

        laydate.render({
            elem: '#endDate',
            type: 'date',
            done: function (value) {
                enddate = value;
                var day = getDaysBetween(startdate,enddate);
                day = Math.ceil(day)
                document.getElementById("days").value=day;
            }
        })
        function  getDaysBetween(dateString1,dateString2){
            var  startDate = Date.parse(dateString1);
            var  endDate = Date.parse(dateString2);
            var days=(endDate - startDate)/(1*24*60*60*1000);
            return  days;
        }

        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/empLeave/returnData'
            ,toolbar: '#topBar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {field: 'holidayid', title: 'ID', width:200, sort: true, fixed: 'left', totalRowText: '合计：'}
                ,{field: 'Empid', title: '请假人', width:200}
                ,{field: 'holidayDay', title: '请假时长', width: 200, sort: true, totalRow: true}
                ,{field: 'startTime', title: '开始时间', width:200, sort: true}
                ,{field: 'endTime', title: '结束时间', width: 200, sort: true, totalRow: true}
                ,{field: 'status', title: '状态', width: 200}
                ,{field: 'Remark', title: '内容', width: 200}
                ,{fixed: '', title:'操作', width: 270, align:'center', toolbar: '#barDemo'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1,
                        title:'员工请假',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '450px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        //content: ['${pageContext.request.contextPath}/jack/test','no']
                        content: $('#windows')
                    });
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
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        })
    })

</script>
</body>
</html>
