<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/24
  Time: 20:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>日志</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <script type="text/html" id="toolbarDemo">

    </script>
    <div>
        <form action="" class="layui-form" name="form1">
            <ul style="margin-top: 5px;margin-left: 2%;">
                <li style="display: inline-block">
                    <label class="label-top">开始时间:&nbsp;</label>
                </li>
                <li style="display: inline-block">
                    <input type="text" class="layui-input" name="stime" placeholder="开始时间" id="stime" >
                </li>
                <li style="display: inline-block">
                    <label style="width: 2%;">&nbsp;&nbsp;&nbsp;&nbsp;</label>
                </li>
                <li style="display: inline-block">
                    <label class="label-top">结束时间:&nbsp;</label>
                </li>
                <li style="display: inline-block">
                    <input type="text" class="layui-input" name="etime" placeholder="结束时间" id="etime" >
                </li>
                <li style="display: inline-block">
                    <label style="width: 2%;">&nbsp;&nbsp;&nbsp;&nbsp;</label>
                </li>
                <li style="display: inline-block">
                    <button class="layui-btn" id="submit" lay-submit lay-filter="sub"><i class="layui-icon layui-icon-search"></i></button>
                </li>
            </ul>
        </form>
    </div>
    <script type="text/html" id="barDemo">
    </script>
<div style="width: 100%;height: 100%">
    <table class="layui-hide" id="log" lay-filter="log"></table>
</div>

<script>

    layui.use(['table','laydate','form'], function() {
        var table = layui.table;

        var form = layui.form;

        var tableinit = table.render({
            elem: '#log'
            ,url:'${pageContext.request.contextPath}/log/getLogData'
            // ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '日志报表'
            ,cellMinWidth: 80
            ,cols: [[
                // {type: 'radio', fixed: 'left'}
                ,{field:'logId', title:'编号'}
                ,{field:'ipAddr', title:'访问IP'}
                // ,{field:'empId', title:'操作人ID'}
                ,{field:'empName', title:'操作人姓名'}
                     ,{field:'optime', title:'操作时间',templet : "<div>{{layui.util.toDateString(d.startDate, 'yyyy-MM-dd HH:mm:ss')}}</div>"}
                ,{field:'msg', title:'操作内容'}
                // ,{fixed: 'right', title:'操作', toolbar: '#barDemo',width:250}
            ]]
            ,page: true
            // ,limit:[5,10,15,20,25]
            // ,limit:[5,10,15,20,25,30]
        });
        // table.on('row(log)',function(obj){
        //     var oo = obj.tr; //得到当前行元素对象
        //     var data = obj.data; //得到当前行数据
        //     selected =  data;
        //     //选中行样式
        //     obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
        //     //选中radio样式
        //     obj.tr.find('i[class="layui-anim layui-icon"]').trigger("click");
        // });

        form.on('submit(sub)', function(data){
            var data = data.field;
            var stime = $("#stime").val();
            var etime = $("#etime").val();
            tableinit.reload({
                where:{
                    s:stime,
                    e:etime
                }
            });
            return false;
        })

    });

    layui.use('laydate', function() {
        var laydate = layui.laydate;
        var day2 = new Date();
        day2.setTime(day2.getTime());
        var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();

        laydate.render({
            elem: '#stime'
            ,max:s2
        });

        laydate.render({
            elem: '#etime'
        });
    })


</script>
</body>
</html>
