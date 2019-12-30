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
    <jsp:include page="../../include.jsp" />
</head>
<body>
<div id="windows" style="margin-left: 5%;display: none;">
    <form id="holidayform" class="layui-form" method="post">
        <input type="hidden" name="type" value="empLeave"/>
        <table align="center" style="width:55%;margin-top: -2%;border-collapse:separate; border-spacing:0px 20px;" >
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
                    <input autocomplete="off"  lay-verify="required" type="text" class="layui-input" name="startTime" id="startDate" placeholder="选择开始时间">
                </td>
            </tr>
            <tr>
                <th>结束时间：</th>
                <td>
                    <input autocomplete="off"  lay-verify="required" type="text" class="layui-input" name="endTime" id="endDate" placeholder="选择结束时间">
                </td>
            </tr>
            <tr>
                <th>
                    请假时长：
                </th>
                <td style="">
                    <input type="text" id="days" name="holidayDay"  readonly="readonly" style="width: 50px;height: 30px;" >天,
                    <select name="hour" id="hour" style="width: 80px;height: 30px;" lay-ignore>
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
                    <button  type="submit" class="layui-btn"  lay-submit lay-filter="Action" style="width: 100px;"  <%--onclick="submitleave()"--%>>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>
<table class="layui-hide" id="test" lay-filter="test" style="text-align: center;"></table>
<div id="page"></div>
<script type="text/html" id="topBar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add"><i class="layui-icon">&#xe654;</i>申请请假</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="mytask"><i class="layui-icon">&#xe705;</i>我的任务</a>
    <!--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="history">历史任务</a>-->
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看批注</a>
</script>
<script>
    var startdate = "";
    var enddate = "";
    var win;
    var table;
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        //日期
        var day2 = new Date();
        day2.setTime(day2.getTime());
        //var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();
        laydate.render({//开始时间
            elem: '#startDate',
            type: 'date',
            //min:s2,
            done: function (value) {
                startdate=value;
            }
        });

        laydate.render({
            elem: '#endDate',
            type: 'date',
            //min:s2,
            done: function (value) {
                enddate = value;
                var day = getDaysBetween(startdate,enddate);
                day = Math.ceil(day)
                if (isNaN(parseInt(day))) {
                    document.getElementById("days").value= "";
                } else{
                    document.getElementById("days").value=day;
                }
            }
        })
        function getDaysBetween(dateString1,dateString2){
            var  startDate = Date.parse(dateString1);
            var  endDate = Date.parse(dateString2);
            var days=(endDate - startDate)/(1*24*60*60*1000)
            return  days;
        }

        table.render({
            elem: '#test'
            ,id:'etabe'
            ,height:600
            ,url:'${pageContext.request.contextPath}/zeroLeave/returnData'
            ,toolbar: '#topBar' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {field: 'holidayid', title: 'ID', width:80, sort: true, fixed: 'left', totalRowText: '合计：'}
                ,{field: 'Empid', title: 'id', width:100,hide:'true'}
                ,{field: 'empName', title: '请假人', width:100}
                ,{field: 'hour', title: '请假时长(小时)', width:150, sort: true, totalRow: true}
                ,{field: 'startTime', title: '开始时间', width:150, sort: true,templet : "<div>{{layui.util.toDateString(d.startTime,'yyyy年MM月dd日')}}</div>"}
                ,{field: 'endTime', title: '结束时间', width: 150, sort: true, totalRow: true,templet : "<div>{{layui.util.toDateString(d.endTime, 'yyyy年MM月dd日')}}</div>"}
                ,{field: 'status', title: '状态', width: 100}
                ,{field: 'Remark', title: '内容', width: 100}
                ,{fixed: '', title:'操作', width: 150, align:'center', toolbar: '#barDemo'}
            ]]
            ,page: true
            ,page: {limit:20,limits:[10,20,30,50,100]
                ,layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
            ,done: function(res, page, count){
                $("[data-field='status']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("审批中")
                    }else if($(this).text()=='2'){
                        $(this).text("已完成")
                    } else if($(this).text()=='3'){
                        $(this).text("不批准")
                    }
                })
            }
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    if(${admin.empId}==1001){
                        layer.msg("您都是老板了,还用请假吗!")
                        return;
                    }
                    win = layer.open({
                        type: 1,
                        title:'员工请假',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '450px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windows')
                    });
                    break;
                case 'mytask'://我的任务
                    layer.msg('加载中,请稍后!');
                    window.location.href="<%=request.getContextPath()%>/zeroLeave/mytask"
                    break;
                case 'history'://历史任务
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){//查看批注
                window.location.href="<%=request.getContextPath()%>/zeroLeave/mycomment?holidayid="+data.holidayid;
            }
        })
        form.on('submit(Action)', function(data){
            //console.log(data.field);
            if(data.field.startTime>data.field.endTime){
                layer.msg('请假开始时间不能大于结束时间,请重新选择!')
                return false;
            }
            layer.msg('正在提交,请稍后!')
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/zeroLeave/addLeave", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    if(data='yes'){
                        layer.close(win);
                        layer.msg('提交成功!')
                        table.reload(
                            'etabe',{
                            done: function(res, page, count){
                            $("[data-field='status']").children().each(function(){
                                if($(this).text()=='1'){
                                    $(this).text("审批中")
                                }else if($(this).text()=='2'){
                                    $(this).text("已完成")
                                } else if($(this).text()=='3'){
                                    $(this).text("不批准")
                                }
                            })
                        }}
                        );
                        document.getElementById("holidayform").reset();
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    })

    /*function submitleave(){//提交请假
        layer.msg('正在提交,请稍等!')
        var params = {
            Title:document.getElementById("Title").value,
            startTime:$("#startDate").val(),
            endTime:$("#endDate").val(),
            holidayDay:$("#days").val(),
            hour:$("#hour").val(),
            Remark:$("#Remark").val(),
            type:'empLeave'
        }
        back = function(){
            layer.close(win);
            layer.msg('提交成功!')
            table.reload('etabe');
        }
        $.post(${pageContext.request.contextPath}/zeroLeave/addLeave",params,back,"text");

    }*/
</script>
</body>
</html>
