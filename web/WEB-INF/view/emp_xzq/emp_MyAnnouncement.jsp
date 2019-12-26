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
            white-space:nowrap;
            overflow:hidden;
            text-overflow:ellipsis;
            margin-left: 20px;
        }
        .layui-text h3 {
            font-size: 20px;
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
        <div class="layui-card layadmin-serach-main" style="box-shadow: 4px 5px 12px 0px rgba(0, 0, 0, 0.21)">
            <div class="layui-card-header">
                <p style="font-size: 22px;color: #333;text-indent: 0em;">
                    <span style="color:#2c0b44;">
                    <i style="font-size: 26px;" class="layui-icon layui-icon-speaker"></i>
                    公告
                    </span>
                    <span style="font-size: 12px;float: right;margin-left: 10px;">共<span id="count">122</span>条公告</span>
                    <span style="font-size: 12px;float: right;">未读取<span id="UnreadCount">14</span>条公告</span>
                </p>

            </div>
            <div class="layui-card-body" style="overflow: auto;height:260px;">
                <ul class="layadmin-serach-list layui-text">
                    <c:forEach items="${list}" var="list">
                        <li class="readWin">
                            <div class="layui-serachlist-text">
                                <h3 class="top" style="border-bottom: solid 1px #82828245;height: 25px;">
                                    <span class="title" style="margin-left: 10px;">${list.title}</span>
                                    <c:if test="${list.isRead == 2}">
                                        <i class="layui-icon layui-icon-notice" id="myTitle" style="margin-left:10px;"></i>
                                    </c:if>
                                    <span class="noticeTime" style="float: right;font-size: 12px;margin-left: 10px;margin-right:10px;">${list.noticeTime}</span>
                                    <span class="empName" style="float: right;font-size: 12px;">${list.empid}</span>
                                </h3>
                                <div class="content">
                                        ${list.content}
                                </div>
                                <input type="hidden" class="noticeId" value="${list.noticeId}">
                                <input type="hidden" class="isRead" value="${list.isRead}">
                                <button type="button" style="float: right;margin-top: -40px;background-color: #553bbc;" class="layui-btn layui-btn-sm layui-btn-warm See">详情</button>
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

            $(".readWin").hover(function (){
                $(".readWin").show();
            },function (){
                if($(this).find(".isRead").val() === "2"){
                    $(this).css("cursor","pointer");
                }
            });


            $(".See").on('click',function () {
                var content = $(this).siblings(".content").text();
                var title = $(this).siblings(".top").children(".title").text();
                var noticeTime = $(this).siblings(".top").children(".noticeTime").text();
                var empName = $(this).siblings(".top").children(".empName").text();
                var noticeId = $(this).siblings(".noticeId").val();
                $.get('${pageContext.request.contextPath}/jack/MyAddReadEmp',{noticeId:noticeId},function (da) {
                        window.location.reload();
                },"text");

                window.parent.layer.open({
                    type: 1,
                    title:'公告详情',
                    skin: 'layui-layer-demo', //样式类名
                    closeBtn: 1, //不显示关闭按钮
                    area: ['50%', '60%'],
                    fixed: false, //不固定
                    maxmin: true,
                    shadeClose: true, //开启遮罩关闭
                    content: '<div class="layui-card" id="SeeWin" >\n' +
                        '    <div class="layui-card-header">' +
                        '       <span style="float:right;margin-left: 5px"><i class="layui-icon layui-icon-username"></i><span>'+empName+'</span></span>' +
                        '       <span style="float:right"><i class="layui-icon layui-icon-log"></i><span>'+noticeTime+'</span></span>' +
                        '<span style="font-size: 25px;float: left">'+title+'</span>' +
                        '</div>\n' +
                        '\n' +
                        '    <div class="layui-card-body" id="seeboay" >\n' +
                        '        <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" id="Seebbb" lay-filter="LAY-index-pageone" lay-anim="fade">\n' +
                        ''+content+'' +
                        '        </div>\n' +
                        '\n' +
                        '    </div>\n' +
                        '</div>'
                });
            });

            function count(){
                $.post('${pageContext.request.contextPath}/jack/MyAnnoEmp',{},function (data) {
                    $("#count").text(data.count);
                    $("#UnreadCount").text(data.UnreadCount);
                },'json');
            }

            $(".readWin").on('click',function () {
                var noticeId = $(this).find(".noticeId").val();
                var isRead = $(this).find(".isRead").val();
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
