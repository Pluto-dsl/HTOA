<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/4
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<jsp:include page="../include.jsp"/>
<head>
    <title>班级展示页</title>
    <style>
        .layui-form-item{
            width: 150px;
        }
        .layui-form-select{
            width: 160px;
        }
        .layui-input-inline {
            width: 125px;
        }
        .layui-input{
            width: 170px;
        }
        .layui-form-item .layui-input-inline {
            width: 150px;
        }
    </style>
</head>
<body>
    <script type="text/html" id="top" lay-filter="top">
        <a id="add"  class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add"><i class="layui-icon">&#xe654;</i>新增班级</a>
        <a id="allot"  class="layui-btn layui-btn-primary layui-btn-xs" lay-event="allot"><i class="layui-icon">&#xe770;</i>班级分配</a>
            <label  class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">级别:</label>
                <div class="layui-input-inline">
                    <select id="grade" name="grade" lay-verify="required">
                        <option value="0">--未选择--</option>
                        <option value="2016">2016</option>
                        <option value="2017">2017</option>
                        <option value="2018">2018</option>
                        <option value="2019">2019</option>
                        <option value="2020">2020</option>
                        <option value="2021">2021</option>
                        <option value="2022">2022</option>
                        <option value="2023">2023</option>
                        <option value="2024">2024</option>
                        <option value="2025">2025</option>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 90px">届别:</label>
                <div class="layui-input-inline">
                    <select id="level" name="level" lay-verify="required">
                        <option value="0">--未选择--</option>
                        <c:forEach var="d" items="${level}">
                            <option value="${d.fallid}">${d.level}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 90px">班级类别:</label>
                <div class="layui-input-inline">
                    <select id="ctype" name="ctype" lay-verify="required">
                        <option value="0">--未选择--</option>
                        <c:forEach  var="c" items="${classtype}">
                            <option value="${c.classTypeId}">${c.classTypeName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <button id="seek" type="submit" class="layui-btn" onclick="seek()">搜索</button>
                </div>
            </label>
    </script>
    <script type="text/html" id="t" >
        <center><h5 style="margin-left: 50px;">学生资料</h5></center>
    </script>
    <script type="text/html" id="bar" >
        <a class="layui-btn layui-btn-xs" lay-event="student">查看学生</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <table id="demo" lay-filter="test"></table>
    <!--查看学生-->
    <div  id="swindow"  style="display: none;">
        <table id="student" lay-filter="test"></table>
    </div>
    <!--新增班级-->
    <div  id="addclasswindows"  style="margin-left: 5%;display: none;">
        <form id="classform" action="<%=request.getContextPath()%>/zeroStudent/addClass" class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <table style="border-collapse:separate; border-spacing:20px;margin-left: 73px;">
                <tr>
                    <input type="hidden" id="classid"  name="classId" value="0"/>
                    <td>
                        班级编号:
                    </td>
                    <td>
                        <input class="layui-input" id="classno" type="text" name="classno" required lay-verify="required"  onkeyup="value=value.replace(/\D/g,'')" onafterpaste="value=value.replace(/\D/g,'')"/>
                    </td>
                    <td>班级名称:</td>
                    <td>
                        <input class="layui-input" id="className" type="text" name="className" required lay-verify="required"/>
                    </td>
                </tr>
                <tr>
                    <td>授课老师:</td>
                    <td>
                        <select id="teacher" name="teacher">
                            <c:forEach  var="t" items="${teacher}">
                                <option value="${t.empId}">${t.empName}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        班主任:
                    </td>
                    <td>
                        <select id="classTeacher" name="classTeacher">
                            <c:forEach  var="t" items="${teacher}">
                                <option value="${t.empId}">${t.empName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>班级类别:</td>
                    <td>
                        <select id="classType" name="classType">
                            <c:forEach  var="c" items="${classtype}">
                                <option value="${c.classTypeId}">${c.classTypeName}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>系名称:</td>
                    <td><select id="deptName" name="deptId">
                        <c:forEach  var="c" items="${dept}">
                            <option value="${c.deptid}">${c.deptName}</option>
                        </c:forEach>
                    </select></td>
                </tr>
                <tr>
                    <td>专业名称:</td>
                    <td><select id="majorName" name="majorId">
                        <c:forEach  var="m" items="${major}">
                            <option value="${m.majorid}">${m.majorName}</option>
                        </c:forEach>
                    </select></td>
                    <td>届别:</td>
                    <td>
                        <select id="fallid" name="falled" lay-verify="required">
                            <c:forEach var="d" items="${level}">
                                <option value="${d.fallid}">${d.level}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        说明:
                    </td>
                    <td colspan="3">
                        <textarea id="remark" name="remark" class="layui-textarea" style="width: 370px"> </textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="aduitAction" >保存</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
<script>
    layui.use(['table', 'form'], function(){
        var form = layui.form;
        table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 500
            ,url: '<%=request.getContextPath()%>/zeroStudent/allClass' //数据接口
            ,id:"clientId"
            ,toolbar: '#top' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            ,cols: [[ //表头
                {type: 'radio', fixed: 'left'}
                ,{field: 'classId', title: '序号', width:70}
                ,{field: 'classNo', title: '班级编号', width:100}
                ,{field: 'className', title: '班级名称', width:230}
                ,{field: 'teacherName', title: '授课老师', width:100}
                ,{field: 'teacher',hide:'true'}
                ,{field: 'classTeacherName', title: '班主任', width:100}
                ,{field: 'classTeacher',hide:'true'}
                ,{field: 'classTypeName', title: '班级类别', width:100}
                ,{field: 'classType',hide:'true'}
                ,{field: 'level', title: '届别', width: 80}
                ,{field: 'falled',hide:'true'}
                ,{field: 'deptName', title: '系名称', width: 145}
                ,{field: 'deptId',hide:'true'}
                ,{field: 'majorName', title: '专业名称', width: 140}
                ,{field: 'majorId',hide:'true'}
                ,{field: 'status', title: '操作', width: 200,toolbar:'#bar'}
                ,{field: 'ren', title: '人数',hide:'true'}
            ]]
            ,page: {limit:10,limits:[5,10,20,30,50],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        //查看学生表格
        table.render({
            id:'stable'
            ,elem: '#student'
            ,height: 550
            ,id:"stable"
            ,toolbar: '#t' //开启头部工具栏，并为其绑定左侧模板
            ,cols: [[ //表头
                {field: 'className', title: '班级', width:250}
                ,{field: 'stuname', title: '学生姓名', width:100}
                ,{field: 'sex', title: '性别', width:80}
                ,{field: 'phone', title: '学生电话', width:140}
            ]]
            ,
        })
        //监听操作
        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            if(layEvent === 'student'){ //查看学生
                table.reload('stable',{
                    url:'<%=request.getContextPath()%>/zeroStudent/classStudent?classId='+data.classId,
                })//删除后刷新表格
                layer.open({
                    type: 1,
                    title:data.className+'学生名单(共:'+data.ren+'人)',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['600px', '550'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#swindow'),
                });
            } else if(layEvent === 'del'){ //删除
                layer.confirm('真的删除当前班级吗?', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);//关闭提示
                    //向服务端发送删除指令
                    $.post("<%=request.getContextPath()%>/zeroStudent/deleteClass",{classId:data.classId},function (d) {
                    },"text")
                });
            } else if(layEvent === 'edit'){ //修改
                layer.open({
                    type: 1,
                    title:'修改'+data.className+'的班级信息',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['800px', '550px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#addclasswindows'),
                    success: function(layero, index){
                        $("#classid").val(data.classId);
                        $("#classno").val(data.classNo);
                        $("#className").val(data.className);
                        $("#teacher").val(data.teacher);
                        //$("#selected").find("option[value='xxx']").prop("selected",true);
                        $("#classTeacher").val(data.classTeacher);
                        $("#classType").val(data.classType);
                        $("#fallid").val(data.falled);
                        $("#remark").val(data.remark);
                        $("#deptName").val(data.deptId);
                        $("#majorName").val(data.majorId);

                        form.render();
                    },
                    cancel: function(index, layero){
                        //关闭清空表单
                        document.getElementById("classform").reset();
                        $("#classid").val(0);
                        return true;
                    }
                });
            }
        });
        //头部工具栏监听
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            if(obj.event=='add'){//添加班级
                layer.open({
                    type: 1,
                    title: '新增班级',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['800px', '550px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#addclasswindows')
                });
            }else if (obj.event=='allot') {
                if(data.length === 0){
                    layer.msg('请选择一个班级来分配学生');
                    return;
                }
                 var index = layer.open({
                    type: 2,
                    title: data[0].className+'分配学生',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['1200px', '550px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: '<%=request.getContextPath()%>/zeroStudent/toallot?cid='+data[0].classId
                })
                layer.full(index);
            }
        })
    });
    //条件搜索
    function seek() {
        var level = $("#level").val();//届别
        var grade = $("#grade").val();//级别
        var ctype = $("#ctype").val();//班级类别
        table.reload('clientId',{
            url:'<%=request.getContextPath()%>/zeroStudent/seek',
            where:{
                level:level,
                grade:grade,
                ctype:ctype,
            }
        })
        $("#level").val(level);
        $("#grade").val(grade);
        $("#ctype").val(ctype);
    }
</script>
</html>
