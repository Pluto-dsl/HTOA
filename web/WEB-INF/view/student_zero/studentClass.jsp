<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/4
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../include.jsp"/>
<head>
    <title>员工展示页</title>
    <style>
        .layui-form-item{
            width: 120px;
        }
        .layui-form-select{
            width: 120px;
        }
        .layui-input-inline {
            width: 120px;
        }
        .layui-input{
            width: 120px;
        }
        .layui-form-item .layui-input-inline {
            width: 118px;
        }
    </style>
</head>
<body>
    <script type="text/html" id="top">
        <a class="layui-btn layui-btn-primary layui-btn-xs layui-icon-add-1" lay-event="detail" href="<%=request.getContextPath()%>/zeroStudent/addclass">新增班级</a>
            <label  class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">届别:</label>
                <div class="layui-input-inline">
                    <select id="depId" name="depId" lay-verify="required">
                        <option value="0">--未选择--</option>
                        <c:forEach var="d" items="${level}">
                            <option value="${d.fallid}">${d.level}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <button id="seek" type="submit" class="layui-btn" onclick="seek()">搜索</button>
                </div>
            </label>
    </script>

    <script type="text/html" id="bar">
        <a class="layui-btn layui-btn-xs" lay-event="student">查看学生</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <table id="demo" lay-filter="test"></table>
</body>
<script>
    layui.use('table', function(){
        table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '<%=request.getContextPath()%>/zeroStudent/allClass' //数据接口
            ,id:"clientId"
            ,toolbar: '#top' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'classId', title: '序号', width:50}
                ,{field: 'classNo', title: '班级编号', width:100}
                ,{field: 'className', title: '班级名称', width:200}
                ,{field: 'teacherName', title: '授课老师', width:100}
                ,{field: 'classTeacherName', title: '班主任', width:100}
                ,{field: 'classTypeName', title: '班级类别', width:80}
                ,{field: 'level', title: '届别', width: 80}
                ,{field: 'deptName', title: '系名称', width: 200}
                ,{field: 'majorName', title: '专业名称', width: 200}
                ,{field: 'status', title: '操作', width: 200,toolbar:'#bar'}
            ]]
            ,page: {limit:10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象

            if(layEvent === 'student'){ //查看学生

            } else if(layEvent === 'del'){ //删除
                layer.confirm('真的删除当前班级吗?', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);//关闭提示
                    //向服务端发送删除指令
                    $.post("<%=request.getContextPath()%>/zeroStudent/deleteClass",{classId:data.classId},function (d) {
                    },"text")
                });
            } else if(layEvent === 'edit'){ //修改

            }
        });
    });
    //条件搜索
    function seek() {
        //部门id
        var depId = $("#depId").val();
        //员工姓名
        var empName = $("#empName").val();
        //手机号码
        var Phone = $("#Phone").val();
        //状态
        var status = $("#status").val();
        //layer.alert("部门id"+empId+"员工姓名"+empName+"手机号"+Phone+"状态"+status);
        table.reload('clientId',{
            url:'<%=request.getContextPath()%>/zeroEmp/seek',
            where:{
                depId:depId,
                empName:empName,
                Phone:Phone,
                status:status
            }
        })
        //搜索完把值传回去
        $("#depId").val(depId);
        $("#empName").val(empName);
        $("#Phone").val(Phone);
        $("#status").val(status);
    }
</script>
</html>
