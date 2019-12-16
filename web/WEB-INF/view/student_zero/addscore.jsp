<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/15
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增学生成绩</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<script type="text/html" id="top">
        <div class="layui-input-inline">
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回</a>
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="save"> <i class="layui-icon">&#xe605;</i>保存</a>
        </div>
        <div class="layui-input-inline">
            <h2 style="margin-left: 260px">录入学生成绩</h2>
        </div>
</script>
<table id="demo" lay-filter="test" ></table>
</body>

<script>
    layui.use('table',function() {
        var table = layui.table;
        table.render({
            elem: '#demo',
            height: 600,
            data: ${stu}, //数据接口,
            id: "tt",
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            page: true, //开启分页
            totalRow: true,//开启合计行
            cols: [[ //表头
                {field: 'stuno', title: '学号', width: 100}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'termName',title:'在读学期',width:103}
                , {field: 'testType',title:'考试类别',width:103}
                , {field: 'courseName',title:'课程名称',width:120}
                , {field: 'scoreTime',title:'考试时间',width:150,templet : "<div>{{layui.util.toDateString(${scoreTime},'yyyy年MM月dd日')}}</div>"}
                , {field: 'score', title: '学生成绩', width: 120,edit:'text',event:"checkTest"}
                , {field: 'Rescore', title: '补考分数', width: 120,edit:'text',event:"checkTest"}
                , {field: 'Remark', title: '备注', width: 200,edit:'text'}
            ]]
            ,done: function(res, page, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //分类显示中文名称
                $("[data-field='testType']").children().each(function(){
                    if($(this).text()=='1'){
                        $(this).text("笔试")
                    }else if($(this).text()=='2'){
                        $(this).text("机试")
                    }else if($(this).text()=='3'){
                        $(this).text("模拟面试")
                    }
                })
            },
            limits: [10, 20, 30 , 40, 50]
        });
        table.on('tool(test)',
            function(d) {
                switch (d.event) {
                    case "checkTest":
                        $(d.tr).find(".layui-table-edit").keyup(function () {
                            var $input = $(this), val = $input.val();
                            if (!val) val = "";
                            $input.val(val.replace(/[^\d.""]/g,''));
                        });
                        break;
                }
        });
        table.on('edit(test)', function(obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段

            console.log(value+''+data+''+field)
            /*layui.use('jquery', function () {
                var $ = layui.$;
                $.ajax({
                    type: 'get',
                    url: "test.php", // ajax请求路径
                    data: {
                        id: data.id,
                        field: field,
                        value: value
                    },
                    success: function (data) {
                        layer.msg('修改成功');
                    }
                });
            })*/
        })

        table.on('toolbar(test)', function(obj){
            /*var checkStatus = table.checkStatus(obj.config.id);
            //var data = checkStatus.data;

            var value = obj.value;//修改后的数据
            var field = obj.field;//修改的字段名
            var data = obj.data;//修改的当行数据*/

            switch(obj.event) {
                case 'exit'://返回
                    window.location.href="<%=request.getContextPath()%>/StudentScore/toscore"
                    break;
                case 'save'://保存
                    function saveScore() {
                        for (var i = 0; i < ; i++) {
                            
                        }
                    }
                    //console.log(value)
                    /*table.on('edit(test)', function (obj) {
                        var value = obj.value //得到修改后的值
                            , data = obj.data //得到所在行所有键值
                            , field = obj.field;

                        console.log(value)
                    });*/
                    break;
            }
        })

    })
</script>
<%--<script type="text/html">--%>
<%--    <input id="num" onblur="test(value)"  class="layui-input" type="text"--%>
<%--       onkeyup="value=value.replace(/[^\d]/g,'') " ng-pattern="/[^a-zA-Z]">--%>
<%--</script>--%>
</html>
