<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019-12-23
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>班级分配</title>
    <jsp:include page="../include.jsp"/>
    <style>
        .layui-form-item{
            width: 150px;
        }
        .layui-form-select{
            width: 130px;
        }
        .layui-input-inline {
            width: 125px;
        }
        .layui-input{
            width: 140px;
        }
        .layui-form-item .layui-input-inline {
            width: 150px;
        }
    </style>
</head>
<body>
<script type="text/html" id="top" lay-filter="top">
    <a style="margin-left: -5px;" id="allot"  class="layui-btn layui-btn-primary layui-btn-xs" lay-event="allot"><i class="layui-icon">&#xe770;</i>确认分配</a>
    <label  class="layui-form-item">
            <label class="layui-form-label" style="width: 90px">学生姓名:</label>
            <div class="layui-input-inline">
                <input id="stuname" type="text" name="stuname" class="layui-input"/>
            </div>
        </div>
            <label class="layui-form-label" style="width: 90px">手机号码:</label>
            <div class="layui-input-inline">
                <input id="Phone" type="text" name="Phone" class="layui-input"/>
            </div>
        <label class="layui-form-label" style="width: 90px">学生类别:</label>
        <div class="layui-input-inline">
            <select id="ctype" name="ctype">
                <option value="0">--未选择--</option>
                <c:forEach  var="c" items="${classtype}">
                    <option value="${c.classTypeId}">${c.classTypeName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="layui-input-inline">
            <button id="seek" type="submit" class="layui-btn" onclick="seek()">搜索</button>
        </div>
        <label class="layui-form-label" style="width: 90px;margin-left:-55px">分配宿舍:</label>
        <div class="layui-input-inline" style="margin-left: -10px">
            <select id="dorm" name="dorm">
                <c:forEach items="${dorm}" var="d" >
                    <option value="${d.hourid}">${d.huorName}</option>
                </c:forEach>
            </select>
        </div>
    </label>
</script>
    <table id="demo" lay-filter="test"></table>
</body>
<script>
    var table;
    layui.use('table', function(){
        table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 700
            ,url: '<%=request.getContextPath()%>/zeroStudent/allotStu' //数据接口
            ,id:"clientId"
            ,toolbar: '#top' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'enrollmentid',hide:'true'}
                ,{field: 'studName', title: '学生姓名', width:100}
                ,{field: 'card', title: '身份证号', width:180}
                ,{field: 'sex', title: '性别', width:80}
                ,{field: 'tell',title:'手机号',width:150}
                ,{field: 'school', title: '学校', width:140}
                ,{field: 'classes', title: '班级', width:100}
                ,{field: 'empName', title: '招生老师', width:100}
                ,{field: 'classTypeName', title: '班级类别', width:100}
            ]]
            ,page: {limit:20,limits:[20,30,50],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        })

        table.on('toolbar(test)', function(obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            if (obj.event == 'allot') {//确认分配
                if(data.length === 0){
                    layer.msg('请选择学生来分配班级');
                    return;
                }
                $(data).each(function (index,elemnt) {
                    $.ajax({
                        url:'<%=request.getContextPath()%>/zeroStudent/entrance',
                        type: 'post',
                        async:true,
                        data:{
                            cid:${cid},//班级id
                            sid:elemnt.enrollmentid,//学生id
                            dorm:$("#dorm").val()//宿舍id
                        }
                    })
                })
                layer.msg('分配成功!');
                location.reload();
            }
        })

    })

    function seek() {//搜索学生
        var stuname = $("#stuname").val();//学生姓名
        var Phone = $("#Phone").val();//手机号
        var ctype = $("#ctype").val();//班级类别

        table.reload('clientId',{
            url:'<%=request.getContextPath()%>/zeroStudent/seekStu',
            where:{
                stuname:stuname,
                Phone:Phone,
                ctype:ctype,
            }
        })
        $("#stuname").val(stuname);
        $("#Phone").val(Phone);
        $("#ctype").val(ctype);
    }
</script>
</html>
