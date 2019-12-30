<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>新增学生答辩成绩</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<script type="text/html" id="top">
    <div class="layui-input-inline">
        <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回</a>
        <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="save"> <i class="layui-icon">&#xe605;</i>保存</a>
        <div class="layui-input-inline">
            <label class="layui-form-label" style="width: 90px">评分人员:</label>
        </div>
        <div class="layui-input-inline">
            <select  name="empId" id="empId">
                <option value="0">--未选择--</option>
                <c:forEach var="e" items="${teacher}">
                    <option value="${e.empId}">${e.empName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-input-inline">
        <h2 style="margin-left: 260px">录入学生答辩成绩</h2>
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
            page: true, //开启分页
            totalRow: true,//开启合计行
            cols: [[ //表头
                {field: 'Studid', title: '学生id', width: 100,hide:'true'},
                {field: 'stuno', title: '学号', width: 100}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'className',title:'班级名称',width:103}
                , {field: 'courseName',title:'项目名称',width:120,templet:'<div>${project.projectName}</div>'}
                , {field: 'score1', title: '功能完善50', width: 120,edit:'text',event:"checkTest"}
                , {field: 'score2', title: '技术难度10', width: 120,edit:'text',event:"checkTest"}
                , {field: 'score3', title: '界面完美10', width: 120,edit:'text',event:"checkTest"}
                , {field: 'score4', title: '回答问题10', width: 120,edit:'text',event:"checkTest"}
                , {field: 'score5', title: '演示方法10', width: 120,edit:'text',event:"checkTest"}
                , {field: 'score6', title: '语言表达10', width: 120,edit:'text',event:"checkTest"}
                , {field: 'Remark', title: '备注', width: 200,edit:'text'}
            ]]
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
                    window.location.href="<%=request.getContextPath()%>/StudentScore/toreply"
                    break;
                case 'save'://保存
                    var oldData = table.cache[layTableId];
                    for(var i=0, row; i < oldData.length; i++){
                        row = oldData[i];
                        if (row.score1==undefined||row.score2==undefined||row.score3==undefined||row.score4==undefined||row.score5==undefined||row.score6==undefined){
                            layer.msg('请将所有学生的成绩补全后即可保存!')
                            return;
                        }
                        if (row.score1>50){
                            layer.msg('功能完善分最高为50!请重新输输入!')
                            return;
                        }
                        if (row.score2>10||row.score3>10||row.score4>10||row.score5>10||row.score6>10){
                            layer.msg('技术难度,界面完美,回答问题,演示方法,语言表达中每个最高为10分!请重新输输入!')
                            return;
                        }
                    }
                    //验证通过后保存
                    for(var i=0, row; i < oldData.length; i++){
                        row = oldData[i];
                        var Studid = row.Studid;//学生id
                        var score1 = row.score1;//功能完善50
                        var score2 = row.score2;//技术难度10
                        var score3 = row.score3;//界面完美10
                        var score4 = row.score4;//回答问题10
                        var score5 = row.score5;//演示方法10
                        var score6 = row.score6;//语言表达10
                        var remark = row.Remark;//备注
                        var empId = $("#empId").val();
                        var projectId = ${project.projectId};
                        if(remark==undefined){
                            remark="";
                        }
                        $.ajax({
                            type: 'post',
                            url: "<%=request.getContextPath()%>/StudentScore/addReplyScore", // ajax请求路径
                            async:true,
                            dataType: "text",
                            data:{
                                StudentId: Studid,
                                score1: score1,
                                score2: score2,
                                score3: score3,
                                score4: score4,
                                score5: score5,
                                score6: score6,
                                remark: remark,
                                projectId:projectId,
                                empId:empId,
                            }
                        });
                    }
                    window.location.href="<%=request.getContextPath()%>/StudentScore/toreply";
                    break;
            }
        })

    })
</script>
</html>
