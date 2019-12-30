<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019-12-20
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>界别管理</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <script type="text/html" id="top">
        <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i>新增</a>
        <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i>修改</a>
    </script>
    <table id="demo"  lay-filter="t1"></table>

    <div  id="window"  style="margin-left: 5%;display: none;">
        <form id="fallform" class="layui-form" style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <input type="hidden" id="fallid"  name="fallid" value="0"/>
                <label class="layui-form-label">届别:</label>
                <div  class="layui-input-block">
                    <input maxlength="4" id="level" autocomplete="off" type="text" name="level" onchange="judgelevel()"  lay-verify="required|number" class="layui-input">
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
                    <button type="submit" class="layui-btn" lay-submit lay-filter="jobAction" >保存</button>
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
            url:'<%=request.getContextPath()%>/zeroStudent/StudentFall' , //数据接口,
            id: 't1',
            cols: [[ //表头
                {type:'radio',fixed:'left'},
                {field: 'fallid', title: '编号'},
                {field: 'level', title: '届别名称'},
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
                    $("#fallid").val(0);
                    yuan="";
                    win = layer.open({
                        type: 1,
                        title:'新增届别',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['600px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#window')
                        ,cancel: function(index, layero){
                            //关闭清空表单
                            document.getElementById("fallform").reset();
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
                            title:'编辑届别',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['600px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#window'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt) {
                                    $("#fallid").val(elemnt.fallid);
                                    $("#level").val(elemnt.level);
                                    yuan = elemnt.level;
                                    $("#remark").val(elemnt.remark);
                                });
                            },
                            cancel: function(index, layero){
                                //关闭清空表单
                                document.getElementById("fallform").reset();
                                $("#fallid").val(0);
                                return true;
                            }
                        });
                    }
                    break;
            }
            //新增或修改
            form.on('submit(jobAction)', function(data){
                $.ajax({
                    type: 'post',
                    url: "<%=request.getContextPath()%>/zeroStudent/addFall", // ajax请求路径
                    async:true,
                    dataType: "text",
                    data:data.field,
                    success: function(data){
                        if(data=='yes'){
                            table.reload('t1')
                        }
                        layer.close(win);
                        layer.msg('保存成功!');
                        document.getElementById("fallform").reset();
                    }
                });
                return false;//禁止跳转，否则会提交两次，且页面会刷新
            });
        });
    })

    function judgelevel() {
         let level = $("#level").val();
         if(level!=yuan){
             $.post("<%=request.getContextPath()%>/zeroStudent/judgeLevel",{level:level},function (data) {
                 if(data=="1"){
                     $("#level").val(yuan);
                     layer.msg("已有此届别，请重新输入！")
                 }
             },"text")
         }
    }
</script>
</html>
