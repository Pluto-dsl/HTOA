<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/19
  Time: 8:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
    <style>
        p{
            margin-bottom: 20px;
            font-size: 13px;
            color: #949494;
            margin-top: 5px;
            text-indent: 2em;
            width: 50%;
            word-wrap: break-word;
            word-break: break-all;
            overflow: hidden;
        }
        .layui-text h3 {
            font-size: 18px;
            color: #222;
        }
        #myTitle{
            color: #ff0000;
        }
        li:hover{
            background-color: #EEE;
        }

    </style>
</head>
<body>
    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card layadmin-serach-main">
                    <div class="layui-card-header">
                        <p style="font-size: 22px;color: #333;text-indent: 0em;">
                            查询到<span id="count"></span>个结果
                        </p>
                    </div>
                    <div class="layui-card-body">
                        <ul class="layadmin-serach-list layui-text">
                            <c:forEach items="${list}" var="list">
                                <li class="readWin">
                                    <input type="hidden" class="noticeId" value="${list.noticeId}">
                                    <input type="hidden" class="isRead" value="${list.isRead}">
                                    <div class="layui-serachlist-text">
                                        <h3 style="border-bottom:solid 1px #82828245;">
                                            <span class="title">${list.title}</span>
                                            <c:if test="${list.isRead == 2}">
                                                <i class="layui-icon layui-icon-notice" id="myTitle" style="margin-left:10px;"></i>
                                            </c:if>
                                            <span style="float: right;font-size: 10px;margin-left: 10px;margin-right:10px;">${list.noticeTime}</span>
                                            <span style="float: right;font-size: 11px;">${list.empid}</span>
                                        </h3>
                                        <p class="content">${list.content}</p>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div id="LAY-template-search-page" style="text-align: center;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;
        count();

        function count(){
            $.post('${pageContext.request.contextPath}/jack/MyAnno',{},function (data) {
               $("#count").text(data.count);
            },'json');
        }

        $(".readWin").on('click',function () {
            var noticeId = $(this).children(".noticeId").val();
            var isRead = $(this).children(".isRead").val();
            console.log(isRead);
            console.log($(this).find("#myTitle"));
            if(isRead === '2'){
                $.get('${pageContext.request.contextPath}/jack/MyAddRead',{noticeId:noticeId},function (da) {
                    layer.msg("已读取");
                    window.location.reload()

                },"text");
            }

        });
    });
</script>
</html>
