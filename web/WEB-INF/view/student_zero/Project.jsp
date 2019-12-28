<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019-12-26
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>答辩项目管理</title>
    <jsp:include page="../include.jsp"/>
</head>
<script type="text/html" id="top">
    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i>新增</a>
    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i>修改</a>
</script>
<table id="demo"  lay-filter="t1"></table>
<div  id="window"  style="margin-left: 5%;display: none;">
    <form id="projectform" class="layui-form" style="margin-right: 100px;margin-top: 35px;" method="post">
        <div class="layui-form-item">
            <input type="hidden" id="projectId"  name="projectId" value="0"/>
            <label class="layui-form-label">项目名称:</label>
            <div  class="layui-input-block">
                <input maxlength="10" id="projectName" type="text" name="projectName" onchange="judgeproject()"  lay-verify="required" autocomplete="off" class="layui-input">
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
                <button type="submit" class="layui-btn" lay-submit lay-filter="projectAction" >保存</button>
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
            url:'<%=request.getContextPath()%>/StudentScore/allproject' , //数据接口,
            id: 't1',
            cols: [[ //表头
                {type:'radio',fixed:'left'},
                {field: 'projectId', title: '编号'},
                {field: 'projectName', title: '项目名称'},
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
                    $("#projectId").val(0);
                    yuan="";
                    win = layer.open({
                        type: 1,
                        title:'新增答辩项目',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['600px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#window')
                        ,cancel: function(index, layero){
                            //关闭清空表单
                            document.getElementById("projectform").reset();
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
                            title:'编辑答辩项目',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['600px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#window'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt) {
                                    $("#projectId").val(elemnt.projectId);
                                    $("#projectName").val(elemnt.projectName);
                                    yuan = elemnt.projectName;
                                    $("#remark").val(elemnt.remark);
                                });
                            },
                            cancel: function(index, layero){
                                //关闭清空表单
                                document.getElementById("projectform").reset();
                                $("#projectId").val(0);
                                return true;
                            }
                        });
                    }
                    break;
            }
            //新增或修改
            form.on('submit(projectAction)', function(data){
                var projectId =$("#projectId").val();
                var projectName =$("#projectName").val();
                var remark =$("#remark").val();
                $.ajax({
                    type: 'post',
                    url: "<%=request.getContextPath()%>/StudentScore/addproject", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:{
                        projectId:projectId,
                        projectName:projectName,
                        remark:remark,
                    },
                    success: function(data){
                        if(data=='ok'){
                            table.reload('t1')
                        }
                        layer.close(win);
                        layer.msg('保存成功!');
                        document.getElementById("projectform").reset();
                    }
                });
                return false;//禁止跳转，否则会提交两次，且页面会刷新
            });
        });
    })

    function judgeproject() {
        let projectName = $("#projectName").val();
        if(projectName!=yuan){
            $.post("<%=request.getContextPath()%>/StudentScore/judgeproject",{projectName:projectName},function (data) {
                if(data=="1"){
                    $("#projectName").val(yuan);
                    layer.msg("已有此项目，请重新输入！")
                }
            },"text")
        }
    }
</script>
</html>

