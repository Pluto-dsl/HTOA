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
    <title>HT软件DSL</title>
    <jsp:include page="include.jsp" />
    <style>
        a{
            color: #000;
        }
        #Bcontext{
            width: 100%;
            height: 100%;
            background-image:url("${pageContext.request.contextPath}/imgs/login/backgroundImg.jpg");
            float: left;

        }
        #login{
            opacity: 0;
            left: 150px;
            top: -120px;
            width: 580px;
            height: 540px;
            background-color: white;
            margin: 10% 40%;
            position: absolute;
            transition: all 0.5s;
            transition-timing-function:ease;
            box-shadow: 9px 9px 20px 0px #151515;
            border-radius: 3px;
            z-index: 100;
        }
        #top{
            z-index: 50;
            position: absolute;
            width: 85%;
            height: 50px;
            padding-left: 15%;
            padding-top: 10px;
            background-color: #ffffffde;
        }
        .title{
            margin-top: 12%;
            margin-left: -28%;
            padding-bottom: 3%;
            width: 100%;
            font-size: 30px;
            color: #5f5f5f;
            font-family: "微软雅黑 Light";
            font-weight: 600;
            float: left;
        }
        .hr{
            background-color: #9F9F9F;
            width: 118%;
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
            font-size: 25px;
            color: #333;
            float: left;
        }
        .login-submit{
            pointer-events: none;
            color: #a29e9e;
            width: 100%;
            height: 40px;
            margin-top: 3%;
            font-size: 20px;
            float: left;
        }
        .drag{
            width: 250px;
            height: 40px;
            line-height: 40px;
            background-color: #e8e8e8;
            position: relative;
            margin: 0 auto;
            margin-left: 2px;
            float: left;
        }
        .bg{
            width:40px;
            height: 100%;
            position: absolute;
            background-color: #75CDF9;
        }
        .text{
            position: absolute;
            width: 100%;
            height: 100%;
            text-align: center;
            user-select: none;
        }
        .btn{
            width:40px;
            height: 38px;
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
            color: #6e6e6e;
            font-family: 'Segoe UI',SegoeUI,'Microsoft YaHei',微软雅黑,"Helvetica Neue",Helvetica,Arial,sans-serif;
            position: absolute;
            top: 90%;
            width: 100%;
            height: 10%;
            background-color: #ffffffd4;
        }
    </style>
</head>
<body>
<div id="Bcontext">

</div>
<div id="top">
    <span style="font-size: 29px;color: #474747;">︱宏图软件教育-办公管理系统</span>
</div>
<div id="login" align="center">
    <%--        <form class="layui-form" action="${pageContext.request.contextPath}/jack/login" method="post">--%>
    <form style="width: 280px;">
        <span class="title">用户登录</span>
        <div class="hr"></div>
        <div class="login-row">
            <i class="login-icon layui-icon layui-icon-username"></i>
            <input type="text" name="phone" placeholder="输入手机号" style="width: 90%;" autocomplete="off" class="layui-input">
        </div>
        <div class="login-row">
            <i class="login-icon layui-icon layui-icon-password"></i>
            <input type="password" name="pwd" placeholder="输入密码" style="width: 90%;" autocomplete="off" class="layui-input" />
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
        $("#login").css("width",'380px');
        $("#login").css("height",'340px');
        $("#login").css("opacity",'1');
        $("#login").css("left",'250px');
        $("#login").css("top",'-20px');
    });
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
    });
    function delVarCode() {
        $(".drag").html("<div class=\"bg\"></div>\n" +
            "                <div class=\"text\" onselectstart=\"return false;\">请拖动滑块解锁</div>\n" +
            "                <div class=\"btn\">&gt;&gt;</div>");
        $("#submitDiv").css("cursor","not-allowed");
        $("#submit").css("pointer-events","none");
        $("#submit").css("color","#a29e9e");
        huakuai();
    }
</script>
<script>
    window.onload = function (ev) {
        huakuai();
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