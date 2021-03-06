<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/10
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<style>
    /*.layui-table img{
        max-width: 100px;
    }*/
</style>
<body>
    <div id="windows" style="margin-left:5%; margin-top:1%; display: none;">
        <form method="post" class="layui-form" enctype="multipart/form-data" action="<%=request.getContextPath()%>/studentduan/addproblems">
            <table style="border-collapse:separate;border-spacing:0px 20px;margin-left: 15%">
                <h2 style="color: red" align="center">-------------------------------问题反馈----------------------------------</h2>
                <tr>
                    <th>反馈部门:</th>
                    <td>
                        <select name="depId">
                            <c:forEach items="${list}" var="deplist">
                                <option value="${deplist.depid}">${deplist.depName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>反馈问题:</th>
                    <td>
                        <textarea rows="5" cols="50" name="remark" lay-verify="required"/></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="file" name="images"  onchange="upload(this)" lay-verify="required">
                            <div id="huixian" style="height:100px;width: 50px"></div>
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <button id="tijiao" style="text-align: center" style="margin-left: 25%" class="layui-btn layui-btn-warm" type="submit" lay-submit><i class="layui-icon layui-icon-ok" ></i>添加</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <!--点击查看意见弹出来的框-->

    <div id="yijianwindows" style="margin-left:5%; margin-top:1%; display: none;">
        <div style="height:411.2px;width:100%;overflow-y:auto" id="contents">

        </div>
    </div>
    <!--问题反馈按钮-->
    <script type="text/html" id="toolbar">
        <button style="margin-left: 40%;margin-top:3%" type="button" lay-event="problem" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>问题反馈</button>
    </script>

    <table class="layui-hide" lay-filter="test" id="test"></table>

    <script type="text/html" id="barDemo">
        <!--查看意见-->
        <button type="button" lay-event="opinion" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>查看意见</button>
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
            toolbar: '#toolbar',
            height:700,
            url: '<%=request.getContextPath()%>/studentduan/selectproblem',
            cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'feedbackId', title: '编号', width: 100, fixed: 'left', unresize: true, sort: true}
                , {field: 'stuname', title: '学生ID', width: 100}
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
                , {field: 'remark', title: '学生反馈问题', width:200}
                , {field: 'image', title: '图片', width:100,templet:'<div><img style="width:100px;height:100px" src="{{d.Image}}"></div>'}
                , {field: 'status', title: '是否处理', templet: function (d) {
                        if (d.status === 1) {
                            return '未处理'
                        } else if (d.status === 2) {
                            return '已处理'
                        }
                    }, width:100
                }
                ,{fixed: '', width:163, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            , page: true,
            limits: [5, 10, 15, 25]
        });

        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch (obj.event) {
                case 'problem':
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '650px'],
                        fixed: false, //不固定
                        maxmin: true,
                        content: $('#windows'),
                        shadeClose: true, //开启遮罩关闭
                    });
                    break;
            };
        });

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
            layer.open({
                type: 1,
                title:'查看意见',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['700px', '600px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: true, //开启遮罩关闭
                content: $('#yijianwindows')
            });
        })

    })
    //图片回显方法
    function upload(obj){
        var f = obj.files;
        var str = "";
        for(var i=0;i<f.length;i++){
            var reader = new FileReader();
            reader.readAsDataURL(f[i]);
            reader.onload = function(e){
                str+='<img src="'+e.target.result+'" height="100px"/>';
                document.getElementById("huixian").innerHTML = str;
            }
        }
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