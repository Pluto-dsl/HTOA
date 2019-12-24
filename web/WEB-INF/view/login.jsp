<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/9
  Time: 9:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HT软件</title>
    <jsp:include page="include.jsp" />
    <style>
        a{
            color: #fff;
        }
        #Bcontext{
            width: 100%;
            height: 100%;
            background-image:url("${pageContext.request.contextPath}/imgs/login/backgroundImg.jpg");
            float: left;

        }
        #login{
            opacity: 0;
            left: 50%;
            top: 10%;
            width: <spring:message code="login-width-before"/>;
            height: <spring:message code="login-height-before"/>;
            background-color: white;
            position: absolute;
            transition: all 0.5s;
            transition-timing-function:ease;
            box-shadow: 5px 7px 18px 5px #1f1f1f;
            border-radius: 3px;
            z-index: 100;
        }
        #top{
            z-index: 50;
            position: absolute;
            width: 85%;
            height: <spring:message code="top-height"/>;
            padding-left: 15%;
            padding-top: 10px;
            top: 0px;
            background-color: #00000075;
        }
        .title{
            margin-top: 12%;
            margin-left: <spring:message code="title-margin-left"/>;
            padding-bottom: 3%;
            width: 100%;
            font-size: <spring:message code="title-font-size"/>;
            color: #424242;
            font-family: "微软雅黑 Light";
            font-weight: 600;
            float: left;
        }
        .hr{
            background-color: #9F9F9F;
            width: <spring:message code="hr-width"/>;
            height: 2px;
            float: left;
        }
        .login-row{
            width: 100%;
            margin-top: 5%;
            float: left;
        }
        .login-icon{
            margin-top: 6px;
            font-size: <spring:message code="login-icon-font-size"/>;
            color: #333;
            float: left;
        }
        .login-submit{
            pointer-events: none;
            color: #a29e9e;
            width: 100%;
            height: <spring:message code="login-submit-height"/>;
            margin-top: 3%;
            font-size: <spring:message code="login-submit-font-size"/>;
            float: left;
        }
        .drag{
            width: <spring:message code="drag-width"/>;
            height: <spring:message code="drag-height"/>;
            line-height: 40px;
            background-color: #e8e8e8;
            position: relative;
            margin: 0 auto;
            margin-left: 2px;
            float: left;
        }
        .bg{
            width:<spring:message code="bg-width"/>;
            height: 100%;
            position: absolute;
            background-color: #75CDF9;
        }
        .text{
            position: absolute;
            margin-top: <spring:message code="text-margin-top"/>;
            font-size: <spring:message code="text-font-size"/>;
            color: #333;
            width: 100%;
            height: 100%;
            text-align: center;
            user-select: none;
        }
        .btn{
            width:<spring:message code="btn-height"/>;
            height: <spring:message code="btn-height"/>;
            position: absolute;
            border:1px solid #ccc;
            cursor: move;
            font-family: "微软雅黑 Light";
            text-align: center;
            background-color: #fff;
            user-select: none;
            color:#666;
        }
        #down{
            font-size: 12px;
            text-align: center;
            color: #979797;
            font-family: 'Segoe UI',SegoeUI,'Microsoft YaHei',微软雅黑,"Helvetica Neue",Helvetica,Arial,sans-serif;
            position: absolute;
            top: 90%;
            width: 100%;
            height: 10%;
            background-color: #070707ed;
        }
        .wrapper {
            width: 100%;
            height: 100%;
            -webkit-box-align: center;
            -webkit-align-items: center;
            -ms-flex-align: center;
            align-items: center;
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: horizontal;
            -webkit-box-direction: normal;
            -webkit-flex-direction: row;
            -ms-flex-direction: row;
            flex-direction: row;
            -webkit-box-pack: center;
            -webkit-justify-content: center;
            -ms-flex-pack: center;
            justify-content: center;
            background: url("${pageContext.request.contextPath}/imgs/login/backgroundImg.jpg") no-repeat center center fixed;
            background-size: cover;
        }
        .element {
            width: 100%;
            height: <spring:message code="element-height"/>;
            overflow: hidden;
            position: fixed;
            top: 0;
        }
        .log {
            width: 100%;
            height: 200%;
            background: url("${pageContext.request.contextPath}/imgs/login/backgroundImg.jpg") no-repeat center center fixed;
            background-size: cover;
            position: absolute;
            right: 0px;
            filter: blur(8px);
            top: -20px;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="element">
        <div class="log"></div>
    </div>
</div>
<div id="top">
    <span style="<spring:message code="span-font-size"/>;color: #ffffff;">︱宏图软件教育-办公管理系统</span><br>
</div>
<div id="login" align="center">
    <form style="<spring:message code="form-style"/>">
        <span class="title">用户登录</span>
        <a href="?lang=<spring:message code="link-href"/>" style="top: <spring:message code="a-top"/>;left:<spring:message code="a-left"/>;position: absolute;"><i style="font-size: <spring:message code="i-font-size"/>;" class="login-icon layui-icon <spring:message code="icon-class"/>"></i></a>
        <div class="hr"></div>
        <div class="login-row">
            <i class="login-icon layui-icon layui-icon-username"></i>
            <input type="text" name="phone" placeholder="输入手机号" style="<spring:message code="input-style"/>" autocomplete="off" class="layui-input" value="">
        </div>
        <div class="login-row">
            <i class="login-icon layui-icon layui-icon-password"></i>
            <input type="password" name="pwd" placeholder="输入密码" style="<spring:message code="input-style"/>" autocomplete="off" class="layui-input" value=""/>
        </div>
        <div id="varcode" class="login-row">
            <i class="login-icon layui-icon layui-icon-vercode"></i>
            <div class="drag">
                <div class="bg"></div>
                <div class="text" onselectstart="return false;">请拖动滑块解锁</div>
                <div class="btn">&gt;&gt;</div>
            </div>
        </div>
        <div class="login-row" id="submitDiv" style="cursor: not-allowed;">
            <input id="submit" type="button" class="layui-btn layui-btn-primary login-submit" value="登录" />
        </div>
    </form>
    <%--    </form>--%>
</div>
<div id="down">
    感谢<a target="_blank" href="https://www.layui.com/">LayUI</a>提供前端支持<br>
    感谢<a target="_blank" href="https://www.microsoft.com/zh-cn/">microsoft</a>提供封面<br>
    感谢我们可爱的组长丁胜禄先生<br>
    在这里先随便写一点什么，日后有时间在来改吧
</div>
<script>
    $("#submit").click(function () {
        var phone = $("input[name='phone']").val();
        var pwd = $("input[name='pwd']").val();
        var data = {
            phone:phone,
            pwd:pwd
        };
        $.post("${pageContext.request.contextPath}/login",data,function (data) {
            if (data.code === "notPhone"){
                layer.msg('查无此手机号');
                $('input[name="phone"]').val("");
                $('input[name="phone"]').focus();
            } else if (data.code === "notPwd") {
                layer.msg('密码错误');
                $('input[name="pwd"]').val("");
                $('input[name="pwd"]').focus();
            } else if (data.code === "admin") {
                layer.msg("登录成功<br>正在跳转页面");
                window.location.href = "${pageContext.request.contextPath}/toPage/oamain"
            } else if (data.code === "user") {
                layer.msg("登录成功<br>正在跳转页面");
                window.location.href = "${pageContext.request.contextPath}/toPage/studentSide"
            } else if (data.code === "ban") {
                layer.msg("您已被禁用");
            }
            delVarCode();
            console.log(data);
        },"json");
    });
    $(document).ready(function(){
        $("#login").css("width",'<spring:message code="login-width-after"/>');
        $("#login").css("height",'<spring:message code="login-height-after"/>');
        $("#login").css("opacity",'1');
        $("#login").css("left",'55%');
        $("#login").css("top",'20%');
    });
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
    });
    function delVarCode() {
        $(".drag").html("" +
            "<div class=\"bg\"></div>\n" +
            "<div class=\"text\" onselectstart=\"return false;\">请拖动滑块解锁</div>\n" +
            "<div class=\"btn\">&gt;&gt;</div>");
        $("#submitDiv").css("cursor","not-allowed");
        $("#submit").css("pointer-events","none");
        $("#submit").css("color","#a29e9e");
        huakuai();
    }
