<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/2
  Time: 19:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>HT-OA</title>
    <jsp:include page="include.jsp" />
    <style>
        .first-tab .layui-tab-close{
            display:none!important;
        }
        .layui-nav-child a{
            font-size: 12px;
        }
        .layui-layout-admin .layui-logo{
            font-size: 30px;
        }
        a{
            cursor:pointer;
        }
        .layui-tab-content {
            padding: 0px;
        }
        .layui-layout-admin .layui-logo {
            background-color: #393d49;
        }
        .layui-layout-admin .layui-header {
            border-bottom-style: solid;
            border-bottom-color: #393d49;
            border-bottom-width: 1px;
        }
    </style>
</head>
<body class="layui-layout-body">
<div layadmin-themealias="purple-red-header" class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">Student_OA</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:void(0);"  class="site-demo-active" data-type="tabAdd"
                   data-url="${pageContext.request.contextPath}/studentduan/usermessage"
                   data-id="用户信息" data-title="用户信息">
                    ${user.stuname}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/logout">注销</a></dd>
                    <dd><a href="javaScript:void(0)" onclick="updatepwd()">修改密码</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <%--修改密码--%>
    <div id="updatepwd"  style="margin-left: 5%;display: none;">
        <form class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">原密码:</label>
                <div class="layui-input-block">
                    <input id="pwd" type="password" name="pwd" required lay-verify="required" placeholder="请输入原密码" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">新密码:</label>
                <div class="layui-input-block">
                    <input id="pwd1" type="password" name="pwd1" required lay-verify="required" placeholder="请输入新密码" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">再输一次:</label>
                <div class="layui-input-block">
                    <input id="pwd2" type="password" name="pwd2" required lay-verify="required" placeholder="请再次输入新密码" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <center>
                        <button type="submit" class="layui-btn" lay-submit lay-filter="pwdAction" >保存</button>
                    </center>
                </div>
            </div>
        </form>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item">
                    <a href="javascript:;" lay-tips="请假管理" lay-direction="2" class="site-demo-active" data-type="tabAdd" data-url="${pageContext.request.contextPath}/studentduan/studentleaves"
                       data-id="申请请假" data-title="申请请假">
                        <i class="layui-icon layui-icon-release"></i>
                        <cite>请假管理</cite>
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" lay-tips="问题反馈" lay-direction="2" class="site-demo-active" data-type="tabAdd" data-url="${pageContext.request.contextPath}/studentduan/problem_feedback"
                       data-id="问题反馈" data-title="问题反馈">
                        <i class="layui-icon layui-icon-help"></i>
                        <cite>问题反馈</cite>
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" lay-tips="报修申请" lay-direction="2" class="site-demo-active" data-type="tabAdd" data-url="${pageContext.request.contextPath}/myRepair/toStuRepair"
                       data-id="报修申请" data-title="报修申请">
                        <i class="layui-icon layui-icon-help"></i>
                        <cite>报修申请</cite>
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" lay-tips="教师考评" lay-direction="2" class="site-demo-active" data-type="tabAdd"
                       data-url="${pageContext.request.contextPath}/jack/toTeacharEva"
                       data-id="教师考评" data-title="教师考评">
                        <i class="layui-icon layui-icon-friends"></i>
                        <cite>教师考评</cite>
                    </a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" lay-tips="我的公告" lay-direction="2" class="site-demo-active" data-type="tabAdd"
                       data-url="${pageContext.request.contextPath}/jack/toMyAnno"
                       data-id="我的公告" data-title="我的公告">
                        <i class="layui-icon layui-icon-reply-fill"></i>
                        <cite>我的公告</cite>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-body" style=" height:92%">
        <!-- 内容主体区域 -->
        <div style="height: 93%;width: 100%;">
            <div class="layui-tab layui-tab-brief" lay-filter="demo" lay-allowClose="true">
                <ul class="layui-tab-title">
                    <li style="" class="first-tab layui-this" lay-id="首页">首页</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <img style="height: 100%;width: 100%;" src="${pageContext.request.contextPath}/imgs/test/index.jpg" alt="" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
        var $ = layui.jquery;
        //触发事件
        var active = {
            //在这里给active绑定几项事件，后面可通过active调用这些事件
            tabAdd:function(url,id,name) {
                //新增一个Tab项 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                //关于tabAdd的方法所传入的参数可看layui的开发文档中基础方法部分
                element.tabAdd('demo', {
                    title: name,
                    content: '<iframe data-frameid="'+id+'" frameborder="0" src="'+url+'" style="width:100%;height: 100%" id="test"></iframe>',
                    id: id //规定好的id
                });
                element.render('tab');

            },
            tabChange: function(id) {
                //切换到指定Tab项
                element.tabChange('demo', id); //根据传入的id传入到指定的tab项
            },
            tabDelete: function (id) {
                element.tabDelete("demo", id);//删除
            }
            , tabDeleteAll: function (ids) {//删除所有
                $.each(ids, function (i,item) {
                    element.tabDelete("demo", item); //ids是一个数组，里面存放了多个id，调用tabDelete方法分别删除
                })
            }
        };


        //当点击有site-demo-active属性的标签时，即左侧菜单栏中内容 ，触发点击事件
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

    <!--高度自适应-->
    function reinitIframe(){
        var iframe = document.getElementById("test");
        try{
            var bHeight = iframe.contentWindow.document.body.scrollHeight;
            var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
            var height = Math.max(bHeight, dHeight);
            iframe.height = height;
        }catch (ex){}
    }
    <!--每200毫秒加载一次-->
    window.setInterval("reinitIframe()",200);
</script>
<script>
    function updatepwd() {
        layui.use(['layer','form'],function() {
            var layer = layui.layer;
            var form = layui.form;
            layer.open({
                type: 1,
                title:'修改登录密码',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['450px', '300px'],
                fixed: false, //不固定
                maxmin: true,
                //shadeClose: true, //开启遮罩关闭
                content: $('#updatepwd'),
                cancel: function(index, layero){
                    $("#pwd").val("");
                    $("#pwd1").val("");
                    $("#pwd2").val("");
                }
            });

            form.on('submit(pwdAction)', function(data){
                //新旧密码
                var pwd1 = data.field.pwd1;
                var pwd2 = data.field.pwd2;
                if(pwd1!=pwd2){
                    layer.msg('两次输入的新密码不一样!请重新输入!')
                    $("#pwd1").focus()
                    return false;
                }
                if(pwd1.length<6||pwd1.length>16){
                    layer.msg('新密码的长度必须为6~16位!')
                    return false;
                }
                $.ajax({
                    url:'<%=request.getContextPath()%>/studentduan/updatepwd',
                    type:'post',
                    async:true,
                    dataType:'text',
                    data:data.field,
                    success:function (d) {
                        if(d=="error"){//原来密码错误
                            layer.msg('您输入的原密码错误!请重新输入!')
                            $("#pwd").focus()
                            return;
                        }
                        if(d=="ok"){
                            layer.msg('修改成功!即将跳转到登录页面!')
                            setTimeout(function () {
                                window.location.href="<%=request.getContextPath()%>/logout";
                            },1500)
                        }
                    }
                })
                return false;
            })
        })
    }
</script>
</body>
</html>