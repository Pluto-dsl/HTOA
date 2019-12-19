<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/15
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<input type="hidden" value="${num}" id="num" />
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        ddd();

        $(".layui-layer-setwin .layui-layer-close1").css("display","none");

        function ddd() {

            layer.confirm("请选择考评的对象", {
                btn: ['班主任', '授课老师'], //按钮
            }, function () {
                $.post('${pageContext.request.contextPath}/jack/ajax?type=headM',{},function (data) {
                    if(data === '2'){
                        layer.tips('本月已对班主任进行过考评了，请下个月再来吧~~~', '.layui-layer-btn0', {
                            tips: [4, '#78BA32']
                        });
                        return false;
                    }else {
                        layer.msg('进入班主任考评~~~', {icon: 1});
                        window.location.href='${pageContext.request.contextPath}/jack/toHeadmasterEva?type=Headmaster';
                    }
                },'text');

            }, function () {
                $.post('${pageContext.request.contextPath}/jack/ajax?type=teacherM',{},function (data) {
                    if(data === '1'){
                        layer.tips('本月已对授课老师考评过啦！下个月再来吧~~~', '.layui-layer-btn1', {
                            tips: [3,'#78BA32']
                        });

                    }else {
                        layer.msg('进入授课老师考评~~~', {icon: 1});
                        window.location.href='${pageContext.request.contextPath}/jack/toHeadmasterEva?type=Teachar';
                    }
                },'text');
                return false;
            });
        }

    });
</script>
</body>
</html>
