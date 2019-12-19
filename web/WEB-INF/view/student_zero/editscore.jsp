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
    <title>修改学生成绩</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<script type="text/html" id="top">
        <div class="layui-input-inline">
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回</a>
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="save"> <i class="layui-icon">&#xe605;</i>保存</a>
        </div>
        <div class="layui-input-inline">
            <h2 style="margin-left: 260px">修改学生成绩</h2>
        </div>
</script>
<table id="demo" lay-filter="test" ></table>
</body>

<script>
    layui.use('table',function() {
        var table = layui.table;
        var layTableId = "layTable";
        table.render({
            elem: '#demo',
            height: 600,
            data: ${stu}, //数据接口,
            id: layTableId,
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            cols: [[ //表头
                {field: 'scoreId', title: '成绩id', width: 100,hide:'true'},
                {field: 'Studid', title: '学生id', width: 100,hide:'true'},
                {field: 'stuno', title: '学号', width: 100}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'termName',title:'在读学期',width:103}
                , {field: 'termid',title:'学期id',hide:'true'}
                , {field: 'testType',title:'考试类别',width:103}
                , {field: 'courseName',title:'课程名称',width:120}
                , {field: 'courseId,',title:'课程id',width:120,hide:'true'}
                , {field: 'scoreTime',title:'考试时间',width:150,templet : "<div>{{layui.util.toDateString(d.scoreTime,'yyyy年MM月dd日')}}</div>"}
                , {field: 'empName', title: '录入人员', width: 120}
                , {field: 'score', title: '学生成绩', width: 120,edit:'text',event:"checkTest"}
                , {field: 'Rescore', title: '补考分数', width: 120,edit:'text',event:"checkTest"}
                , {field: 'remark', title: '备注', width: 200,edit:'text'}
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
                            $input.val(val.replace(/[^\d.]/g, '').replace(/\.{2,}/g, '.').replace('.', '$#$').replace(/\./g, '').replace('$#$', '.').replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3').replace(/^\./g, ''));
                        });
                        break;
                }
        });

        table.on('toolbar(test)', function(obj){
            switch(obj.event) {
                case 'exit'://返回
                    window.location.href="<%=request.getContextPath()%>/StudentScore/toscore"
                    break;
                case 'save'://保存
                    var oldData = table.cache[layTableId];
                    for(var i=0, row; i < oldData.length; i++){
                        row = oldData[i];
                        if (row.score==''){
                            layer.msg('请将所有学生的成绩补全后即可保存!')
                            return;
                        }
                    }
                    //验证通过后保存
                     for(var i=0, row; i < oldData.length; i++){
                        row = oldData[i];
                        var scoreId = row.scoreId;//考试id
                        var stuid = row.Studid;//学生id
                        var score = row.score;//考试成绩
                        var Rescore = row.Rescore;//补考分数
                        var termid = row.termid;//学期id
                        if(Rescore==undefined){
                            Rescore="";
                        }
                        var remark = row.remark;//备注
                        if(remark==undefined){
                            remark="";
                        }
                        var scoreTime = layui.util.toDateString(row.scoreTime,'yyyy-MM-dd');//考试时间
                        var testType = row.testType;//考试类别
                        var courseId = row.courseId;//课程id
                        $.ajax({
                            type: 'post',
                            url: "<%=request.getContextPath()%>/StudentScore/editscore", // ajax请求路径
                            async:true,
                            dataType: "text",
                            data:{
                                stuid:stuid,
                                scoreId:scoreId,
                                score:score,
                                Rescore :0,
                                res: Rescore,
                                scoreTime : scoreTime,
                                testType : testType,
                                courseId : courseId,
                                termid :termid,
                                remark:remark
                            }
                        });
                    }
                    window.location.href="<%=request.getContextPath()%>/StudentScore/toscore"
                    break;
            }
        })

    })
</script>
</html>
