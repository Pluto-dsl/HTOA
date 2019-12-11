<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/6
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
    <!--点击新增弹出来的框-->
    <div id="windows" style="margin-left:5%; margin-top:1%; display: none;">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/training/addtrial">
        <table align="center" style="border-collapse:separate; border-spacing:0px 20px;">
                <h1 align="center" >新增试讲培训</h1><br>
                <tr>
                    <th>日期:</th>
                    <td>
                        <input type="text" class="layui-input" id="riqi" placeholder="yyyy-MM-dd" name="date" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th>时间:</th>
                    <td>
                        <select name="time">
                            <option value="星期一">星期一</option>
                            <option value="星期二">星期二</option>
                            <option value="星期三">星期三</option>
                            <option value="星期四">星期四</option>
                            <option value="星期五">星期五</option>
                            <option value="星期六">星期六</option>
                            <option value="星期日">星期日</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>课程/章节:</th>
                    <td>
                        <select name="CourseId">
                            <c:forEach items="${course}" var="courselist">
                                <option value="${courselist.courseId}">${courselist.courseName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>授课类型:</th>
                    <td>
                        <select name="type">
                            <option value="1">试讲</option>
                            <option value="2">培训</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>授课老师:</th>
                    <td>
                        <select name="empId">
                            <c:forEach items="${emp}" var="emplist">
                                <option value="${emplist.empId}">${emplist.empName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>说明:</th>
                    <td>
                        <textarea rows="5" cols="50" name="remark"/></textarea>
                    </td>
                </tr>
                <tr align="center">
                    <td colspan="2">
                        <button style="text-align: center" style="margin-left: 25%" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>添加</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
<script type="text/html" id="toolbar">
    <button lay-event="add" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left: 50%"><i class="layui-icon layui-icon-add-circle"></i>添加</button>
    <!--批量删除-->
    <button type="button" lay-event="all" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>批量删除</button>
</script>

<table class="layui-hide" lay-filter="test" id="test"></table>

<script type="text/html" id="barDemo">
    <!--删除-->
    <button type="button" id="del" lay-event="del" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>删除</button>
</script>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','laypage'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laypage = layui.laypage;
        var laydate = layui.laydate;
        table.render({
            elem:'#test',
            toolbar:'#toolbar',
            height:500,
            title:'试讲培训',
            url:'<%=request.getContextPath()%>/training/selectshijiang',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'trialId',title:'编号', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'date', title:'日期', width:120,templet:'<div>{{ layui.util.toDateString(d.date,"yyyy-MM-dd")}}</div>'}
                ,{field:'time', title:'时间(星期一---星期日)', width:170,sort:true}
                ,{field:'courseId', title:'关联课程/章节id', width:200}
                ,{field:'type', title:'授课类型',templet:function (d) {
                        if (d.type === 1) {
                            return '试讲'
                        }else if(d.type === 2) {
                            return '培训'
                        }
                    }, width:200}
                ,{field:'empId', title:'授课老师',width:200}
                ,{field:'remark', title:'备注', width:200}
                ,{fixed: '', width:300, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            ,page:true,
            limits:[5,10,15,25]
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data =checkStatus.data;
            switch(obj.event){
                case 'add':
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
                case 'all':
                    if(data.length==0){
                        layer.msg('请先选择要删除的数据行！');
                        return ;
                    }

                    var ids = "确定要删除id为:";
                    if(data.length>0){
                        for(var i = 0;i<data.length;i++){
                            ids+=data[i].trialId+",";
                        }
                    }
                    ids=ids.substr(0,ids.length-1);
                    ids+="的用户吗?三思";
                    layer.confirm(ids,function(){
                        /*layer.close(index);*/
                        //JQuery的循环
                        $(data).each(function (index,element) {
                            deletetrial(element.trialId);
                            reurl();
                        })
                    });
            };
        });

        //行工具栏
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
            if(event=='del'){
                layer.confirm('真的删除行么',function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    deletetrial(obj.data.trialId);
                });
            }
        });

        //日期
        laydate.render({
            elem: '#riqi',
            type: 'datetime',
            format:'yyyy/MM/dd',
            done: function (value) {
                startdate=value;
            }
        });

        //刷新
        function reurl(){
            url = location.href;
            self.location.replace(url);
        }
    })

    //删除的方法
    function deletetrial(id) {
        var data = {id:id};
        $.post("<%=request.getContextPath()%>/training/deletetrial",data,function (data) {

        },"json");
    }
</script>
</html>