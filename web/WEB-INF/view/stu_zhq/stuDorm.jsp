<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/10
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宿舍管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <button type="button" class="layui-btn" id="addDorm" style="margin-left: 25px;" >
        <i class="layui-icon"></i> 添加
    </button>
    <table id="demo"  lay-filter="test"></table>
    <!--修改-->
    <div  id="windows"  style="margin-left: 5%;display: none;">
        <form method="post" class="layui-form" lay-filter="aaa" action="${pageContext.request.contextPath}/updateDorm">
            <input type="hidden" name="hourid" id="hourid">
            <div class="layui-form-item">
                <label class="layui-form-label">宿舍楼栋：</label>
                <div class="layui-input-block">
                    <select name="floorId" id="floorName">
                        <c:forEach items="${floor}" var="l">
                            <option value="${l.floorId}">${l.floorName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">宿舍房号：</label>
                <div class="layui-input-inline">
                    <input type="text" id="huorName" name="huorName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">床位数：</label>
                <div class="layui-input-inline">
                    <input type="text" id="numberBeds" name="numberBeds" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">宿舍地址：</label>
                <div class="layui-input-inline">
                    <input type="text" id="addr" name="addr" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="sub">确定</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <!--查看-->
    <div id="windows2"  style="display: none;">
        <table id="demo2"  lay-filter="test"></table>
    </div>

</body>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        //执行渲染
        table.render({
            elem: '#demo', //指定原始表格元素选择器（推荐id选择器）
            height: 356, //容器高度
            title:'宿舍管理',
            url:"${pageContext.request.contextPath}/selDorm",
            cols: [[ //标题栏
                {field: 'hourid', title: '编号', width: 150, sort: true}
                ,{field: 'huoeIddsc', title: '序号', width: 150}
                ,{field: 'huorName', title: '宿舍房号', width: 150}
                ,{field: 'floorId', title: '楼栋', width: 150,hide:'true'}
                ,{field: 'floorName', title: '楼栋名称', width: 150}
                ,{field: 'numberBeds', title: '床位数', width: 150}
                ,{field: 'count', title: '宿舍人数', width: 150}
                ,{field: 'addr', title: '宿舍地址', width: 150}
                ,{fixed: 'right',  title:'操作', toolbar: '#barDemo',width:270}
            ]]
           ,page: {limit: 5,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        });

        table.on('tool(test)',function (obj) {
            var data = obj.data;
            console.log(data);

            form.val("aaa",{//赋值
                hourid:data.hourid,
                floorId:data.floorId,
                huorName:data.huorName,
                numberBeds:data.numberBeds,
                addr:data.addr
            });
            if(obj.event ==='del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/deleteStuDorm",
                        type:"post",
                        data:{
                            stuId:obj.data.hourid
                        },
                        dataType:"json",
                        success: function (data) {
                            obj.del();
                            layer.close(index);
                            layer.msg('删除成功');
                        },
                        error:function () {
                            obj.del();
                            layer.close(index);
                            layer.msg('删除成功');
                        }
                    })
                });
            }else if(obj.event ==='edit'){//修改
                layer.open({
                    type: 1,
                    title:'修改宿舍',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['700px', '430px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#windows')
                });
            }else if(obj.event ==='detail'){//查看
                //执行渲染
                table.render({
                    elem: '#demo2', //指定原始表格元素选择器（推荐id选择器）
                    height: 356, //容器高度
                    title:'查看宿舍学生',
                    url:"${pageContext.request.contextPath}/selStuDormit?id="+data.hourid,
                    cols: [[ //标题栏
                        {field: 'huorName', title: '宿舍房号', width: 150}
                        ,{field: 'className', title: '所在班级', width: 200}
                        ,{field: 'stuName', title: '学生姓名', width: 100}
                        ,{field: 'phone', title: '学生号码', width: 150}
                    ]]
                });

                layer.open({
                    type: 1,
                    title:'查看宿舍学生',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['600px', '430px'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: $('#windows2')
                })
            }

        });


        <!--添加-->
        $("#addDorm").click(function () {
            layer.open({
                title:"添加宿舍",
                type:2,
                content:['${pageContext.request.contextPath}/addStuDormit'],
                area:['500','400'],
                resize:false
            })
        })
    })
</script>
</html>
