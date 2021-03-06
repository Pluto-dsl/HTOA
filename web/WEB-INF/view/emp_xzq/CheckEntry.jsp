<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/10
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<%--编辑弹层--%>
<div id="addWin">
    <form id="addfrom" action="${pageContext.request.contextPath}/jack/uploadImg" enctype="text/plain" class="layui-form" method="post" >
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <td>部门:</td>
                <td id="deptitle">
                    <select id="depid" name="depid" lay-filter="depid" lay-verify="required">
                        <option value="">请选择部门</option>
                    </select>
                </td>
                <td>员工:</td>
                <td>
                    <select id="Empid" name="Empid" lay-verify="required">
                        <option value="">请选择员工</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>考核指标:</td>
                <td>
                    <select id="aduitModelid" name="aduitModelid" lay-filter="kaohe" lay-verify="required">
                        <option value="">请选择考核指标</option>
                    </select>
                </td>
                <td>考核分数:</td>
                <td>
                    <input type="text" id="Scores" readonly="readonly" name="Scores" required lay-verify="number" placeholder="请输入考核分数" autocomplete="off" class="layui-input">
                </td>
            </tr>
            <tr>
                <td>考核说明:</td>
                <td>
                    <input type="text" id="Remark" name="Remark" required lay-verify="required" placeholder="请输入考核说明" autocomplete="off" class="layui-input">
                </td>
                <input type="hidden" name="auditDate" id="auditDate" value="" />
                <td>录入人员:</td>
                <td><input readonly="readonly" id="auditPerson" name="auditPerson" value="${sessionScope.admin.empName}" placeholder="请输入课程类型"  class="layui-input"></td>

            </tr>
            <tr>
                <td align="center"  colspan="2" >
                    <button type="button" class="layui-btn" id="upload1">上传图片</button>
                    <input type="hidden" id="img_url" name="Image" value="" />
                </td>
                <td align="center"  colspan="2">
                    <div style="width:200px;height:200px;border:3px solid #0099CC;border-radius: 5px;padding: 3px;">
                        <img style="max-width: 200px;max-height:200px;" id="preview">
                        <div id="demoText"></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <button lay-submit lay-filter="Asubmit" id="Asubmit" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;

        $("#auditDate").val(new Date);

        //执行一个laydate实例
        laydate.render({
            elem: '#auditDate' //指定元素
        });

        var uploadInst = upload.render({
            elem: '#upload1' //绑定元素
            ,url: '${pageContext.request.contextPath}/jack/uploadImg'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#preview').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
                //上传成功
                layer.msg('上传成功');
                console.log(res.url);
                $("#img_url").val(res.url);
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

        /** 获取考核分数 */
        form.on('select(kaohe)',function (data) {
            $.get('${pageContext.request.contextPath}/jack/Scores',{Scores:data.value},function (data) {
                $("#Scores").val(data);
            });
        });



        form.on('submit(Asubmit)', function (data) {
            var session = "${sessionScope.admin.empName}";
            if(session === ""){
                window.parent.location.href="${pageContext.request.contextPath}/logout";
                return false;
            }
            $("#aduitModelid").empty();
            $("#Empid").empty();
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/jack/addAduitLog',
                dataType: 'json',
                data: data.field,//往后台发送的是data.field，即一个{name：value}的数据结构
                async: true,
                success: function (result) {
                    console.log(result);
                    if (result === 0) {
                        layer.msg('保存成功', {icon: 1, time: 1000});
                        $("#preview").attr("src","");
                        $("#addfrom")[0].reset();
                        layui.form.render();
                    }else {
                        layer.msg('保存失败！' + result.msg, {icon: 2, time: 1000});
                        $("#addfrom")[0].reset();
                        layui.form.render();
                    }
                },
                error: function (result, type) {
                    layer.msg('保存失败！', {icon: 2, time: 1000});
                }
            });
            return false;
        });

        $.get('${pageContext.request.contextPath}/jack/selDepAll',{},function (data) {
            for (var i = 0; i < data.names.length; i++) {
                $("#depid").append("<option value='"+data.names[i].depid+"'>"+data.names[i].depName+"</option>");
            }
            form.render("select");
        },"json");

        $("#deptitle").click(function () {
            layer.tips('温馨提示:要先选择部门才有员工和针对部门的考核指标哦~', '#depid', {
                tips: [4, '#000000']
            });
        });

        form.on('select(depid)', function(data) {
            $("#aduitModelid").empty();
            $("#Empid").empty();
            $("#Scores").val("");
            var sc;
            $.get('${pageContext.request.contextPath}/jack/Ass',{value:data.value},function (data) {
                $("#aduitModelid").append("<option value=''>请选择</option>");
                for (var i = 0; i < data.names.length; i++) {
                    $("#aduitModelid").append("<option value='"+data.names[i].aduitModelid+"'>"+data.names[i].aduitName+"</option>");
                    sc = data.names[i].aduitModelid[0];
                }
                form.render("select");
            },"json");
            $.get('${pageContext.request.contextPath}/jack/emp',{value:data.value},function (data) {
                for (var i = 0; i < data.names.length; i++) {
                    $("#Empid").append("<option value='"+data.names[i].empId+"'>"+data.names[i].empName+"</option>");
                }
                form.render("select");
            },"json");
        });





    });
</script>
</html>
