<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/6
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp"></jsp:include>
</head>
<body>
<!--点击新增弹出来的框-->
<div id="windows" style="margin-left:5%; margin-top:3%; display: none;">
    <form class="layui-form" method="post" style="text-align: center" action="<%=request.getContextPath()%>/arrange/addarrange">
        <table align="center" style="border-collapse:separate; border-spacing:0px 20px;">
            <h1 align="center" >新增值班</h1><br>
            <tr>
                <th>员工:</th>
                <td>
                    <select name="empId">
                        <c:forEach items="${emplist}" var="list">
                            <option value="${list.empId}">${list.empName}</option>
                        </c:forEach>
                    </select>
                </td>
                <th>第几位值班:</th>
                <td>
                    <input type="text" class="layui-input" name="orderId" autocomplete="off" lay-verify="required|number">
                </td>
            </tr>

            <tr>
                <th>排班名称:</th>
                <td>
                    <select name="weekArrangeName">
                        <c:forEach items="${postlist}" var="list">
                            <option value="${list.postName}">${list.postName}</option>
                        </c:forEach>
                    </select>
                    <%--<input type="text" class="layui-input" name="weekArrangeName" autocomplete="off" lay-verify="required">--%>
                </td>
                <th>值班要求:</th>
                <td>
                    <input type="text" class="layui-input" name="ranges" autocomplete="off" lay-verify="required">
                </td>
            </tr>
            <tr>
                <th>开始时间:</th>
                <td>
                    <input type="text" id="startTime" class="layui-input" name="startTime" autocomplete="off" lay-verify="required">
                </td>

                <th>结束时间:</th>
                <td>
                    <input type="text" id="endTime" class="layui-input" name="endTime" autocomplete="off" lay-verify="required">
                </td>
            </tr>

            <tr>
                <th>星期:</th>
                <td>
                    <select name="week">
                        <option value="星期一">星期一</option>
                        <option value="星期二">星期二</option>
                        <option value="星期三">星期三</option>
                        <option value="星期四">星期四</option>
                        <option value="星期五">星期五</option>
                        <option value="星期六">星期六</option>
                        <option value="星期日">星期日</option>
                    </select>
                </td>
                <th>总值班:</th>
                <td>
                    <select name="duty">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>说明:</th>
                <td colspan="4">
                    <textarea rows="5" cols="60" name="remark" lay-verify="required"/></textarea>
                </td>
            </tr>
            <tr align="center">
                <td colspan="4" >
                    <button style="text-align: center" class="layui-btn layui-btn-warm" type="submit" lay-submit><i class="layui-icon layui-icon-ok" ></i>添加</button>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/html" id="toolbar">
    <button lay-event="add" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left: 50%"><i class="layui-icon layui-icon-add-circle"></i>添加</button>
    <!--删除-->
    <button type="button" lay-event="all" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>批量删除</button>
</script>

<table class="layui-hide" lay-filter="test" id="test"></table>

<script type="text/html" id="barDemo">
    <!--删除-->
    <button type="button" lay-event="del" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>删除</button>
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
        var $ = layui.jquery;
        table.render({
            elem:'#test',
            toolbar:'#toolbar',
            height:500,
            title:'值班管理',
            url:'<%=request.getContextPath()%>/arrange/selectarrange',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'weekArrangeId',title:'排序编号', width:110, fixed: 'left', unresize: true, sort: true}
                ,{field:'weekArrangeName', title:'排班名称', width:120}
                ,{field:'ranges', title:'值班要求', width:170,sort:true}
                ,{field:'week', title:'星期一~日', width:100}
                ,{field:'empId', title:'值班老师',width:100}
                ,{field:'orderId', title:'排序',width:100}
                ,{field:'duty', title:'总值班', width:100,templet:function (data) {
                        if(data.duty == '0'){
                            return '否'
                        }else if(data.duty == '1'){
                            return '是'
                        }
                    }}
                ,{field:'startTime', title:'开始时间', width:100}
                ,{field:'endTime', title:'结束时间', width:100}
                ,{field:'remark', title:'说明', width:300}
                ,{fixed: '', width:180, title:'操作', align:'center', toolbar: '#barDemo'}
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
                        area: ['900px', '650px'],
                        fixed: false, //不固定
                        maxmin: true,
                        content: $('#windows'),
                        shadeClose: false, //开启遮罩关闭
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
                            ids+=data[i].weekArrangeId+",";
                        }
                    }
                    ids=ids.substr(0,ids.length-1);
                    ids+="的用户吗?三思";
                    layer.confirm(ids,function(){
                        /*layer.close(index);*/
                        //JQuery的循环
                        $(data).each(function (index,element) {
                            deletearrange(element.weekArrangeId);
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
                layer.confirm('你准备好了吗',function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    deletearrange(obj.data.weekArrangeId)
                });
            }
        });


        //时间选择器
        var start = laydate.render({
            elem: '#startTime',
            type: 'time',
            done: function(value,date) {
                endMax = end.config.max;
                end.config.min = date;
                end.config.min.month = date.month -1;
                end.config.min.minutes = date.minutes+30
            }
        });

        var end = laydate.render({
            elem:"#endTime",
            type: 'time',
            done: function(value,date) {
                if($.trim(value) == ''){
                    var curDate = new Date();
                    date = {'date': curDate.getDate(), 'month': curDate.getMonth()+1, 'year': curDate.getFullYear()};
                }
                start.config.max = date;
                start.config.max.month = date.month -1;
                start.config.min.minutes = date.minutes+30
            }
        });

        //刷新
        function reurl(){
            url = location.href;
            self.location.replace(url);
        }
    })

    //删除的方法
    function deletearrange(id) {
        var data = {id:id};
        $.post("<%=request.getContextPath()%>/arrange/deletearrange",data,function (data) {

        },"json");
    }
    
    function duty() {
        
    }
</script>
</html>