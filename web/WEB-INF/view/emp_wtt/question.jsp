<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/11
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <form lay-filter="formTestFilter" class="layui-form" action="<%=request.getContextPath()%>/student/addcollect/">
        <div id="windows" style="margin-top:2%; display: none;height: 90%;margin-left: 1px" >
            <input type="hidden" name="feedbackId">
            <div style="background-color:pink;height: 10%;width: 100%">
                <h2>问题发起人:<input type="text" name="stuname" style="border: none;width:80px" disabled="true">
                                问题:<input type="text" name="remark" style="border: none" disabled="true"></h2>
            </div>
            <div style="height:50%;width: 100%;overflow-y:auto" id="contents">

            </div>
            <div style="background-color:skyblue;height:20%;width: 100%/*;border-style:solid*//*; border-width:1px; border-color:red*/">
                <textarea rows="5" cols="50" style="margin-top:2px" id="txt" name="content"></textarea>
                <button type="submit" onclick="showInput()">发送</button>
            </div>
        </div>
    </form>
    <table class="layui-hide" lay-filter="test" id="test"></table>
    <script type="text/html" id="barDemo">
        <!--意见-->
        <button type="button" lay-event="opinion" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>意见</button>
    </script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','laypage','upload'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laypage = layui.laypage;
        var laydate = layui.laydate;
        var upload = layui.upload;
        table.render({
            elem: '#test',
            height:700,
            url: '<%=request.getContextPath()%>/student/selectquestion',
            cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'feedbackId', title: '编号', width: 100, fixed: 'left', unresize: true, sort: true}
                , {field: 'stuname', title: '学生姓名', width: 100}
                , {field: 'empName', title: '学生班级', width: 170, sort: true}
                , {field: 'feedBackType', title: '身份',templet: function (d) {
                        if (d.feedBackType === 1) {
                            return '学生'
                        } else if (d.feedBackType === 2) {
                            return '老师'
                        }
                    }, width:100}
                , {field: 'feedbackTime', title: '反馈时间', width:120, templet: '<div>{{ layui.util.toDateString(d.feedbackTime,"yyyy-MM-dd")}}</div>'}
                , {field: 'depName', title: '反馈部门', width:100}
                , {field: 'remark', title: '学生反馈问题', width: 200}
                , {field: 'image', title: '图片', width:100,templet:'<div><img style="width:100px;height:100px" src="{{d.Image}}"></div>'}
                , {field: 'status', title: '是否处理', templet: function (d) {
                        if (d.status === 1) {
                            return '未处理'
                        } else if (d.status === 2) {
                            return '已处理'
                        }
                    }, width:100
                }/*
                , {field: 'userid', title: '审批人', width: 80}*/
                ,{fixed: '', width:163, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            , page: true,
            limits: [5, 10, 15, 25]
        });

        //行工具栏
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            /*console.log(datas);*/
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
                $.ajax({
                    url: "${pageContext.request.contextPath}/student/selectcollect",
                    type: "post",
                    async:true,
                    dataType: "json",
                    data:{
                        wid:datas.feedbackId
                    },
                    success: function (data) {
                        alert(data)
                       $(data).each(function (index,element) {
                           var name = element.empName+":"+element.content+"<br><br>";
                           alert(name)
                           $("#contents").append(name);
                        })
                    },
                    error:function () {
                        console.log("失败啦")
                    }

                });
                $("#contents").empty();
                layer.open({
                    type: 1,
                    title:'提出意见',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '550px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#windows')
                });
                setFormValue(datas);//动态向表单赋值
        });

        //获取该id的数据
       function setFormValue(data){
           /*console.log(data)*/
            form.val("formTestFilter", {
                "feedbackId":data.feedbackId
                ,"stuname":data.stuname
                ,"remark":data.remark
            });
            form.render(null,'formTestFilter')
       }
    })
</script>
<script type=text/javascript>
    function showInput() {
        var name = "${sessionScope.admin.empName}";
        var corl = document.getElementById("txt");   // 取得输入框对象
        var val = name+":"+corl.value;                           // 取得输入的内容
        $("#contents").append(val);     //将输入内容显示到DIV
    }
</script>
</html>