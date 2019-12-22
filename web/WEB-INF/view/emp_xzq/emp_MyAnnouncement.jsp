<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/20
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
    <style>
        .content{
            margin-bottom: 20px;
            font-size: 13px;
            color: #949494;
            margin-top: 5px;
            width:60%;
            word-wrap: break-word;
            word-break: break-all;
            overflow: hidden;
            margin-left: 20px;
        }
        .layui-text h3 {
            font-size: 18px;
            color: #222;
        }
        #myTitle{
            color: #ff0000;
        }
        li{
            transition: 0.3s;
            border-left: solid #ffffff;
        }
        li:hover{
            border-left:solid;
        }
        .layui-card-header {
            position: relative;
            height: 42px;
            line-height: 42px;
            padding: 0 15px;
            border-top: solid;
            border-bottom: 10px solid #f6f6f6;
            color: #333;
            border-radius: 2px 2px 0 0;
            font-size: 14px;
        }
        .layui-col-space15>* {
            padding: 1.5px;
        }
    </style>
</head>
<body>
<%--公告部分--%>
<div class="layui-row layui-col-space15" style="width:85%;margin: 10px 10px;">
    <div class="layui-col-md12">
        <div class="layui-card layadmin-serach-main">
            <div class="layui-card-header">
                <p style="font-size: 22px;color: #333;text-indent: 0em;">
                    公告
                    <span style="font-size: 11px;float: right;margin-left: 10px;">共<span id="count">122</span>条公告</span>
                    <span style="font-size: 11px;float: right;">未读取<span id="UnreadCount">14</span>条公告</span>
                </p>

            </div>
            <div class="layui-card-body" style="overflow: auto;height:260px;">
                <ul class="layadmin-serach-list layui-text">
                    <c:forEach items="${list}" var="list">
                        <li class="readWin">
                            <input type="hidden" class="noticeId" value="${list.noticeId}">
                            <input type="hidden" class="isRead" value="${list.isRead}">
                            <div class="layui-serachlist-text">
                                <h3 style="border-bottom: solid 1px #82828245;height: 25px;">
                                    <span class="title" style="margin-left: 10px;">${list.title}</span>
                                    <c:if test="${list.isRead == 2}">
                                        <i class="layui-icon layui-icon-notice" id="myTitle" style="margin-left:10px;"></i>
                                    </c:if>
                                    <span style="float: right;font-size: 10px;margin-left: 10px;margin-right:10px;">${list.noticeTime}</span>
                                    <span style="float: right;font-size: 11px;">${list.empid}</span>
                                </h3>
                                <div class="content">
                                        ${list.content}
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <div id="LAY-template-search-page" style="text-align: center;"></div>
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
            //查询公告条数
            count();

            function count(){
                $.post('${pageContext.request.contextPath}/jack/MyAnnoEmp',{},function (data) {
                    $("#count").text(data.count);
                    $("#UnreadCount").text(data.UnreadCount);
                },'json');
            }

            $(".readWin").on('click',function () {
                var noticeId = $(this).children(".noticeId").val();
                var isRead = $(this).children(".isRead").val();
                console.log(isRead);
                console.log($(this).find("#myTitle"));
                if(isRead === '2'){
                    $.get('${pageContext.request.contextPath}/jack/MyAddReadEmp',{noticeId:noticeId},function (da) {
                        layer.msg("已读取");
                        count();
                        setTimeout(function () {
                            window.location.reload();
                        },900);

                    },"text");
                }

            });
        });
    </script>
</html>
