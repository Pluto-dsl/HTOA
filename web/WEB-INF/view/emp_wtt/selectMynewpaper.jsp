<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 10:16
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
    <div id="windows" style="margin-left:5%; display: none;">
        <form class="layui-form" action="${pageContext.request.contextPath}/emp/update" method="post" style="text-align: center" lay-filter="formTestFilter">
            <input type="hidden" name="weeklogid">
            <h2 align="center" >正在修改周报中</h2><br>
            本周情况描述：<div style="margin-right:10px" class="layui-inline">
                            <textarea rows="5" cols="50" name="weekCur"/></textarea>
                        </div><br><br>
            问题学生情况反馈:<div style="margin-right:10px" class="layui-inline">
                                <textarea rows="5" cols="50" name="studentQuestion"/></textarea>
                            </div><br><br>
            意见建议：<div style="margin-right:10px" class="layui-inline">
                            <textarea rows="5" cols="50" name="Idea"/></textarea>
                        </div><br><br>
            下周工作计划：<div style="margin-right:10px" class="layui-inline">
                            <textarea rows="5" cols="50" name="weekNext"/></textarea>
                        </div><br><br>
            <button style="text-align: center" style="margin-left: 25%"  align="center" class="layui-btn layui-btn-warm" type="submit" ><i class="layui-icon layui-icon-ok" ></i>提交</button>
        </form>
    </div>

    <div style="margin-left:10px;margin-top:5px;float: left">
        开始日期:
        <div class="layui-inline">
            <input type="text" id="startTime" class="layui-input" name="startTime" autocomplete="off">
        </div>
    </div>
    <div style="margin-left:10px;margin-top:5px;float: left">
        结束日期:
        <div class="layui-inline">
            <input type="text" id="endTime" class="layui-input" name="endTime" lay-event="end" autocomplete="off">
        </div>
    </div>
    <!--搜索-->
    <button type="button" id="sousuo" style="margin-left:5%;margin-top:5px;" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon layui-icon-search"></i>搜索</button>

    <button id="addpaper" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left:43%"><i class="layui-icon layui-icon-add-circle"></i>添加</button>
    <%--头工具栏的批量删除--%>
    <script type="text/html" id="toolbar">
        <!--删除-->
        <button type="button" lay-event="all" class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i>批量删除</button>
    </script>

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


    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','laypage'],function () {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laypage = layui.laypage;
        var laydate = layui.laydate;
        var table_overloading =  table.render({
            elem:'#test',
            height:500,
            title:'周报表',
            toolbar:"#toolbar",
            url:'<%=request.getContextPath()%>/emp/selectEmpPaper',
            cols:[[
                {type:'checkbox', fixed:'left'}
                ,{field:'weeklogid',title:'编号', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'empName', title:'员工名称', width:100}
                ,{field:'Workday', title:'填写日期', width:170,sort:true ,templet:'<div>{{ layui.util.toDateString(d.Workday,"yyyy-MM-dd")}}</div>'}
                ,{field:'weekCur', title:'本周情况描述', width:200}
                ,{field:'studentQuestion', title:'问题学生情况反馈', width:200}
                ,{field:'Idea', title:'意见建议',width:200}
                ,{field:'weekNext', title:'下周工作计划', width:200}
                ,{fixed: 'right', width:300, title:'操作', align:'center', toolbar: '#barDemo'}
            ]]
            ,page:true,
            limits:[5,10,15,25]
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data =checkStatus.data;
            switch(obj.event){
                case 'all':
                    if(data.length==0){
                        layer.msg('请先选择要删除的数据行！');
                        return ;
                    }

                    var ids = "确定要删除id为:";
                    if(data.length>0){
                        for(var i = 0;i<data.length;i++){
                            ids+=data[i].weeklogid+",";
                        }
                    }
                    ids=ids.substr(0,ids.length-1);
                    ids+="的用户吗?三思";
                    layer.confirm(ids,function(index){

                        //JQuery的循环
                        $(data).each(function (index,element) {
                            delempnewpaper(element.weeklogid);
                            reurl();
                        })
                        /*obj.del();*/
                        /*layer.close(index);*/
                    });
                    /*obj.del();*/
            };
        });

        //行工具栏
        table.on('tool(test)', function(obj){
            var datas = obj.data;//获取当前行数据
            var event = obj.event;//获得lay-event 对应的值（编辑，删除）
            if(event == 'edit'){
                    layer.open({
                        type: 1,
                        title:'周报修改',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windows')
                    });
                    setFormValue(datas);//动态向表单赋值
            }else if(event=='del'){
                layer.confirm('真的删除行么',function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);
                    delempnewpaper(obj.data.weeklogid);
                });
            }else if(event=='select'){
                var id = obj.data.weeklogid;
                location.href='<%=request.getContextPath()%>/emp/lookEmpPaperPage/'+id;
            }
        });

        //获取该id的数据
        function setFormValue(data){
            console.log(data)
            form.val("formTestFilter", {
                "weeklogid":data.weeklogid
                ,"weekCur":data.weekCur
                ,"studentQuestion":data.studentQuestion
                ,"Idea":data.Idea
                ,"weekNext":data.weekNext
            });
            form.render(null,'formTestFilter')
        }

        //刷新
        function reurl(){
            url = location.href;
            self.location.replace(url);
        }

        //时间选择器
        laydate.render({
            elem: '#startTime',
            type: 'datetime',
            format:'yyyy/MM/dd',
            done: function (value) {
                startdate=value;
            }
        });
        //时间选择器
        laydate.render({
            elem: '#endTime',
            type: 'datetime',
            format:'yyyy/MM/dd',
            done: function (value) {
                startdate=value;
            }
        });

        //根据选择的日期查找出数据
        $("#sousuo").click(function () {
            //Jquery获取条件
            var startTime = $('input[name="startTime"]').val();
            var endTime = $('input[name="endTime"]').val();
            //调用重载方法
            table_overloading.reload({
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , method:'POST'
                ,where:{
                    startTime:startTime,
                    endTime:endTime
                }
            });
        })
    })
</script>
<script language="JavaScript">
    //删除
    function delempnewpaper(id) {
        var data = {id:id};
        $.post("<%=request.getContextPath()%>/emp/deleteEmpPaper",data,function (data) {

        },"json");
    }

    //
</script>
</html>