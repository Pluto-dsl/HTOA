<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/11
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>document</title>
    <jsp:include page="../include.jsp"/>
    <style>
        td{
            height: 150px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div style="width:100%;height:100%">
        <table align="center" style="width: 100%;height: 100%">
            <tr>
                <td align="center">
                    <div style="height: 30px" >
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        届别设置
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px">
                    <div style="height: 30px" href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                             data-url="${pageContext.request.contextPath}/student/classCategory"
                         data-id="班级类别" data-title="班级类别" >
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        班级类别
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                         data-url="${pageContext.request.contextPath}/toPage/dep"
                         data-id="部门管理" data-title="部门管理">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        部门管理
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <div style="height: 30px" onclick="" href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                         data-url="${pageContext.request.contextPath}/sysSet/toDeptList"
                         data-id="院系设置" data-title="院系设置">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        <span>院系设置</span>
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" onclick="" href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                         data-url="${pageContext.request.contextPath}/sysSet/toMajorPage"
                         data-id="专业设置" data-title="专业设置">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        专业设置
                    </div>
                </td>
                <td align="center">
                    <div style="height: 30px" onclick="" href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                         data-url="${pageContext.request.contextPath}/zhq/flow"
                         data-id="流程设置" data-title="流程设置">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        流程设置
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <div style="height: 30px">
                        <i class="layui-icon layui-icon-set" style="font-size:50px;color: #93D1FF"></i>
                        <br>
                        答辩项目
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
    <script>
        layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
            var element = layui.element;
            var $ = layui.jquery;
            //触发事件
                var active = {
                    //在这里给active绑定几项事件，后面可通过active调用这些事件
                    tabAdd: function (url, id, name) {
                        //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                        //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                        parent.layui.element.tabAdd('demo', {
                            title: name,
                            content: '<iframe data-frameid="' + id + '" frameborder="0" src="' + url + '" style="width:100%;height: 100%" id="test"></iframe>',
                            id: id //规定好的id
                        });
                        parent.layui.element.render('tab');

                    },
                    tabChange: function (id) {
                        //切换到指定Tab项
                        parent.layui.element.tabChange('demo', id); //根据传入的id传入到指定的tab项
                    }
                };

                $('.site-demo-active').on('click', function() {
                    var dataid = $(this);

                    //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li   的数目，即已经打开的tab项数目
                    if ($(".layui-tab-title li[lay-id]").length <= 0) {
                        //如果比零小，则直接打开新的tab项
                        active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
                    } else {
                        //否则判断该tab项是否以及存在

                        var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                        $.each($(".layui-tab-title li[lay-id]"), function () {
                            //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                            if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                                isData = true;
                            }
                        })
                        if (isData == false) {
                            //标志为false 新增一个tab项
                            active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"),dataid.attr("data-title"));
                        }
                    }
                    //最后不管是否新增tab，最后都转到要打开的选项页面上
                    active.tabChange(dataid.attr("data-id"));
                });
        });
    </script>
</html>