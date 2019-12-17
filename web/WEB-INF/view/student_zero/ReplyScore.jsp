<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/13
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>答辩成绩</title>
    <jsp:include page="../include.jsp"/>
    <style>
        .layui-form-item .layui-input-inline {
            float: left;
            width: 176px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <table id="demo" lay-filter="test" ></table>
    <script type="text/html" id="top" lay-filter="top">
        <label  class="layui-form-item">
            <label class="layui-form-label" style="width: 90px">项目名称:</label>
            <div class="layui-input-inline">
                <select id="projectName" name="projectName">
                    <option value="0">--未选择--</option>
                    <c:forEach var="p" items="${project}">
                        <option value="${p.projectId}">${p.projectName}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label" style="width: 90px">班级名称:</label>
            <div class="layui-input-inline">
                <select id="className" name="className">
                    <option value="0">--未选择--</option>
                    <c:forEach var="c" items="${claes}">
                        <option value="${c.classId}">${c.className}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label" style="width: 90px">评分人员:</label>
            <div class="layui-input-inline">
                <select id="empName" name="empName">
                    <option value="0">--未选择--</option>
                    <c:forEach var="e" items="${teacher}">
                        <option value="${e.empId}">${e.empName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="layui-input-inline">
                <button id="seek" type="submit" class="layui-btn" onclick="seek()">搜索</button>
            </div>
            <div class="layui-input-inline" style=" margin-left: -50px;">
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i>录入答辩成绩</a>
            </div>
            <div class="layui-input-inline" style=" margin-left: -51px;">
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i>修改答辩成绩</a>
            </div>
        </label>
    </script>
    <div  id="addscore"  style="margin-left: 5%;display: none;">
        <form  class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">班级名称:</label>
                <div  class="layui-input-block">
                    <select  name="classid" style="width: 100px">
                        <c:forEach var="c" items="${claes}">
                            <option value="${c.classId}">${c.className}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">项目名称:</label>
                <div  class="layui-input-block">
                    <select  name="projectId">
                        <c:forEach var="p" items="${project}">
                            <option value="${p.projectId}">${p.projectName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="luruAction" >开始录入</button>
                </div>
            </div>
        </form>
    </div>
    <!--修改-->
    <div  id="editscore"  style="margin-left: 5%;display: none;">
        <form  class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">班级名称:</label>
                <div  class="layui-input-block">
                    <select  name="classid" style="width: 100px">
                        <c:forEach var="c" items="${claes}">
                            <option value="${c.classId}">${c.className}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">项目名称:</label>
                <div  class="layui-input-block">
                    <select  name="projectId">
                        <c:forEach var="p" items="${project}">
                            <option value="${p.projectId}">${p.projectName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="editAction" >开始修改</button>
                </div>
            </div>
        </form>
    </div>
</body>
<script>
    var table
    layui.use(['laydate','table', 'form'], function() {
        var form = layui.form;
        table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo',
            height: 600,
            url: '<%=request.getContextPath()%>/StudentScore/replyScore', //数据接口,
            id: "clientId",
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            page: true, //开启分页
            cols: [[ //表头
                {field: 'replyId', title: '序号', width: 75,sort:'true'}
                , {field: 'stuname', title: '学生姓名', width: 80}
                , {field: 'className', title: '班级名称', width: 200}
                , {field: 'projectName', title: '项目名称', width: 150}
                , {field: 'empName', title: '评分老师', width: 150}
                , {field: 'score1',title:'功能完善50',width:103,sort:'true'}
                , {field: 'Score2',title:'技术难度10',width:105,sort:'true'}
                , {field: 'Score3',title:'界面完美10',width:105,sort:'true'}
                , {field: 'Score4',title:'回答问题10',width:105,sort:'true'}
                , {field: 'Score5',title:'演示方法10',width:105,sort:'true'}
                , {field: 'Score6',title:'语言表达10',width:105,sort:'true'}
                , {field: 'Score7',title:'总分100',width:100,sort:'true'}
                , {field: 'Remark', title: '备注', width: 100}
            ]],
                limits: [10, 20, 30 , 40, 50]
        });
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1,
                        title:'录入学生成绩',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['450px', '350'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#addscore')
                    });
                break;
                case 'edit':
                    layer.open({
                        type: 1,
                        title:'修改学生成绩',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['450px', '350'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#editscore')
                    });
                    break;
            }
        });

        //新增学生成绩
        form.on('submit(luruAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/StudentScore/haveReplyscore", // ajax请求路径
                async:true,
                dataType: "text",
                data:{
                    classid:data.field.classid,
                    projectId:data.field.projectId,
                },
                success: function(d){
                    if(d=='have'){//有成绩
                        layer.msg('此班已有该成绩,你可以修改此班级该的成绩!')
                    }else if(d=='no'){//没成绩
                        window.location.href="<%=request.getContextPath()%>/StudentScore/toaddReply?classid="+data.field.classid+"&projectId="+data.field.projectId;
                        return true;
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });

        //修改学生成绩
        form.on('submit(editAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/StudentScore/haveReplyscore", // ajax请求路径
                async:true,
                dataType: "text",
                data:{
                    classid:data.field.classid,
                    projectId:data.field.projectId,
                },
                success: function(d){
                    if(d=='have'){//有成绩
                        window.location.href="<%=request.getContextPath()%>/StudentScore/toeditReply?classid="+data.field.classid+"&projectId="+data.field.projectId;
                        return true;
                    }else if(d=='no'){//没成绩
                        layer.msg('查无此班级成绩,请先新增此班的该答辩成绩!')
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    })

    //条件搜索
    function seek() {
        //项目名称id
        var  projectId = $("#projectName").val();
        //班级id
        var  classId = $("#className").val();
        //评分人员
        var  empId = $("#empName").val();
        table.reload('clientId',{
            url:'<%=request.getContextPath()%>/StudentScore/seek',
            where:{
                projectId:projectId,
                classId:classId,
                empId:empId,
            }, page: {
                curr: 1 //重新从第 1 页开始
            }
        })

        $("#projectName").val(projectId);
        $("#className").val(classId);
        $("#empName").val(empId);
    }
</script>
</html>
