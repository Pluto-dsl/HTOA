<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/12
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>公共信息</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <button type="button" class="layui-btn" id="addDoc" style="margin-top: 10px;margin-left: 25px;" >
        <i class="layui-icon"></i> 添加
    </button>

    <table id="demo"  lay-filter="test"></table>

    <div  id="windows"  style="display: none;">
            <div class="layui-upload uploadbuchong" style="margin-top: 20px;margin-left: 60px;">
                <button type="button"  class="layui-btn layui-btn-normal" id="test8" name="file">选择文件</button>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label" style="    margin-left: -50px;">备注</label>
                <div class="layui-input-block">
                    <textarea id="remark" name="remark" placeholder="请输入内容" class="layui-textarea" style=" margin-left: -50px;"></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" id="sub">确定添加</button>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="qx()">取消</button>
                </div>
            </div>
    </div>
</body>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a  class="layui-btn  layui-btn-xs" lay-event="download">下载文件</a>
</script>
<script>
    function qx() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);//关闭当前页
        window.location.reload();
    }
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var $ = layui.jquery
            ,upload = layui.upload;
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        <!--文件上传-->
        //选完文件后不自动上传
        upload.render({
            elem: '#test8'
            ,size:1024*50//限制文件大小，单位 KB
            ,auto: false//非自动上传
            ,accept:'file'
            ,multiple: true

        });

        $('#sub').click(function () {
            var file = $('.layui-upload-file')[0].files[0];
            var remark = $('#remark').val().trim();
            if (file == null) {
                layer.msg('请选择文件');
                return;
            }
            var lod = layer.load();
            var formData = new FormData();
            formData.append('file',file);
            formData.append('remark',remark);
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath}/zhq/addDoc',
                processData: false,//jquery 是否对数据进行 预处理
                contentType: false,//不要自己修改请求内容类型
                async:true,
                dataType:'json',
                data:formData,
                success:function (data) {
                    layer.close(lod);
                    layer.msg('上传成功');
                    location.reload();
                },
                error:function () {
                    layer.close(lod);
                    layer.msg('服务器错误，请稍后再试！');
                }
            });

        });



        //执行渲染
        table.render({
            elem: '#demo', //指定原始表格元素选择器（推荐id选择器）
            height: 'auto', //容器高度
            title:'宿舍管理',
            url:"${pageContext.request.contextPath}/zhq/selDoc",
            cols: [[ //标题栏
                {field: 'docId', title: '编号', width: 200, sort: true}
                ,{field: 'dataName', title: '资料名称', width: 300}
                ,{field: 'opTime', title: '上传时间', width: 200, templet: '<div>{{ layui.util.toDateString(d.feedbackTime,"yyyy-MM-dd")}}</div>'}
                ,{field: 'remark', title: '备注', width: 200}
                ,{field: 'empId', title: '上传人', width: 200}
                ,{field: 'url', title: '下载文件',hide:true/*templet:function (data) {
                        return '<a href="${pageContext.request.contextPath}\\'+data.url+'" download="'+data.dataName+'" class="layui-btn layui-bg-blue layui-btn-xs" >下载文件</a>'
                    }*/}
                ,{fixed: 'right',  title:'操作', toolbar: '#barDemo',width:200}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });
        <!--添加-->
        $("#addDoc").click(function () {
            layer.open({
                type: 1,
                title:'上传文件',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['400px', '300px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: false, //开启遮罩关闭
                content: $('#windows')
            })
        });



        table.on('tool(test)',function (obj) {
            var data = obj.data;
            if(obj.event ==='del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/zhq/deleteDoc",
                        type:"post",
                        data:{
                            docId:obj.data.docId
                        },
                        dataType:"json",
                        success: function (data) {
                            obj.del();
                            layer.close(index);
                            layer.msg('删除成功');
                            table.reload("demo");
                        },
                        error:function () {
                            obj.del();
                            layer.close(index);
                            layer.msg('删除成功');
                            table.reload("demo");
                        }
                    })
                });
            }else if(obj.event ==='download'){
                location.href='${pageContext.request.contextPath}/zhq/download.do?docId='+data.docId;
            }
        })
    })
</script>
</html>
