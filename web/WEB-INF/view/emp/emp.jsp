<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/4
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../include.jsp"/>
<head>
    <title>员工展示页</title>
    <style>
        .layui-form-item{
            width: 120px;
        }
        .layui-form-select{
            width: 120px;
        }
        .layui-input-inline {
            width: 120px;
        }
        .layui-input{
            width: 120px;
        }
        .layui-form-item .layui-input-inline {
            width: 118px;
        }
    </style>
</head>
<body>
    <script type="text/html" id="top">
        <a class="layui-btn layui-btn-primary layui-btn-xs layui-icon-add-1" lay-event="detail" href="<%=request.getContextPath()%>/zeroEmp/toaddemp">新增员工</a>
            <label  class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">部门名称:</label>
                <div class="layui-input-inline">
                    <select id="depId" name="depId" lay-verify="required">
                        <option value="0">--未选择--</option>
                        <c:forEach var="d" items="${dep}">
                            <option value="${d.depid}">${d.depName}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 90px">员工姓名:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" id="empName" name="empName" value=""/>
                </div>
                <label class="layui-form-label" style="width: 90px">手机号码:</label>
                <div class="layui-input-inline">
                    <input class="layui-input"  name="Phone" id="Phone" value=""/>
                </div>
                <label class="layui-form-label">状态:</label>
                <div class="layui-input-inline">
                    <select id="status"  name="status" lay-verify="required">
                        <option value="100">--未选择--</option>
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <button id="seek" type="submit" class="layui-btn" onclick="seek()">搜索</button>
                </div>
            </label>
    </script>
    <script type="text/html" id="shezhi">
        {{#  if(d.status==1){ }}
        <a lay-event="switch">
            <input type="checkbox" name="statue" lay-skin="switch"<%--设置为开关--%>    checked   lay-text="启用|禁用"  value= {{ d.status}}  lay-filter="status" >
        </a>
        {{#  } else if(d.status==0) { }}
        <a lay-event="switch">
            <input class="layui-btn-xs" type="checkbox" name="statue" lay-skin="switch"  lay-event="switch" lay-text="启用|禁用"  value= {{ d.status}} lay-filter="status" >
        </a>
        {{#  } }}
   </script>
    <script type="text/html" id="pwd">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">重置密码</a>
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="other">其他信息</a>
        <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <table id="demo" lay-filter="test"></table>
</body>
<script>
    var table;
    layui.use('table', function(){
        table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 312
            ,url: '<%=request.getContextPath()%>/zeroEmp/allemp' //数据接口
            /*,where:{//设定异步数据接口的额外参数

            }*/
            ,id:"clientId"
            ,toolbar: '#top' //开启头部工具栏，并为其绑定左侧模板
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'empId', title: '编号', width:80, sort: true, fixed: 'left'}
                ,{field: 'empName', title: '员工姓名', width:100}
                ,{field: 'depName', title: '部门', width:100}
                ,{field: 'postName', title: '职务', width:160}
                ,{field: 'Sex', title: '性别', width:80,sort: true}
                ,{field: 'Phone', title: '手机号码', width: 150}
                ,{field: 'Address', title: '家庭地址', width: 200}
                //,{field: 'status', title: '状态', width: 80}
                ,{field: 'status', title: '设置状态', width: 100,toolbar:'#shezhi'}
                ,{field: 'reset', title: '初始密码',toolbar:'#pwd',width: 100}
                ,{field: 'caozuo', title: '操作',toolbar:'#barDemo', width: 200}
            ]]
            ,page: {limit:10,limits:[5,10,15,20],layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
            ,done: function(res, page, count){
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //分类显示中文名称
                $("[data-field='status']").children().each(function(){
                    if($(this).text()=='1'){
                        //$(this).text("启用")
                    }else if($(this).text()=='0'){
                        //$(this).text("禁用")
                    }
                })
            }
        });
        //监听工具条
        table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的DOM对象

            if(layEvent === 'detail'){ //重置密码
                //layer.msg('查看');
                layer.confirm('确定重置此用户的密码吗?', function(index){
                    //向服务端发送修改指令
                    layer.close(index);
                    $.post("<%=request.getContextPath()%>/zeroEmp/resetPwd/"+data.empId,{},function (d) {
                    },"text")
                });
            } else if(layEvent === 'del'){ //删除
                layer.confirm('真的删除此条数据吗?', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    layer.close(index);//关闭提示
                    //向服务端发送删除指令
                    $.post("<%=request.getContextPath()%>/zeroEmp/deleteEmp",{empId:data.empId},function (d) {
                    },"text")
                });
            } else if(layEvent === 'edit'){ //修改
                //layer.msg('编辑');
                //同步更新缓存对应的值
                /*obj.update({
                    username: '123'
                    ,title: 'xxx'
                });*/
                window.location.href="<%=request.getContextPath()%>/zeroEmp/toupdate/"+data.empId;
            } else if(layEvent === 'switch'){//设置状态
                //去数据库里修改状态
                $.post("<%=request.getContextPath()%>/zeroEmp/status",{empId:data.empId},function (d) {
                },"text")
            } else if(layEvent === 'other'){//当前员工的其他信息
                window.location.href="<%=request.getContextPath()%>/zeroEmpInfo/topage?empId="+data.empId;
            }
        });
    });
    //条件搜索
    function seek() {
        //部门id
        var depId = $("#depId").val();
        //员工姓名
        var empName = $("#empName").val();
        //手机号码
        var Phone = $("#Phone").val();
        //状态
        var status = $("#status").val();
        //layer.alert("部门id"+empId+"员工姓名"+empName+"手机号"+Phone+"状态"+status);
        table.reload('clientId',{
            url:'<%=request.getContextPath()%>/zeroEmp/seek',
            where:{
                depId:depId,
                empName:empName,
                Phone:Phone,
                status:status
            }
        })
        //搜索完把值传回去
        $("#depId").val(depId);
        $("#empName").val(empName);
        $("#Phone").val(Phone);
        $("#status").val(status);
    }
</script>
</html>
