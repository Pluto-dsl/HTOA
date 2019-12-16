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
    <title>考试成绩</title>
    <jsp:include page="../include.jsp"/>
    <style>
        .layui-form-item .layui-input-inline {
            float: left;
            width: 121px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<script type="text/html" id="top">
    <label  class="layui-form-item">
        <label class="layui-form-label" style="width: 90px">在读学期:</label>
        <div class="layui-input-inline">
            <select id="term" name="term">
                <option value="0">--未选择--</option>
                <c:forEach var="t" items="${term}">
                    <option value="${t.termid}">${t.termName}</option>
                </c:forEach>
            </select>
        </div>
        <label class="layui-form-label" style="width: 90px">班级名称:</label>
        <div class="layui-input-inline">
            <select id="className" name="className" style="width: 100px">
                <option value="0">--未选择--</option>
                <c:forEach var="c" items="${claes}">
                    <option value="${c.classId}">${c.className}</option>
                </c:forEach>
            </select>
        </div>
        <label class="layui-form-label" style="width: 90px">考试类别:</label>
        <div class="layui-input-inline">
            <select id="stype" name="stype">
                <option value="0">--未选择--</option>
                <option value="1">笔试</option>
                <option value="2">机试</option>
                <option value="3">模拟面试</option>
            </select>
        </div>
        <label class="layui-form-label" style="width: 90px">课程名称:</label>
        <div class="layui-input-inline">
            <select id="courseName" name="courseName">
                <option value="0">--未选择--</option>
                <c:forEach var="c" items="${course}">
                    <option value="${c.courseId}">${c.courseName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="layui-input-inline">
            <button id="seek"  class="layui-btn" onclick="seek()">搜索</button>
        </div>
        <div class="layui-input-inline">
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i>录入学生成绩</a>
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i>修改学生成绩</a>
        </div>
    </label>
</script>
<table id="demo" lay-filter="test" ></table>
<!--新增成绩-->
<div  id="addscore"  style="margin-left: 5%;display: none;">
    <form id="scoreform" class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">班级名称:</label>
            <div  class="layui-input-block">
                <select  name="classid" id ="classid" style="width:290px;">
                    <c:forEach var="c" items="${claes}">
                        <option value="${c.classId}">${c.className}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程名称:</label>
            <div  class="layui-input-block">
                <select  name="courseid" style="width:290px;">
                    <c:forEach var="c" items="${course}">
                        <option value="${c.courseId}">${c.courseName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">考试类别:</label>
            <div  class="layui-input-block">
                <select  name="scoreType" style="width:290px;">
                    <option value="1">笔试</option>
                    <option value="2">机试</option>
                    <option value="3">模拟面试</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">在读学期:</label>
            <div  class="layui-input-block">
                <select  name="termid" style="width:290px;">
                    <c:forEach var="t" items="${term}">
                        <option value="${t.termid}">${t.termName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">考试时间:</label>
            <div  class="layui-input-block">
                <input lay-verify="required|date" id="scoreTime" name="scoreTime" value="" class="layui-input" type="text" placeholder="请选择考试时间"  autocomplete="off"  editable="false"  style="width:290px;">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <center>
                    <button type="submit" class="layui-btn" lay-submit lay-filter="luruAction" >开始录入</button>
                </center>
            </div>
        </div>
    </form>
</div>
<!--修改成绩-->
<div  id="editscore"  style="margin-left: 5%;display: none;">
    <form id="editform" class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">班级名称:</label>
            <div  class="layui-input-block">
                <select  name="classid" style="width:290px;">
                    <c:forEach var="c" items="${claes}">
                        <option value="${c.classId}">${c.className}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程名称:</label>
            <div  class="layui-input-block">
                <select  name="courseid" style="width:290px;">
                    <c:forEach var="c" items="${course}">
                        <option value="${c.courseId}">${c.courseName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">考试类别:</label>
            <div  class="layui-input-block">
                <select  name="scoreType" style="width:290px;">
                    <option value="1">笔试</option>
                    <option value="2">机试</option>
                    <option value="3">模拟面试</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">在读学期:</label>
            <div  class="layui-input-block">
                <select  name="termid" style="width:290px;">
                    <c:forEach var="t" items="${term}">
                        <option value="${t.termid}">${t.termName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <center>
                    <button type="submit" class="layui-btn" lay-submit lay-filter="editAction" >开始修改</button>
                </center>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    var table;
    layui.use([ 'laydate','element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#scoreTime'
            // ,format: 'yyyy年MM月dd日'
        });
        table.render({
            elem: '#demo',
            height: 600,
            url: '<%=request.getContextPath()%>/StudentScore/score', //数据接口,
            id: "tt",
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            page: true, //开启分页
            totalRow: true,//开启合计行
            cols: [[ //表头
                {field: 'scoreId', title: '序号', width: 100,sort:'true'}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'className', title: '班级', width: 250}
                , {field: 'score', title: '学生成绩', width: 120,sort:'true'}
                , {field: 'Rescore', title: '补考分数', width: 120,sort:'true'}
                , {field: 'courseName',title:'课程名称',width:120}
                , {field: 'testType',title:'考试类别',width:103}
                , {field: 'termName',title:'在读学期',width:103}
                , {field: 'scoreTime',title:'考试时间',width:150,templet : "<div>{{layui.util.toDateString(d.scoreTime,'yyyy年MM月dd日')}}</div>"}
                , {field: 'empName',title:'录入人员',width:103}
                , {field: 'remark', title: '备注', width: 150}
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
                        area: ['600px', '650px'],
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
                        area: ['600px', '400px'],
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
                url: "<%=request.getContextPath()%>/StudentScore/havescore", // ajax请求路径
                async:true,
                dataType: "text",
                data:{
                    classid:data.field.classid,
                    courseid:data.field.courseid,
                    scoreType:data.field.scoreType,
                    termid:data.field.termid,
                    scoreTime:data.field.scoreTime
                },
                success: function(d){
                    if(d=='no'){
                        layer.msg('此班已有此成绩,你可以修改此班级此的成绩!')
                    }else if(d=='ok'){
                        window.location.href="<%=request.getContextPath()%>/StudentScore/toaddscore?classid="+data.field.classid+"&courseid="+data.field.courseid+"&scoreType="+data.field.scoreType +
                            "&termid="+data.field.termid+
                            "&scoreTime="+data.field.scoreTime;
                        return true;
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });

        //修改学生成绩
        form.on('submit(editAction)', function(data){
            console.log(data.field)
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/StudentScore/havescore", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(d){
                    if(d=='no'){
                        window.location.href="<%=request.getContextPath()%>/StudentScore/toeditscore?classid="+data.field.classid+"&courseid="+data.field.courseid+"&scoreType="+data.field.scoreType +
                            "&termid="+data.field.termid;
                        return true;
                    }else if(d=='ok'){
                        layer.msg('还没有此班该成绩,请先新增后再做修改!')
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    })

    //条件搜索
    function seek() {
        //在读学期
        var term = $("#term").val();
        //班级id
        var  classId = $("#className").val();
        //考试类别
        var type = $("#stype").val();
        //课程名称
        var course = $("#courseName").val();
        table.reload('tt',{
            url:'<%=request.getContextPath()%>/StudentScore/scoreseek',
            where:{
                term:term,
                classId:classId,
                type:type,
                course:course
            },
            page: {
                curr: 1 //重新从第 1 页开始
            },done: function(res, page, count){
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
        }
        })
        $("#term").val(term);
        $("#className").val(classId);
        $("#stype").val(type);
        $("#courseName").val(course);
    }

</script>
</html>
