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
        .layui-col-space10 {
            margin: 1px;
        }
        .layui-card-body {
            position: relative;
            padding: 10px 15px;
            line-height: 24px;
            overflow: auto;
            height: 40%;

        }
        .layui-col-xs3 {
            float: none;
            width: 100%;
            height: 16%;
            line-height: 2;
        }
        .layui-col-xs3:hover{
            background-color: #dddbe0;
        }
        .layui-col-md6 {
            width: 30%;
        }
        #seeboay{
            position: relative;
            padding: 10px 15px;
            line-height: 24px;
            overflow: unset;
            height: 40%;
        }
        #SeeWin{
            margin-top: 10px;
        }
        #Seebbb{
            width: 99%;
            height: 335px;
            font-size: 18px;
            text-indent: 2em;
            padding-top: 10px;
            padding-left: 10px;
        }
    </style>
</head>
<body class="layui-layout-body">
<div layadmin-themealias="purple-red-header" class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">HTOA</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                   data-url="${pageContext.request.contextPath}/emp/selectusermessage"
                   data-id="用户信息" data-title="用户信息">
                    ${admin.empName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/logout">注销</a></dd>
                    <dd><a href="javaScript:void(0)" onclick="editpwd()">修改密码</a></dd>
                </dl>
            </li>
        </ul>
    </div>
    <div id="editwindow"  style="margin-left: 5%;display: none;">
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
            <ul class="layui-nav layui-nav-tree"  lay-filter="test" lay-accordion>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="员工管理" lay-direction="2">
                        <i class="layui-icon layui-icon-user"></i>
                        <cite>员工管理</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <%-- 例子  可修改 照着写就行了 --%>
                        <dd> <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                                data-url="<%=request.getContextPath()%>/zeroEmp/toemp"
                                data-id="员工资料" data-title="员工资料" >员工资料</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/emp/toEmpPaper"
                               data-id="我的周报" data-title="我的周报" >我的周报</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/ljw/toWeekLogPage"
                               data-id="周报审阅" data-title="周报审阅" >周报审阅</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/ljw/toChatRecordPage"
                               data-id="谈心记录" data-title="谈心记录" >谈心记录</a></dd>
                        <dd>
                            <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/zeroLeave/toleave"
                               data-id="请假管理" data-title="请假管理">请假管理</a>
                        </dd>

                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toAtt"
                               data-id="考勤管理" data-title="考勤管理" >考勤管理</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="学生管理" lay-direction="2">
                        <i class="layui-icon layui-icon-face-smile-b"></i>
                        <cite>学生管理</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/student/selectleave"
                               data-id="学生请假" data-title="学生请假" >学生请假</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/zeroStudent/toClass"
                               data-id="班级管理" data-title="班级管理">班级管理</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/zhq/stuFloor"
                               data-id="楼栋管理" data-title="楼栋管理">楼栋管理</a></dd>
                        <dd><a href="javascript:void(0);"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/zhq/stuDorm"
                               data-id="宿舍管理" data-title="宿舍管理" >宿舍管理</a></dd>
                        <dd><a href="javascript:void(0);"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/student/stuList"
                               data-id="学生资料" data-title="学生资料" >学生资料</a></dd>
                        <dd><a href="javascript:void(0);"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/StudentScore/toscore"
                               data-id="考试成绩" data-title="考试成绩" >考试成绩</a></dd>
                        <dd><a href="javascript:void(0);"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/StudentScore/toreply"
                               data-id="答辩成绩" data-title="答辩成绩" >答辩成绩</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="教务管理" lay-direction="2">
                        <i class="layui-icon layui-icon-read"></i>
                        <cite>教务管理</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toCourseList"
                               data-id="课程类别" data-title="课程类别">课程类别</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toCourseManagement"
                               data-id="课程管理" data-title="课程管理">课程管理</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/training/rehearsal_trainingPage"
                               data-id="试讲培训" data-title="试讲培训" >试讲培训</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/arrange/arrangePage"
                               data-id="值班管理" data-title="值班管理" >值班管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="后勤管理" lay-direction="2"><i class="layui-icon layui-icon-template-1"></i><cite>后勤管理</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/logs/toMyRepair"
                               data-id="报修申请" data-title="报修申请" >报修申请</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/logs/toRepairPage"
                               data-id="维修管理" data-title="维修管理" >维修管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="考核管理" lay-direction="2"><i class="layui-icon layui-icon-survey"></i><cite>考核管理</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a layadmin-event="refresh" href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toAssessmentPage"
                               data-id="考核指标" data-title="考核指标">考核指标</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toCheckEntry"
                               data-id="考核录入" data-title="考核录入">考核录入</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toAduitLogList"
                               data-id="员工考核" data-title="员工考核">员工考核</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toEvaluationContext"
                               data-id="考评内容" data-title="考评内容">考评内容</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toTeacherListE"
                               data-id="教师考评" data-title="教师考评">教师考评</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="问题反馈" lay-direction="2">
                        <i class="layui-icon layui-icon-chat"></i>
                        <cite>问题反馈</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/student/questionPage"
                               data-id="问题反馈" data-title="问题反馈" >问题反馈</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="文件管理" lay-direction="2">
                        <i class="layui-icon layui-icon-tabs"></i>
                        <cite>文件管理</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/zhq/DataDoc"
                               data-id="资料文档" data-title="资料文档" >资料文档</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="文件管理" lay-direction="2">
                        <i class="layui-icon layui-icon-tabs"></i>
                        <cite>招生管理</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toEnrollment"
                               data-id="招生信息" data-title="招生信息" >招生信息</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="系统报表" lay-direction="2"><i class="layui-icon layui-icon-layouts"></i>
                        <cite>系统报表</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/systemLog/toEveryDayPage"
                               data-id="日常考核" data-title="日常考核">日常考核</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/systemLog/toHolidayPage"
                               data-id="员工请假统计" data-title="员工请假统计">员工请假统计</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/systemLog/toHolidayStuPage"
                               data-id="学生请假统计" data-title="学生请假统计">学生请假统计</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/systemLog/toWorkTime"
                               data-id="未打卡说明统计" data-title="未打卡说明统计">未打卡说明统计</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/systemLog/toStuHour"
                               data-id="宿舍统计报表" data-title="宿舍统计报表">宿舍统计报表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="通知公告" lay-direction="2"><i class="layui-icon layui-icon-file"></i><cite>通知公告</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/zhq/Notice"
                               data-id="通知公告" data-title="通知公告">通知公告</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="安全管理" lay-direction="2"><i class="layui-icon layui-icon-auz"></i><cite>安全管理</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/controller/toUserList"
                               data-id="权限管理" data-title="权限管理">权限管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" class="tt" lay-tips="系统设置" lay-direction="2"><i class="layui-icon layui-icon-util"></i><cite>系统设置</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/system/systemPage"
                               data-id="系统设置" data-title="系统设置" >系统设置</a></dd>
                    </dl>
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
                        <%--内容主体--%>
                        <div class="layui-col-md6" style="margin: 1% 15%;float:right;">
                            <div class="layui-card">
                                <div class="layui-card-header" style="background-color:#333333;font-size: 20px;color: #fffaf5">我的任务 <i class="layui-icon layui-icon-refresh-3" style="cursor: pointer;float: right" id="flush"></i></div>
                                <div class="layui-card-body">
                                    <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                                        <ul class="layui-row layui-col-space10">
                                            <li class="layui-col-xs3">
                                                <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                                                   data-url="${pageContext.request.contextPath}/zeroLeave/mytask"
                                                   data-id="请假管理" data-title="请假管理">
                                                    <i class="layui-icon layui-icon-survey"></i>
                                                    <cite>员工请假待审批(<span id="emp">0</span>)</cite>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a  href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                                                    data-url="${pageContext.request.contextPath}/student/selectleave"
                                                    data-id="学生请假" data-title="学生请假" >
                                                    <i class="layui-icon layui-icon-star"></i>
                                                    <cite>学生请假待审批(<span id="stu">0</span>)</cite>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                                                   data-url="${pageContext.request.contextPath}/jack/toAtt"
                                                   data-id="考勤管理" data-title="考勤管理" >
                                                    <i class="layui-icon layui-icon-form"></i>
                                                    <cite>未打卡待审批(<span id="clock">0</span>)</cite>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                                                   data-url="${pageContext.request.contextPath}/emp/toEmpPaper"
                                                   data-id="我的周报" data-title="我的周报" >
                                                    <i class="layui-icon layui-icon-note"></i>
                                                    <cite>本周工作周报(<span id="weekly"></span>)</cite>
                                                    <span style="color:red;margin-left:10px;font-size: 11px;">周日17:00前提交</span>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                                                   data-url="${pageContext.request.contextPath}/ljw/toChatRecordPage"
                                                   data-id="谈心记录" data-title="谈心记录" >
                                                    <i class="layui-icon layui-icon-face-smile"></i>
                                                    <cite>月谈心记录(已完成<span id="talk">0</span>个)</cite>
                                                    <span style="color:red;margin-left:10px;font-size: 11px;">每月需完成5个</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <iframe frameborder="0" src="${pageContext.request.contextPath}/jack/toMyAnnoEmp" style="width:50%;height:80%;position: absolute;margin-left: 65px;" id="test1"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%--    <iframe align="right" style="height: 100%;width: 1193px;" name="iframe1" class="layui-layer-iframe">--%>
<%--        --%>
<%--    </iframe>--%>

</div>

<script>
    //JavaScript代码区域
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var upload = layui.upload;
        var $ = layui.jquery;


        yb();
        $("#flush").on('click',function () {
            yb();
        });

        function yb(){
            $.post('${pageContext.request.contextPath}/jack/MyMission',{},function (data) {
                console.log(data);
                $("#emp").text(data.emp);
                $("#Notice").text(data.Notice);
                $("#stu").text(data.stu);
                $("#talk").text(data.talk);
                $("#clock").text(data.clock);
                $("#weekly").text(data.weekly);
            });
        }


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

        //手风琴只打开一栏
        $(".layui-nav-item").on('click',function (e) {
            $(this).siblings().removeClass("layui-nav-itemed");
        });


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
    function editpwd(){//打开修改密码窗口
        layui.use(['layer'],function() {
            layer.open({
                type: 1,
                title:'修改登录密码',
                skin: 'layui-layer-demo', //样式类名
                closeBtn: 1, //不显示关闭按钮
                area: ['450px', '300px'],
                fixed: false, //不固定
                maxmin: true,
                //shadeClose: true, //开启遮罩关闭
                content: $('#editwindow')
                ,cancel: function(index, layero){
                    $("#pwd").val("");
                    $("#pwd1").val("");
                    $("#pwd2").val("");
                }
            });
        })
    }
    layui.use(['form','layer'],function() {
        var layer = layui.layer;
        var form = layui.form;
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
                url:'<%=request.getContextPath()%>/zeroEmp/editpwd',
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
</script>
</body>
</html>