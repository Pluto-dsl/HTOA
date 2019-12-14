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

    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">HTOA</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:void(0);">
                    <%--${admin.empName}--%>
                    已注释
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="/logout">注销</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item">
                    <a href="javascript:;">员工管理</a>
                    <dl class="layui-nav-child">
                        <%-- 例子  可修改 照着写就行了 --%>
                        <dd><a href="javascript:void(0);">部门管理</a></dd>
                        <dd><a href="javascript:void(0);" >员工资料</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/emp/toEmpPaper"
                               data-id="我的周报" data-title="我的周报" >我的周报</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/ljw/toWeekLogPage"
                               data-id="周报管理" data-title="周报管理" >周报管理</a></dd>
                        <dd><a href="javascript:void(0);">周报审阅</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/ljw/toChatRecordPage"
                               data-id="谈心记录" data-title="谈心记录" >谈心记录</a></dd>
                        <dd>
                            <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/empLeave/toleave"
                               data-id="员工请假" data-title="员工请假">员工请假</a>
                        </dd>

                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/jack/toAtt"
                               data-id="考勤管理" data-title="考勤管理">考勤管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" >学生管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/student/leave"
                               data-id="学生请假" data-title="学生请假" >学生请假</a></dd>
                        <dd><a href="javascript:void(0);">班级管理</a></dd>
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/toPage/stuFloor"
                               data-id="部门管理" data-title="楼栋管理">楼栋管理</a></dd>
                        <dd><a href="javascript:void(0);"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/toPage/stuDorm"
                               data-id="部门管理" data-title="楼栋管理" >宿舍管理</a></dd>
                        <dd><a href="javascript:void(0);"class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/student/stuList"
                               data-id="学生资料" data-title="学生资料" >学生资料</a></dd>
                        <dd><a href="javascript:void(0);">考试成绩</a></dd>
                        <dd><a href="javascript:void(0);">答辩成绩</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">教务管理</a>
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
                        <dd><a href="javascript:void(0);">值班管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">后勤管理</a>
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
                    <a href="javascript:;">考核管理</a>
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
                               data-url="${pageContext.request.contextPath}/jack/toAduitLogList"
                               data-id="考评内容" data-title="考评内容">考评内容</a></dd>
                        <dd><a href="javascript:void(0);">教师考评</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">问题反馈</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/student/questionPage"
                               data-id="问题反馈" data-title="问题反馈" >问题反馈</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">文件管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">资料文档</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">系统报表</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">日常考核</a></dd>
                        <dd><a href="javascript:void(0);">请假管理</a></dd>
                        <dd><a href="javascript:void(0);">未打卡说明</a></dd>
                        <dd><a href="javascript:void(0);">宿舍统计报表</a></dd>
                        <dd><a href="javascript:void(0);">学生请假</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">通知公告</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">通知公告</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">安全管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">权限管理</a></dd>
                        <dd><a href="javascript:void(0);">流程管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>系统设置</a>
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
                    <li style="" class="first-tab" lay-id="首页">首页</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        xxxx
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
</body>
</html>