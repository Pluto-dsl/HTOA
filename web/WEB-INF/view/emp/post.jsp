<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019-12-26
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>岗位设置</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
<script type="text/html" id="top">
    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i>新增</a>
    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i>修改</a>
</script>
<table id="demo"  lay-filter="t1"></table>
<div  id="window"  style="margin-left: 5%;display: none;">
    <form id="postform" class="layui-form" style="margin-right: 100px;margin-top: 35px;" method="post">
        <div class="layui-form-item">
            <input type="hidden" id="postId"  name="postId" value="0"/>
            <label class="layui-form-label">岗位名称:</label>
            <div  class="layui-input-block">
                <input maxlength="10" id="postName" type="text" name="postName" onchange="judgelevel()"  lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">说明:</label>
            <div class="layui-input-block">
                <textarea maxlength="100" id="remark" name="remark" class="layui-textarea"> </textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit lay-filter="postAction" >保存</button>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    var yuan;
    layui.use(['table','form'],function() {
        var form = layui.form;
        var table = layui.table;
        table.render({
            elem: '#demo',
            height: 600,
            toolbar: '#top', //开启头部工具栏，并为其绑定左侧模板
            url:'<%=request.getContextPath()%>/zeroEmp/allPost' , //数据接口,
            id: 't1',
            cols: [[ //表头
                {type:'radio',fixed:'left'},
                {field: 'postId', title: '编号'},
                {field: 'postName', title: '岗位名称'},
                {field: 'remark', title: '备注'}
            ]]

        })
        //头部工具栏
        var win;
        table.on('toolbar(t1)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch(obj.event){
                case 'add':
                    $("#postId").val(0);
                    yuan="";
                    win = layer.open({
                        type: 1,
                        title:'新增岗位',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['600px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#window')
                        ,cancel: function(index, layero){
                            //关闭清空表单
                            document.getElementById("postform").reset();
                            return true;
                        }
                    });
                    break;
                case 'edit'://修改
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    }else {
                        win = layer.open({
                            type: 1,
                            title:'编辑岗位',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['600px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#window'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt) {
                                    $("#postId").val(elemnt.postId);
                                    $("#postName").val(elemnt.postName);
                                    $("#dep").val(elemnt.depId);
                                    yuan = elemnt.postName;
                                    $("#remark").val(elemnt.remark);
                                });
                            },
                            cancel: function(index, layero){
                                //关闭清空表单
                                document.getElementById("postform").reset();
                                $("#postId").val(0);
                                return true;
                            }
                        });
                    }
                    break;
            }
            //新增或修改
            form.on('submit(postAction)', function(data){
                $.ajax({
                    type: 'post',
                    url: "<%=request.getContextPath()%>/zeroEmp/addPost", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:data.field,
                    success: function(data){
                        if(data=='ok'){
                            table.reload('t1')
                        }
                        layer.close(win);
                        layer.msg('保存成功!');
                        document.getElementById("postform").reset();
                    }
                });
                return false;//禁止跳转，否则会提交两次，且页面会刷新
            });
        });
    })

    function judgelevel() {
        let postName = $("#postName").val();
        if(postName!=yuan){
            $.post("<%=request.getContextPath()%>/zeroEmp/judgePost",{postName:postName},function (data) {
                if(data=="1"){
                    $("#postName").val(yuan);
                    layer.msg("已有此岗位，请重新输入！")
                }
            },"text")
        }
    }
</script>
</html>
