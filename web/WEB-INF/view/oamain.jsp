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
    <title>OA-HT系统</title>
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

    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">HTOA</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:void(0);">
                    未登入
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">切换账号</a></dd>
                    <dd><a href="">邮箱</a></dd>
                    <dd><a href="">安全设置</a></dd>
                    <dd><a href="">注销</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item">
                    <a href="#">员工管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <%-- 例子  可修改 照着写就行了 --%>
                            <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/test1/toTest1"
                               data-id="部门管理" data-title="部门管理">部门管理</a>
                        </dd>
                        <dd>
                            <a href="javascript:void(0);" class="site-demo-active" data-type="tabAdd"
                               data-url="${pageContext.request.contextPath}/test1/toTest1"
                               data-id="员工资料" data-title="员工资料" >员工资料</a>
                        </dd>
                        <dd><a href="javascript:void(0);">周报管理</a></dd>
                        <dd><a href="javascript:void(0);">周报审阅</a></dd>
                        <dd><a href="javascript:void(0);">谈心记录</a></dd>


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
                    <a>学生管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">学生请假</a></dd>
                        <dd><a href="javascript:void(0);">班级管理</a></dd>
                        <dd><a href="javascript:void(0);">楼栋管理</a></dd>
                        <dd><a href="javascript:void(0);">宿舍管理</a></dd>
                        <dd><a href="javascript:void(0);">学生资料</a></dd>
                        <dd><a href="javascript:void(0);">考试成绩</a></dd>
                        <dd><a href="javascript:void(0);">答辩成绩</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>教务管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">课程类别</a></dd>
                        <dd><a href="javascript:void(0);">课程管理</a></dd>
                        <dd><a href="javascript:void(0);">试讲培训</a></dd>
                        <dd><a href="javascript:void(0);">值班管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>后勤管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">报修申请</a></dd>
                        <dd><a href="javascript:void(0);">维修管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>考核管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">考核指标</a></dd>
                        <dd><a href="javascript:void(0);">考核录入</a></dd>
                        <dd><a href="javascript:void(0);">考评内容</a></dd>
                        <dd><a href="javascript:void(0);">教师考评</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>问题反馈</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">问题反馈</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>文件管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">资料文档</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>系统报表</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">日常考核</a></dd>
                        <dd><a href="javascript:void(0);">请假管理</a></dd>
                        <dd><a href="javascript:void(0);">未打卡说明</a></dd>
                        <dd><a href="javascript:void(0);">宿舍统计报表</a></dd>
                        <dd><a href="javascript:void(0);">学生请假</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>通知公告</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">通知公告</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a>系统设置</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0);">权限管理</a></dd>
                        <dd><a href="javascript:void(0);">流程管理</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding:5px;width: 100%;">
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
                    content: '<iframe data-frameid="'+id+'" scrolling="no" frameborder="0" src="'+url+'" style="width:100%;height:100%;"></iframe>',
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
</script>
</body>
</html>
