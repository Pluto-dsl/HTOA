<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/23
  Time: 10:54
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
    <table class="layui-hide" id="test" lay-filter="test"></table>
</body>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button lay-event="addEnr" class="layui-btn layui-btn-sm" ><i class="layui-icon layui-icon-add-1" style="font-size: 30px;"></i>添加</button>
        <button lay-event="del" class="layui-btn layui-btn-sm layui-btn-danger" ><i class="layui-icon layui-icon-delete"></i>批量删除</button>
    </div>
</script>
<script type="text/html" id="toolDemo">
    <button lay-event="edit" class="layui-btn layui-btn-sm layui-btn-danger" ><i class="layui-icon layui-icon-edit"></i>编辑</button>
</script>
<script type="text/javascript">
    function createTime(v){
        if(v == undefined || v ==''){
            return "";
        }else {
            var date = new Date(v);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? '0' + m : m;
            var d = date.getDate();
            d = d < 10 ? ("0" + d) : d;
            var h = date.getHours();
            h = h < 10 ? ("0" + h) : h;
            var M = date.getMinutes();
            M = M < 10 ? ("0" + M) : M;
            var str = y + "-" + m + "-" + d + " " + h + ":" + M;
            return str;
        }
    }
</script>
<script>
    var dataE;
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;


        //执行一个laydate实例
        laydate.render({
            elem: '#clockDate' //指定元素
        });

        //考勤列表
        table.render({
            elem: '#test'
            ,url:'${pageContext.request.contextPath}/jack/Enrollment'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar:{}//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox',fixed: 'left',unresize:true,sort: true}
                ,{field:'studName', title:'学生姓名', width:120}
                ,{field:'card', title:'身份证号', width:120}
                ,{field:'sex', title:'性别', width:120}
                ,{field:'tell', title:'手机号', width:120}
                ,{field:'school', title:'学校', width:120}
                ,{field:'classes', title:'班级', width:120}
                ,{field:'amount', title:'预定报名费', width:120}
                ,{field:'testTime',templet:function (d){return createTime(d.startTime);}, title:'试学时间', width:120}
                ,{field:'enrollMoneyTime',templet:function (d){return createTime(d.startTime);}, title:'发放时间', width:120}
                ,{field:'signdate',templet:function (d){return createTime(d.signdate);}, title:'录入时间', width:120}
                ,{field:'empid', title:'录入人', width:120}
                ,{field:'status', title:'学生状态', width:120}
                ,{field:'remark', title:'员工姓名', width:120}
                ,{field:'studType', title:'班级类别', width:120}
                ,{field:'score', title:'学习成绩', width:120}
                ,{field:'enrollMoneyTime',templet:function (d){return createTime(d.enrollMoneyTime);}, title:'发放时间', width:120}
                ,{field:'reviewStatus', title:'报名费状态', width:120}
                ,{field:'negativeName', title:'招生老师', width:120}
                ,{field:'reviewer', title:'审核人', width:120}
                ,{field:'reviewerTime',templet:function (d){return createTime(d.reviewerTime);}, title:'审核时间', width:120}
                ,{field:'majorId', title:'学生专业', width:120}
                ,{toolbar:'#toolDemo',fixed:'right',unresize:true,sort: true, title:'操作', width:100}
            ]]
            ,page: true
            ,limit:15
            ,limits: [15, 25, 35, 45, 55]
            // ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            //     layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
            //     //,curr: 1 //设定初始在第 1 页
            //     ,groups: 3 //只显示 1 个连续页码
            //     ,first: true //不显示首页
            //     ,last: true //不显示尾页
            // }

        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            dataE = obj.data;
            if(obj.event === 'edit'){
                console.log(data);
                layer.open({
                    type: 2,
                    title:'修改招生信息',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['750px', '600px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/toEditEnrollment?id='+data.enrollmentid,'no'],
                    cancel: function(index, layero){
                        layer.close(index);
                        table.reload('test');
                        return false;
                    }
                });

            }

        });

        //新增招生学生、批删 听表格头的按钮'toolbar(test)'
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus('test');
            var data = obj.data;
            if(obj.event == 'addEnr'){
                layer.open({
                    type: 2,
                    title:'招生新增',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['750px', '600px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: false, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/jack/toAddEnrollmentPage','no'],
                    cancel: function(index, layero){
                        layer.close(index);
                        table.reload('test');
                        return false;
                    }
                });
            }else if(obj.event == 'del'){
                var ids = [];
                $(checkStatus.data).each(function (i, o) {//o即为表格中一行的数据
                    ids.push(o.enrollmentid);
                });
                if (ids.length < 1) {
                    layer.msg('无选中项');
                    return false;
                }
                layer.confirm('真的删除行么', function(index){
                    for(var a= 0;a<ids.length;a++){
                        $.get("${pageContext.request.contextPath}/jack/delEnrollment?id="+ids[a],function (d) {
                            layer.msg('删除成功');
                            table.reload('test');
                        });
                    }
                    table.reload('test');
                    layer.close(index);
                });

            }
        });
    });
    function xxx() {
        console.log("dfdfdf");
        return dataE;
    }
</script>
</html>
