<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/17
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>通知公告</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <button type="button" class="layui-btn" id="addNotice" style="margin-left: 25px;margin-top: 10px;" >
        <i class="layui-icon"></i> 添加
    </button>
    <table id="demo"  lay-filter="test"></table>
    <!--添加弹出窗-->
    <div  id="windows"  style="margin-left: 5%;display: none;">
        <form class="layui-form" method="post" action="${pageContext.request.contextPath}/zhq/addNotice" >
            <div class="layui-form-item" style="width: 500px;">
                <label class="layui-form-label">标题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">类别：</label>
                <div class="layui-input-inline">
                    <select name="noticeType" lay-filter="parentId">
                        <option value="1" selected>全体员工</option>
                        <option value="2">全体学生</option>
                        <option value="3">所有人</option>
                    </select>
                </div>
            </div>

            <textarea id="TT" name="content" style="display: none;"></textarea>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="sub">发布</button>
                    <button type="" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>

    <!--查看详情-->
    <div id="windows2"  style="display: none;">
        <table id="particulars2"  lay-filter="particulars3"></table>
    </div>

</body>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="particulars">审阅详情</a>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','layedit'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var layedit =layui.layedit;
        layedit.build('TT'); //建立编辑器
        layedit.build('TT2'); //建立编辑器
        //执行渲染
        table.render({
            elem: '#demo', //指定原始表格元素选择器（推荐id选择器）
            height: 356, //容器高度
            title:'宿舍管理',
            url:"${pageContext.request.contextPath}/zhq/selNotice",
            cols: [[ //标题栏
                {field: 'noticeId', title: '编号', width: 100, sort: true}
                ,{field: 'title', title: '标题', width: 250}
                ,{field: 'content', title: '通知内容', hide:true}
                , {
                    field: 'noticeType', title: '类别', width: 100, templet: function (d) {
                        if (d.noticeType === 1) {
                            return "员工"
                        } else if (d.noticeType === 2) {
                            return "学生"
                        }else if (d.noticeType === 3) {
                            return "所有人"
                        }
                    }
                }
                ,{field: 'empid', title: '发布人', width: 150}
                ,{field: 'noticeTime', title: '发布时间', width: 250 ,templet:'<div>{{ layui.util.toDateString(d.noticeTime,"yyyy-MM-dd HH:mm:ss ")}}</div>'}
                ,{field: 'trueContent', title: '已读人数', width: 100}
                ,{field: 'falseContent', title: '未读人数', width: 100}
                ,{fixed: 'right',  title:'操作', toolbar: '#barDemo',width:275}
            ]]
            ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        $("").on('click',function () {
            alert("dfdf");
        })

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            console.log(data);

            if(obj.event ==='del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/zhq/deleteNotice",
                        type:"post",
                        data:{
                            noticeId:obj.data.noticeId
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
            }else if(obj.event ==='edit'){//修改
                layer.open({
                    type: 2,
                    title:'修改通告',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '550px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/zhq/updateeNotice?noticeId='+data.noticeId]
                });
            }else if(obj.event==='detail'){//查看公告
                $.ajax({
                    url: '${pageContext.request.contextPath}/zhq/updateType',
                    data:{noticeId:data.noticeId},
                    type:"post",
                    success: function(data) {
                    }
                });

                layer.open({
                    type: 2,
                    title:'查看公告',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '550px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: ['${pageContext.request.contextPath}/zhq/LookNotice?noticeId='+data.noticeId],
                    cancel: function(index, layero){
                        layer.close(index);
                        table.reload('demo');
                    }
                })
            }else if(obj.event=== 'particulars'){
                //执行渲染
                table.render({
                    elem: '#particulars2', //指定原始表格元素选择器（推荐id选择器）
                    height: 'auto', //容器高度
                    title:'查看公告详情',
                    url:"${pageContext.request.contextPath}/zhq/selNoticeParticulars?noticeId="+data.noticeId +"&noticeType="+data.noticeType,
                    cols: [[ //标题栏
                        {field: 'title', title: '标题', sort: true}
                        ,{field: 'empid', title: '发布人', sort: true}
                        ,{field: 'noticeTime', title: '发布时间', width:250,templet:'<div>{{ layui.util.toDateString(d.noticeTime,"yyyy-MM-dd HH:mm:ss ")}}</div>'}
                        ,{field: 'js', title: '接收人', sort: true}
                        ,{field: 'isRead', title: '是否已读', sort: true,templet:function (d) {
                                if (d.isRead === 1){
                                    return"已读"
                                }else if(d.isRead === 2){
                                    return"未读"
                                }
                            }}
                    ]]
                });

                layer.open({
                    type: 1,
                    title:'查看公告详情',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['800','400'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#windows2')
                })
            }
        });

        <!--添加-->
        $("#addNotice").click(function () {
            layer.open({
                type: 1,
                title:'添加公告',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['700px', '550px'],
                fixed: false, //不固定
                maxmin: true,
                shadeClose: true, //开启遮罩关闭
                content: $('#windows')
            });
        })

    })
</script>
</html>
