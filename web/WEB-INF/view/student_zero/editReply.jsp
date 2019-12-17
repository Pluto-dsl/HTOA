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
    <title>修改学生答辩成绩</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<script type="text/html" id="top">
    <div class="layui-input-inline">
        <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="exit"> <i class="layui-icon">&#xe65c;</i>返回</a>
        <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="save"> <i class="layui-icon">&#xe605;</i>保存</a>
    </div>
    <div class="layui-input-inline">
        <h2 style="margin-left: 200px">修改${cls.className}(${project.projectName})答辩成绩</h2>
    </div>
    <div class="layui-input-inline">
        <label class="layui-form-label" style="width: 90px">评分人员:</label>
    </div>
    <div class="layui-input-inline" lay-filter="sel">
        <from class="layui-form">
            <select  name="empId" id="empId" >
                <option value="0">--未选择--</option>
                <c:forEach var="e" items="${teacher}">
                    <option value="${e.empId}">${e.empName}</option>
                </c:forEach>
            </select>
        </from>
    </div>
</script>
<table id="demo" lay-filter="test" ></table>
</body>

<script>
    layui.use(['table','form'],function() {
        var table = layui.table;
        var form = layui.form;
        var layTableId = "layTable";
        table.render({
            elem: '#demo',
            height: 600,
            data: ${stu}, //数据接口,
            id: layTableId,
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            cols: [[ //表头
            {field: 'replyId', title: '序号', width: 75,hide:'true'}
            ,{field: 'StudentId', title: '学生id', width: 75,hide:'true'}
            ,{field: 'stuno', title: '学号', width: 88}
            , {field: 'stuname', title: '学生姓名', width: 80}
            , {field: 'projectId', title: '项目id',hide:'true'}
            , {field: 'score1',title:'功能完善50',edit:'text',event:"checkTest"}
            , {field: 'Score2',title:'技术难度10',edit:'text',event:"checkTest"}
            , {field: 'Score3',title:'界面完美10',edit:'text',event:"checkTest"}
            , {field: 'Score4',title:'回答问题10',edit:'text',event:"checkTest"}
            , {field: 'Score5',title:'演示方法10',edit:'text',event:"checkTest"}
            , {field: 'Score6',title:'语言表达10',edit:'text',event:"checkTest"}
            , {field: 'Remark', title: '备注', width: 100,edit:'text'}
            , {field: 'emp', title: '评分人id',hide:'true'}
            ]],done: function(res, page, count){
            //如果是异步请求数据方式，res即为你接口返回的信息。
            //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
            //分类显示中文名称
            $("[data-field='emp']").children().each(function(){
                $("#empId").val($(this).text());
                form.render('select');
            })
        }
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
                        if (row.score1==undefined||row.Score2==undefined||row.Score3==undefined||row.Score4==undefined||row.Score5==undefined||row.Score6==undefined){
                            layer.msg('请将所有学生的成绩补全后即可保存!')
                            return;
                        }
                        if (row.score1>50){
                            layer.msg('功能完善分最高为50!请重新输输入!')
                            return;
                        }
                        if (row.Score2>20||row.Score3>20||row.Score4>20||row.Score5>20||row.Score6>20){
                            layer.msg('技术难度,界面完美,回答问题,演示方法,语言表达中每个最高为20分!请重新输输入!')
                            return;
                        }
                    }
                    //验证通过后保存
                    for(var i=0, row; i < oldData.length; i++){
                        row = oldData[i];
                        var replyId = row.replyId;//成绩id
                        var StudentId = row.StudentId;//学生id
                        var score1 = row.score1;//功能完善50
                        var Score2 = row.Score2;//技术难度10
                        var Score3 = row.Score3;//界面完美10
                        var Score4 = row.Score4;//回答问题10
                        var Score5 = row.Score5;//演示方法10
                        var Score6 = row.Score6;//语言表达10
                        var remark = row.Remark;//备注
                        var empId = $("#empId").val();
                        var projectId = row.projectId;
                        if(remark==undefined){
                            remark="";
                        }
                        $.ajax({
                            type: 'post',
                            url: "<%=request.getContextPath()%>/StudentScore/editReplyscore", // ajax请求路径
                            async:true,
                            dataType: "text",
                            data:{
                                replyId:replyId,
                                StudentId: StudentId,
                                score1: score1,
                                Score2: Score2,
                                Score3: Score3,
                                Score4: Score4,
                                Score5: Score5,
                                Score6: Score6,
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
