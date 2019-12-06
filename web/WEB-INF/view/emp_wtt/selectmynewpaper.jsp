<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>

<body>
    <div id="windows" style="margin-left: 5%;display: none;">
        <form class="layui-form" action="${pageContext.request.contextPath}/emp/" method="post" style="text-align: center">
            <input type="checkbox" name="weeklogid" value="${list.weeklogid}">
            <h2 align="center" >正在修改周报中</h2><br><br><br>
            本周情况描述：<div style="margin-right:10px" class="layui-inline">
                            <%--<input type="text" name="punckClockTime" class="layui-input" id="clockDate">--%>
                            <textarea rows="3" cols="40" name="weekCur" value="${list.weekCur}"/></textarea>
                        </div><br><br>
            问题学生情况反馈:<div style="margin-right:10px" class="layui-inline">
                                <%--<input type="text" name="punckClockTime" class="layui-input" id="clockDate">--%>
                                <textarea rows="3" cols="40" name="studentQuestion"/></textarea>
                            </div><br><br>
            意见建议：<div style="margin-right:10px" class="layui-inline">
                            <%--<input type="text" name="punckClockTime" class="layui-input" id="clockDate">--%>
                            <textarea rows="3" cols="40" name="Idea"/></textarea>
                        </div><br><br>
            下周工作计划：<div style="margin-right:10px" class="layui-inline">
                            <%--<input type="text" name="punckClockTime" class="layui-input" id="clockDate">--%>
                            <textarea rows="3" cols="40" name="weekNext"/></textarea>
                        </div><br><br>
            <button style="text-align: center" style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
        </form>
    </div>
    <button id="addpaper" class="layui-btn layui-btn-danger" style="margin-left: 50%">新增</button>
    <table class="layui-hide" lay-filter="test" id="test">

    </table>
    <script type="text/html" id="barDemo">
        <!--删除-->
        <button type="button" lay-event="del" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>删除</button>
        <!--编辑-->
        <button type="button" lay-event="edit" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>编辑</button>
        <!--查看周报-->
        <button type="button" lay-event="select" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon layui-icon-search"></i>查看周报</button>
    </script>
</body>
<script>
    //点击新增去到新增页面
    $("#addpaper").click(function () {
        location.href="<%=request.getContextPath()%>/emp/addEmpPaperPage";
    })

    //
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        table.render({
            elem:'#test',
            height:400,
            title:'周报表',
            url:'<%=request.getContextPath()%>/emp/selectEmpPaper',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'weeklogid',title:'编号', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'Empid', title:'员工名称', width:120}
                ,{field:'Workday', title:'填写日期', width:150,sort:true}
                ,{field:'weekCur', title:'本周情况描述', width:200}
                ,{field:'studentQuestion', title:'问题学生情况反馈', width:200}
                ,{field:'Idea', title:'意见建议',width:200}
                ,{field:'weekNext', title:'下周工作计划', width:200}
                ,{fixed: 'right', width:300, title:'操作', align:'center', toolbar: '#barDemo'}
            ]],
            page:true//开启分页
        });
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
            if(event == 'edit'){
                    updatempnewpaper(obj.data.weeklogid);
                    layer.open({
                        type: 1,
                        title:'周报修改',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '450px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windows')
                    });
            }else if(event=='del'){
                layer.confirm('真的删除行么',function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    delempnewpaper(obj.data.weeklogid)
                });
            }
        });
    })
</script>
<script language="JavaScript">
    //删除
    function delempnewpaper(id) {
        var data = {id:id};
        $.post("<%=request.getContextPath()%>/emp/deleteEmpPaper",data,function (data) {

        },"json");
    }
    //修改
    function updatempnewpaper(id) {
        var data = {id:id};
        $.post("<%=request.getContextPath()%>/emp/updateEmpPaper",data,function (data) {
            $.ajax({

            })
        },"json");
    }
</script>
</html>