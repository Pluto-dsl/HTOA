<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/11
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
    <style>
        li{
            list-style-type:disc;
        }
        .ques{
            display: block;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form lay-filter="formTestFilter" class="layui-form" action="<%=request.getContextPath()%>/student/addcollect/">
        <div id="windows" style="display: none;height:95%;" >
            <input type="hidden" name="feedbackId">
            <div style="background-color: #ffffff;height: 12%;width: 100%;border-bottom: solid 2px #de76b1;">
                <span style="font-size: 20px;margin-right: 20px;float: right;margin-top: 5px;">发问人:<label id="stuname"></label></span>
                <label style="float: right;margin-top: 40px; margin-right: -128px;" id="feedbackTime"></label>
                    <br>
                <span style="font-size: 20px;margin-left: 20px;">问题:<label id="remark" class="ques" style="display:inline-block;width:25%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;line-height: 30px;
    font-size: 15px;position: absolute;" ></label></span>
                    <%--提出时间:<input type="text" name="feedbackTime" style="border: none;width:80px" disabled="true">--%>
            </div>
            <div style="height:411.2px;width:100%;overflow-y:auto" id="contents">

            </div>
            <div style="background-color: #389cb7;height: 15%;width: 100%;">
                <textarea rows="10" cols="60" style="width: 80%;height:55%;margin-left: 15px;margin-top: 8px;font-size: 20px;padding: 10px 10px;" id="txt" name="content" ></textarea>
                <button class="layui-btn layui-btn layui-btn-warm" type="submit" onclick="showInput()" style="float: right;margin-right: 20px;margin-top: 20px;background-color: red;">发送</button>
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

        $(".ques").on('mouseover mouseout',function (event) {
            var $title=$(this).text();
            var $self=$(this);
            if (event.type=='mouseover') {
                $self.attr('title', function() { return $title });
            }else if(event.type=='mouseout'){
                $self.attr('title', '');
            }
        })

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
                        var carNewsList = "<ul id='ol'  style='margin-left: 3%'>";
                        $(data).each(function (index,element) {
                            var name =element.empName;
                            var time = element.puttime;

                            var content = element.content;
                            carNewsList += "<li style='border-bottom: solid 1.5px #4e4b4e21;width: 95%;height: 55px;'>" +
                                                "<div style='width: 100%;height:80px'>" +
                                                    "<div style='margin-top: 18px;'>"+name+"--"+createTime(time)+"</div>" +
                                                    "<div style='margin-left: 3%;margin-top: 7px;font-size: 14px;'>"+"回复:"+content+"</div>" +
                                                "</div>" +
                                            "</li>";

                        });
                        carNewsList += "</ul>";
                        document.getElementById("contents").innerHTML=carNewsList;
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
                    area: ['700px', '600px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#windows')
                });
                setFormValue(datas);//动态向表单赋值
        });

        //获取该id的数据
       function setFormValue(data){
           $("#stuname").html(data.stuname);
           $("#remark").html(data.remark);
           $("#feedbackTime").html(createTime(data.feedbackTime));
       }
        $("li").removeClass("style"); //移除
    })
</script>
<script type=text/javascript>
    function showInput() {
        var name = "${sessionScope.admin.empName}";
        var corl = document.getElementById("txt");   // 取得输入框对象
        var val = name+":"+corl.value;                           // 取得输入的内容
        $("#contents").append(val);     //将输入内容显示到DIV
    }
    //时间修改方法
    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        /*m = m<10?'0'+m:m;*/
        var d = date.getDate();
        var h = date.getHours();
        var f =date.getMinutes();
        var s = date.getSeconds();
        /*d = d<10?("0"+d):d;*/
        var str = y+"-"+m+"-"+d+" "+h+":"+f+":"+s;
        return str;
    }
</script>
</html>