</script>
<script>
    window.onload = function (ev) {
        huakuai();
        $.removeCookie('loginSize');
        $.cookie("loginSize","<spring:message code='link-myHref'/>");
    };
    function huakuai(){//滑块验证
        //一、定义一个获取DOM元素的方法
        var $ = function(selector){
                return  document.querySelector(selector);
            },
            box = $(".drag"),//容器
            bg = $(".bg"),//背景
            text = $(".text"),//文字
            btn = $(".btn"),//滑块
            success = false,//是否通过验证的标志
            distance = box.offsetWidth - btn.offsetWidth;//滑动成功的宽度（距离）

        //二、给滑块注册鼠标按下事件
        btn.onmousedown = function(e){

            //1.鼠标按下之前必须清除掉后面设置的过渡属性
            btn.style.transition = "";
            bg.style.transition ="";

            //说明：clientX 事件属性会返回当事件被触发时，鼠标指针向对于浏览器页面(或客户区)的水平坐标。

            //2.当滑块位于初始位置时，得到鼠标按下时的水平位置
            var e = e || window.event;
            var downX = e.clientX;

            //三、给文档注册鼠标移动事件
            document.onmousemove = function(e){

                var e = e || window.event;
                //1.获取鼠标移动后的水平位置
                var moveX = e.clientX;

                //2.得到鼠标水平位置的偏移量（鼠标移动时的位置 - 鼠标按下时的位置）
                var offsetX = moveX - downX;

                //3.在这里判断一下：鼠标水平移动的距离 与 滑动成功的距离 之间的关系
                if( offsetX > distance){
                    offsetX = distance;//如果滑过了终点，就将它停留在终点位置
                }else if( offsetX < 0){
                    offsetX = 0;//如果滑到了起点的左侧，就将它重置为起点位置
                }

                //4.根据鼠标移动的距离来动态设置滑块的偏移量和背景颜色的宽度
                btn.style.left = offsetX + "px";
                bg.style.width = offsetX + "px";

                //如果鼠标的水平移动距离 = 滑动成功的宽度
                if( offsetX == distance){

                    //1.设置滑动成功后的样式
                    text.innerHTML = "验证通过";
                    text.style.color = "#fff";
                    btn.innerHTML = "&radic;";
                    btn.style.color = "green";
                    bg.style.backgroundColor = "lightgreen";

                    //2.设置滑动成功后的状态
                    success = true;
                    //成功后，清除掉鼠标按下事件和移动事件（因为移动时并不会涉及到鼠标松开事件）
                    btn.onmousedown = null;
                    document.onmousemove = null;

                    //3.成功解锁后的回调函数
                    setTimeout(function(){
                        var submitBtn = document.getElementById("submit");
                        submitBtn.style.pointerEvents = "auto";
                        submitBtn.style.color = "#555";
                        var submitDiv = document.getElementById("submitDiv");
                        submitDiv.style.cursor="pointer";
                    },100);
                }
            };

            //四、给文档注册鼠标松开事件
            document.onmouseup = function(e){

                //如果鼠标松开时，滑到了终点，则验证通过
                if(success){
                    return;
                }else{
                    //反之，则将滑块复位（设置了1s的属性过渡效果）
                    btn.style.left = 0;
                    bg.style.width = 0;
                    btn.style.transition = "left 1s ease";
                    bg.style.transition = "width 1s ease";
                }
                //只要鼠标松开了，说明此时不需要拖动滑块了，那么就清除鼠标移动和松开事件。
                document.onmousemove = null;
                document.onmouseup = null;
            }
        };
    }
</script>
</body>
</html>