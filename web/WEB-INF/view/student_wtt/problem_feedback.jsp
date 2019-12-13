<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/10
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <textarea rows="5" cols="50" name="remark" /></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="file" name="images"  onchange="upload(this)">
                            <div id="huixian" style="height:100px;width: 50px" ></div>
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <button id="tijiao" style="text-align: center" style="margin-left: 25%" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>添加</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <!--问题反馈按钮-->
    <script type="text/html" id="toolbar">
        <button style="margin-left: 40%;margin-top:3%" type="button" lay-event="problem" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>问题反馈</button>
    </script>

    <table class="layui-hide" lay-filter="test" id="test"></table>
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
                , {field: 'opinion', title: '审批意见', width:150}
                , {field: 'status', title: '是否处理', templet: function (d) {
                        if (d.status === 1) {
                            return '未处理'
                        } else if (d.status === 2) {
                            return '已处理'
                        }
                    }, width:100
                }
                , {field: 'userid', title: '审批人', width:100}
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

        //普通图片上传
        /*upload.render({
            elem: '#test1',
            url:'<%=request.getContextPath()%>/studentduan/addproblems',
            bindAction:'#tijiao',
            auto:true,
            before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
        })*/

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
</script>
</html>