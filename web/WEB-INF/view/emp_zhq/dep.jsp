<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/4
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <button type="button" class="layui-btn" id="add1" style="margin-left: 25px;" >
        <i class="layui-icon"></i> 添加
    </button>
    <div id="tt"></div>
    <!--弹出窗-->
    <div  id="windows"  style="margin-left: 5%;display: none;">
        <form class="layui-form" method="post" action="${pageContext.request.contextPath}/zhq/delUpdate" lay-filter="example" style="margin-right: 100px;margin-top: 35px;">
            <input type="hidden" name="depid" id="depid">
            <input type="hidden" name="parentId" id="parentId">
            <div class="layui-form-item">
                <label class="layui-form-label">部门名称</label>
                <div  class="layui-input-block">
                    <input id="depName" name="depName" type="text" required lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">上级部门</label>
                <div class="layui-input-block">
                    <select name="parentIdName" lay-filter="parentIdName">
                        <option value="10007"  selected>宏图软件</option>
                        <c:forEach items="${depList}" var="dep">
                            <option value="${dep.depid}">${dep.depName}</option>
                        </c:forEach>
                    </select>
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">部门负责人</label>
                <div class="layui-input-block">
                    <select name="chairman" id="empName">
                        <c:forEach items="${empList}" var="emp">
                            <option value="${emp.empName}/${emp.empId}">${emp.empName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea name="remark" id="remark" class="layui-textarea" ></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">确定</button>
                </div>
            </div>
        </form>
    </div>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
            //查询部门
            var param = {
            };
            var backdata = function(d){

                layui.use('tree', function(){

                    var tree = layui.tree;
                    //渲染
                    tree.render({
                        elem: '#tt', //绑定元素
                        showLine: false,//是否为连线性
                        data:d,
                        edit:['del'],
                        operate:function(obj){
                            var type = obj.type; //得到操作类型：add、edit、del
                            var data = obj.data; //得到当前节点的数据
                            var elem = obj.elem; //得到当前节点元素
                            console.log(elem);
                            console.log(data);
                            console.log(type);
                           if(type === 'del'){ //删除节点
                                var lod = layer.load();
                                $.ajax({
                                    url: "${pageContext.request.contextPath}/zhq/delDept",
                                    type: "post",
                                    async:true,
                                    dataType: "json",
                                    data:{
                                        depId:data.id
                                    },
                                    success: function (data) {
                                        layer.close(lod);
                                        layer.msg('删除成功');
                                    },
                                    error:function () {
                                        layer.close(lod);
                                        layer.msg('删除成功');
                                    }
                                });
                            };
                        },

                        click:function(obj){//修改
                            var data = obj.data;
                            console.log(data);
                            $.ajax({
                                url:"${pageContext.request.contextPath}/zhq/selDepAll",
                                type:"post",
                                data:{
                                    id:obj.data.id
                                },
                                dataType:"json",
                                success: function (data) {
                                    console.log(data);
                                    form.val("example",{//赋值
                                        depid:data.list.depid,
                                        depName:data.list.depName,
                                        parentIdName:data.list.parentId,
                                        chairman:data.list.chairman+'/'+data.list.personnel,
                                        remark:data.list.remark,
                                    });
                                    layer.open({
                                        type: 1,
                                        title:'修改部门',
                                        skin: 'layui-layer-demo', //样式类名
                                        closeBtn: 1, //不显示关闭按钮
                                        area: ['700px', '430px'],
                                        fixed: false, //不固定
                                        maxmin: true,
                                        shadeClose: false, //开启遮罩关闭
                                        content: $('#windows')
                                    });
                                },
                                error:function () {

                                }
                            });
                        }
                    });
                });
            };
            $.post('${pageContext.request.contextPath}/zhq/tree',param,backdata,"json");



            <!--添加部门-->
            $("#add1").click(function () {
                layer.open({
                    title:'添加部门',
                    type:2,
                    content:['${pageContext.request.contextPath}/zhq/selDep'],
                    area: ['500px', '450px'],
                    resize:false
                });
            })

    })
</script>
</html>
