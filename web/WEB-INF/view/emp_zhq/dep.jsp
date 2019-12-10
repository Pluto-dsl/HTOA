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
        <form class="layui-form" action="" lay-filter="example" style="margin-right: 100px;margin-top: 35px;">
            <div class="layui-form-item">
                <label class="layui-form-label">部门名称</label>
                <div  class="layui-input-block">
                    <input id="depName" type="text" name="" required lay-verify="required" class="layui-input" readonly="readonly">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">上级部门</label>
                <div class="layui-input-block">
                    <input id="parentId" type="text" name="" required lay-verify="required" class="layui-input" readonly="readonly">
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">部门负责人</label>
                <div class="layui-input-block">
                    <input id="chaiman" type="text" name="" required lay-verify="required" class="layui-input" readonly="readonly">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea id="remark" class="layui-textarea" readonly="readonly"></textarea>
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
                edit:['update', 'del'],
                operate:function(obj){
                    var type = obj.type; //得到操作类型：add、edit、del
                    var data = obj.data; //得到当前节点的数据
                    var elem = obj.elem; //得到当前节点元素
                    console.log(elem);
                    console.log(data);
                    console.log(type);
                    if(type === 'update'){ //删除节点
                        var lod = layer.load();
                        //修改后的值
                        var updData = elem.find('.layui-tree-txt').html();
                        $.ajax({
                            url: "${pageContext.request.contextPath}/delUpdate",
                            type: "post",
                            async:true,
                            dataType: "json",
                            data:{
                                deptId:data.id,
                                depName:updData
                            },
                            success: function (data) {
                                layer.close(lod);
                                layer.msg('修改成功');
                            },
                            error:function () {
                                layer.close(lod);
                                layer.msg('修改失败');
                            }
                        });
                    }else if(type === 'del'){ //删除节点
                        var lod = layer.load();
                        $.ajax({
                            url: "${pageContext.request.contextPath}/delDept",
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
                                layer.msg('服务器错误');
                            }
                        });
                    };
                },
                click:function(obj){
                    var param2 = {
                        name:obj.data.title
                    };
                    var backdata2 = function(d){
                        $("#depName").val(d.depName);
                        $("#parentId").val(d.parentId);
                        $("#chaiman").val(d.chaiman);
                        $("#remark").val(d.remark);
                        //打开弹窗
                        layer.open({
                            type: 1,
                            title:'部门管理',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['700px', '430px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#windows')
                        });
                    };

                    $.post('${pageContext.request.contextPath}/selDepAll?type=treeOpen',param2,backdata2,"json");
                }
            });
        });
    };
    $.post('${pageContext.request.contextPath}/tree?type=tree',param,backdata,"json");



    <!--添加部门-->
    $("#add1").click(function () {
        layer.open({
            title:'添加部门',
            type:2,
            content:['${pageContext.request.contextPath}/selDep'],
            area: ['500px', '450px'],
            resize:false
        });
    }),







    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
    })
</script>
</html>
