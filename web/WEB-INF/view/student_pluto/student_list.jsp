<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/10
  Time: 10:53
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生列表</title>
    <jsp:include page="../include.jsp" />
    <style>
        li{
            display: inline-block;
        }
    </style>
</head>
<body>
<div style="width: 100%">
    <form action="" class="layui-form">
        <ul style="margin-top: 5px;margin-left: 2%;">
            <li>
                <label class="label-top">学生姓名:&nbsp;</label>
            </li>
            <li>
                <input name="stuname" onchange="seek();" autocomplete="off" id="stuname" value="" placeholder="学生姓名" class="layui-input" style="width:100px;">
            </li>
            <li>
                <label style="width: 2%;">&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </li>
            <li>
                <label class="label-top">学生电话:&nbsp;</label>
            </li>
            <li >
                <input  name="stuphone" onchange="seek();" autocomplete="off" id="stuphone" value="" placeholder="学生电话" class="layui-input" style="width:100px;">
            </li>
            <li>
                <label style="width: 2%;">&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </li>
            <li>
                <label class="label-top">所在班级：</label>
            </li>
            <li>
                <select class="layui-form-label" lay-filter="stuclass" name="stuclass" id="stuclass" editable="false"  ditable="false"
                        style="width:100px;">
                    <option value="0" selected="selected">请选择</option>
                    <c:forEach items="${cList}" var="c">
                        <option value="${c.classId}">${c.className}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <label style="width: 2%;">&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </li>
            <li>
                <label class="label-top">宿舍房号：</label>
            </li>
            <li>
                <select class="layui-form-label"  lay-filter="stuhour" name="stuhour" id="stuhour" editable="false"  ditable="false"
                        style="width:100px;">
                    <option value="0" selected="selected">请选择</option>
                    <c:forEach items="${ssList}" var="h">
                        <option value="${h.hourid}">${h.huorName}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <label style="width: 2%;">&nbsp;&nbsp;&nbsp;&nbsp;</label>
            </li>
            <li>
                <label class="label-top">学生状态：</label>
            </li>
            <li>
                <select class="layui-form-label"  lay-filter="stustart" name="stustart" id="stustart" editable="false"  ditable="false"
                        style="width:100px;">
                    <option value="0" selected="selected">请选择</option>
                    <c:forEach items="${sList}" var="s">
                        <option value="${s.statusId}">${s.statusName}</option>
                    </c:forEach>
                </select>
            </li>
        </ul>
    </form>
    <script>

        function seek() {
            var stuname = $("#stuname").val();
            var stuphone = $("#stuphone").val();
            var stuclass = $("#stuclass").val();
            var stuhour = $("#stuhour").val();
            var stustart = $("#stustart").val();

            layui.use(['table','element','form'], function() {
                var table = layui.table;
                var form = layui.form;


                table.render({
                    elem: '#test'
                    ,url:'${pageContext.request.contextPath}/student/seekStuList?name='+stuname+'&phone='+stuphone+'&stuclass='+stuclass+'&hour='+stuhour+'&start='+stustart
                    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                        title: '提示'
                        ,layEvent: 'LAYTABLE_TIPS'
                        ,icon: 'layui-icon-tips'
                    }]
                    ,title: '用户数据表'
                    ,method:'post'
                    ,height:'440'
                    ,cols: [[
                        {type: 'radio',width:50}
                        // ,{field:'Studid', title:'ID', width:80,unresize: true, sort: true}
                        ,{field:'stuno', title:'学号', width:120}
                        ,{field:'stuname', title:'学生姓名', width:120}
                        ,{field:'sex', title:'性别', width:80}
                        // ,{field:'middleschool', title:'毕业学校', width:150}
                        ,{field:'entertime', title:'入学时间',width:160,templet : "<div>{{layui.util.toDateString(d.startDate, 'yyyy年MM月dd日')}}</div>"}
                        ,{field:'phone', title:'学生电话', width:150}
                        ,{field:'addr', title:'家庭住址', width:260}
                        ,{field:'className', title:'所在班级', width:250}
                        ,{field:'cardid', title:'身份证号', width:160}
                        ,{field:'huorName', title:'宿舍房号', width:120}
                        ,{field:'stat', title:'学生状态', width:120}
                        ,{field:'computer', title:'是否送电脑',width:120}
                        ,{field:'collar', title:'是否领用电脑', width:120}
                        ,{field:'grants', title:'享受助学金', width:120}
                        ,{field:'parents', title:'家长姓名', width:120}
                        ,{field:'parentsphone', title:'家长电话', width:120}
                        ,{field:'qkMoney', title:'欠款金额', width:120}
                        ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:240}
                    ]]
                    ,id:'test'
                    ,page: true
                    ,limit:[5,10,15,20,25]
                    ,done: function(res, page, count){
                        //如果是异步请求数据方式，res即为你接口返回的信息。
                        //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                        //分类显示中文名称
                        $("[data-field='stat']").children().each(function(){
                            //    状态名称：1意向学生、2预定报名学生、3试学学生、4在读学生、5已毕业学生\6退学
                            if($(this).text()=='1'){
                                $(this).text("意向学生")
                            }else if($(this).text()=='2'){
                                $(this).text("预定报名学生")
                            }else if($(this).text()=='3'){
                                $(this).text("试学学生")
                            }else if($(this).text()=='4'){
                                $(this).text("在读学生")
                            }else if($(this).text()=='5'){
                                $(this).text("已毕业学生")
                            }else if($(this).text()=='6'){
                                $(this).text("退学")
                            }
                        })
                    }
                });
            })

        }
        layui.use(['table','element','form'], function() {
            // var table = layui.table;
            var form = layui.form;
            form.on('select(stuclass)',function (data) {
                seek();
            })
            form.on('select(stuhour)',function (data) {
                seek();
            })
            form.on('select(stustart)',function (data) {
                seek();
            })
        })
    </script>
</div>
<%--表格--%>
    <table class="layui-hide" id="test" lay-filter="test"></table>
    <div class="layui-tab" lay-filter="demo" style="height: 365px;width: 100%;">
        <ul class="layui-tab-title">
            <li class="layui-this">在校情况</li>
            <li>家庭信息</li>
            <li>考试成绩</li>
            <li>答辩成绩</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show"><!--再校情况-->
                <%--在校情况--%>
                <script type="text/html" id="hrzxbar">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="updzx" style="height: 25px;">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="delzx" style="height: 25px;">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </script>
                <xblock>
                    <button class="layui-btn layui-btn-sm layui-btn-primary" id="addzx">
                        <i class="layui-icon">&#xe654;</i>
                        新增
                    </button>
                </xblock>
                <table class="layui-hide" id="zaixiao" lay-filter="zaixiao"></table>
            </div>

            <div class="layui-tab-item" id="jiating" lay-filter="jiating"><!--家庭情况-->
                <script type="text/html" id="hrjtbar">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="updzx" style="height: 25px;">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="delzx" style="height: 25px;">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </script>
                <xblock>
                    <button class="layui-btn layui-btn-sm layui-btn-primary" id="addjt">
                        <i class="layui-icon">&#xe654;</i>
                        新增
                    </button>
                </xblock>
                <table class="layui-hide" id="family" lay-filter="family"></table>
            </div>
            <!--考试成绩-->
            <div class="layui-tab-item" id="score" lay-filter="score">
                <script type="text/html" id="hrksbar">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="upd" style="height: 25px;">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                </script>
                <table class="layui-hide" id="exam" lay-filter="exam"></table>
            </div>
            <!--答辩成绩-->
            <div class="layui-tab-item " id="dabian" lay-filter="dabian">
                <script type="text/html" id="hrdbbar">
                    <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="upd" style="height: 25px;">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                </script>
                <table class="layui-hide" id="dbtab" lay-filter="dbtab"></table>
            </div>
        </div>
    </div>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="addStudent"><i class="layui-icon layui-icon-add-1" style="width: 30px;height:30px;"></i>新增学生</button>
            <button class="layui-btn layui-btn-sm" lay-event="setDorm"><i class="layui-icon layui-icon-flag" style="width: 30px;height:30px;"></i>调整宿舍</button>
            <button class="layui-btn layui-btn-sm" lay-event="setClass"><i class="layui-icon layui-icon-flag" style="width: 30px;height:30px;"></i>调整班级</button>
            <button class="layui-btn layui-btn-sm" lay-event="setBiye"><i class="layui-icon layui-icon-auz" style="width: 30px;height:30px;"></i>设置毕业</button>
        </div>
    </script>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="tuixue">退学</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="chongzhi">重置密码</a>
    </script>

    <%-----------------------------------%>

    <%------------------------------------------%>

    <script>
        layui.use(['table','element'], function(){
            var table = layui.table;
            var $ = layui.jquery
                ,element = layui.element;

            table.render({
                elem: '#test'
                ,url:'${pageContext.request.contextPath}/student/returnData'
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    ,layEvent: 'LAYTABLE_TIPS'
                    ,icon: 'layui-icon-tips'
                }]
                ,title: '用户数据表'
                ,height:'440'
                ,cols: [[
                    {type: 'radio',width:50}
                    // ,{field:'Studid', title:'ID', width:80,unresize: true, sort: true}
                    ,{field:'stuno', title:'学号', width:120}
                    ,{field:'stuname', title:'学生姓名', width:120}
                    ,{field:'sex', title:'性别', width:80}
                    // ,{field:'middleschool', title:'毕业学校', width:150}
                    ,{field:'entertime', title:'入学时间',width:160,templet : "<div>{{layui.util.toDateString(d.entertime, 'yyyy年MM月dd日')}}</div>"}
                    ,{field:'phone', title:'学生电话', width:150}
                    ,{field:'addr', title:'家庭住址', width:260}
                    ,{field:'className', title:'所在班级', width:250}
                    ,{field:'cardid', title:'身份证号', width:160}
                    ,{field:'huorName', title:'宿舍房号', width:120}
                    ,{field:'stat', title:'学生状态', width:120}
                    ,{field:'computer', title:'是否送电脑',width:120}
                    ,{field:'collar', title:'是否领用电脑', width:120}
                    ,{field:'grants', title:'享受助学金', width:120}
                    ,{field:'parents', title:'家长姓名', width:120}
                    ,{field:'parentsphone', title:'家长电话', width:120}
                    ,{field:'qkMoney', title:'欠款金额', width:120}
                    ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:240}
                ]]
                ,id:'test'
                ,page: true
                ,limits:[5,10,15,20,25]
                ,done: function(res, page, count){
                    //如果是异步请求数据方式，res即为你接口返回的信息。
                    //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                    //分类显示中文名称
                    $("[data-field='stat']").children().each(function(){
                    //    状态名称：1意向学生、2预定报名学生、3试学学生、4在读学生、5已毕业学生\6退学
                        if($(this).text()=='1'){
                            $(this).text("意向学生")
                        }else if($(this).text()=='2'){
                            $(this).text("预定报名学生")
                        }else if($(this).text()=='3'){
                            $(this).text("试学学生")
                        }else if($(this).text()=='4'){
                            $(this).text("在读学生")
                        }else if($(this).text()=='5'){
                            $(this).text("已毕业学生")
                        }else if($(this).text()=='6'){
                            $(this).text("退学")
                        }
                    })
                }
            });

            //头工具栏事件
            table.on('toolbar(test)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                var data = checkStatus.data;

                var checkStatus = table.checkStatus('test');
                var da=checkStatus.data;

                switch(obj.event){
                    case 'addStudent':
                        //iframe层
                        layer.open({
                            type: 2,
                            title: '新增学生',
                            shadeClose: true,
                            shade: 0.4,
                            shadeclose:true,
                            area: ['1100px', '770px'],
                            content: '${pageContext.request.contextPath}/student/toAddStu' //iframe的url
                        });
                        break;
                    case 'setDorm':
                        if (data==null || data==""){
                            layer.msg('请选择你要调整宿舍的学生！', {icon: 1});
                        }else{
                            //iframe层
                            layer.open({
                                type: 2,
                                title: '调整宿舍',
                                shadeClose: true,
                                shade: 0.4,
                                shadeclose:true,
                                area: ['520px', '370px'],
                                content: '${pageContext.request.contextPath}/student/toUpdateHour?id='+da[0].Studid //iframe的url
                            });
                            table.reload('test')
                        }

                        break;
                    case 'setClass':
                        if (data==null || data==""){
                            layer.msg('请选择你要调整班级的学生！', {icon: 1});
                        }else{
                            //iframe层
                            layer.open({
                                type: 2,
                                title: '调整班级',
                                shadeClose: true,
                                shade: 0.4,
                                shadeclose:true,
                                area: ['600px', '370px'],
                                content: '${pageContext.request.contextPath}/student/toUpdateClass?id='+da[0].Studid //iframe的url
                            });
                            table.reload('test')
                        }
                        break;

                    //自定义头工具栏右侧图标 - 提示
                    case 'setBiye':
                        if (data==null || data==""){
                            layer.msg('请选择你要设置的学生！', {icon: 1});
                        }else{
                            layer.confirm('确定要设置'+data[0].stuname+'同学为已毕业吗？', function(index){
                                $.post("${pageContext.request.contextPath}/student/biye",{Studid:data[0].Studid},function (data) {
                                    table.reload('test');
                                    layer.msg('设置成功！')
                                },'text')
                                layer.close(index);
                            });
                        }
                        break;
                };
            });

            // 每行的操作--------------------------------------
            //监听行工具事件
            table.on('tool(test)', function(obj){
                var data = obj.data;
                //console.log(obj)
                if(obj.event === 'del'){
                    layer.confirm('确定要删除'+data.stuname+'同学的信息吗？', function(index){

                        $.post("${pageContext.request.contextPath}/student/delStu",{id:data.Studid},function (data) {
                            table.reload('test');
                            layer.msg('删除成功！')

                        },'text')

                        layer.close(index);
                    });

                } else if(obj.event === 'edit'){
                    layer.open({
                        type: 2,
                        title: '修改学生信息',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['1100px', '770px'],
                        content: '${pageContext.request.contextPath}/student/toUpdateStu?id='+data.Studid
                    });
                }else if(obj.event === 'tuixue'){
                    //询问框
                    layer.confirm('确定要让'+data.stuname+'退学吗？', function(index){

                        $.post("${pageContext.request.contextPath}/student/tuixue",{id:data.Studid},function (data) {
                            table.reload('test');
                            layer.msg('退学成功！', {icon: 1});

                        },'text')

                        layer.close(index);
                    });
                }else if(obj.event === 'chongzhi'){
                    layer.confirm('确定要重置'+data.stuname+'的密码吗？', function(index){

                        $.post("${pageContext.request.contextPath}/student/chongzhi",{id:data.Studid},function (data) {
                            table.reload('test');
                            layer.msg('重置成功！默认密码为：123456', {icon: 1});
                        },'text')

                        layer.close(index);
                    });
                }
            });
            // 获取当前行以后进行的操作------------------------------------------
            table.on('row(test)',function(obj){
                var oo = obj.tr; //得到当前行元素对象
                var data = obj.data; //得到当前行数据
                selected =  data;
                //选中行样式
                obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
                //选中radio样式
                obj.tr.find('i[class="layui-anim layui-icon"]').trigger("click");
                settable(data.Studid);
            });


    // ----------------在校情况-----------------------------------------------------------------------------------------------------
            function settable(stuid){
                table.render({
                    elem: '#zaixiao'
                    , url: '${pageContext.request.contextPath}/student/getZxData?stuid='+stuid
                    , title: '添加学生在校情况'
                    , totalRow: true
                    ,height:257
                    , cols: [[
                        {type: 'radio', fixed: 'left'}
                        // , {field: 'happenid', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true, totalRowText: '合计'}
                        , {field: 'stuname', title: '学生姓名'}
                        , {field: 'happening', title: '记录情况'}
                        , {field: 'optime', title: '记录时间',templet : "<div>{{layui.util.toDateString(d.optime, 'yyyy年MM月dd日')}}</div>"}
                        , {field: 'empName', title: '记录人'}
                        , {fixed: 'right', title: '操作', toolbar: '#hrzxbar'}
                    ]]
                });

                table.on('row(zaixiao)',function(obj){
                    var oo = obj.tr; //得到当前行元素对象
                    var data = obj.data; //得到当前行数据
                    selected =  data;
                    //选中行样式
                    obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
                    //选中radio样式
                    obj.tr.find('i[class="layui-anim layui-icon"]').trigger("click");
                });
                //家庭信息————————————————————————————————————————————————————————————
                table.render({elem: '#family'
                        , url: '${pageContext.request.contextPath}/student/familyData?stuid='+stuid
                        , title: '添加学生家庭信息'
                        , totalRow: true
                        ,height:257
                        , cols: [[
                        {type: 'radio', fixed: 'left'}
                        , {field: 'stuname', title: '学生姓名'}
                        , {field: 'familyname', title: '亲属姓名'}
                        , {field: 'relation', title: '与学生关系'}
                        , {field: 'familyhone', title: '亲属电话'}
                        , {fixed: 'right', title: '操作', toolbar: '#hrjtbar'}
                    ]]
                });
                table.on('row(family)',function(obj){
                    var oo = obj.tr; //得到当前行元素对象
                    var data = obj.data; //得到当前行数据
                    selected =  data;
                    //选中行样式
                    obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
                    //选中radio样式
                    obj.tr.find('i[class="layui-anim layui-icon"]').trigger("click");
                });
                // -----考试成绩------------------------------
                table.render({elem: '#exam'
                    , url: '${pageContext.request.contextPath}/student/examData?stuid='+stuid
                    , title: '添加学生家庭信息'
                    , totalRow: true
                    ,height:257
                    , cols: [[
                        {type: 'radio', fixed: 'left'}
                        , {field: 'stuname', title: '学生姓名'}
                        , {field: 'termName', title: '学期'}
                        , {field: 'courseName', title: '考试科目'}
                        , {field: 'testType', title: '考试类型'}
                        , {field: 'score', title: '分数'}
                        , {field: 'Rescore', title: '补考分数'}
                        , {field: 'scoreTime', title: '考试时间',templet : "<div>{{layui.util.toDateString(d.scoreTime, 'yyyy年MM月dd日')}}</div>"}
                        , {field: 'remark', title: '备注'}
                        , {fixed: 'right', title: '操作', toolbar: '#hrksbar'}
                    ]]
                });

                // ------答辩表-----------------------
                table.render({elem: '#dbtab'
                    , url: '${pageContext.request.contextPath}/student/dbData?stuid='+stuid
                    , title: '添加学生答辩成绩'
                    , totalRow: true
                    ,height:257
                    , cols: [[
                        {type: 'radio', fixed: 'left'}
                        , {field: 'stuname', title: '学生姓名'}
                        , {field: 'projectName', title: '答辩项目'}
                        , {field: 'score1', title: '功能完善50'}
                        , {field: 'Score2', title: '技术难度10'}
                        , {field: 'Score3', title: '界面完美10'}
                        , {field: 'Score4', title: '回答问题10'}
                        , {field: 'Score5', title: '演示方法10'}
                        , {field: 'Score6', title: '语言表达10'}
                        , {field: 'Score7', title: '总分100'}
                        , {field: 'empName', title: '评分老师'}
                        , {field: 'Remark', title: '备注'}
                        , {fixed: 'right', title: '操作', toolbar: '#hrksbar'}
                    ]]
                });

                // ————————————————————————————————————————————————————————————
            }

            table.on('tool(zaixiao)', function(obj) {
                var data = obj.data;
                //console.log(obj)
                if (obj.event === 'updzx') {
                    layer.open({
                        type: 2,
                        title: '修改学生在校情况',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['520px', '550px'],
                        content: '${pageContext.request.contextPath}/student/toUpdateZx?zid='+data.happenid
                    });
                }else if(obj.event === 'delzx'){
                    layer.confirm('确定要删除该同学的在校信息吗？', function(index){
                        // alert(data.happenid)
                        $.post("${pageContext.request.contextPath}/student/delzx",{happenid:data.happenid},function (data) {
                            table.reload('zaixaio');
                            layer.msg('删除成功！')
                            table.reload('zaixiao')
                        },'text')
                        layer.close(index);
                    });
                }
            })
            // ——————在校情况结束——————————————————————————————————————————————————————————
            // ----学生记录判断------------------------
            $("#addzx").on("click",function () {
                var checkStatus = table.checkStatus('test');
                var data=checkStatus.data;
                if(data==""){
                    layer.msg("请选择学生");
                }else {
                    // console.log(data)
                    layer.open({
                        type: 2,
                        title: '添加学生在校情况',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['520px', '550px'],
                        content: '${pageContext.request.contextPath}/student/toAddzxPage?stuid='+data[0].Studid
                    });
                    // alert("test")
                }
            });
            // ——————家庭按钮判断————————————————————————————————————————
            $("#addjt").on("click",function () {
                var checkStatus = table.checkStatus('test');
                var data=checkStatus.data;
                if(data==""){
                    layer.msg("请选择学生");
                }else {
                    // console.log(data)
                    layer.open({
                        type: 2,
                        title: '添加学生家庭信息',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['520px', '550px'],
                        content: '${pageContext.request.contextPath}/student/toAddJtPage?stuid='+data[0].Studid
                    });
                    // alert("test")
                }
            });

            table.on('tool(family)', function(obj) {
                var data = obj.data;
                //console.log(obj)
                if (obj.event === 'updzx') {
                    layer.open({
                        type: 2,
                        title: '修改亲属信息',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['520px', '550px'],
                        content: '${pageContext.request.contextPath}/student/toUpdateJt?familyid='+data.familyid
                    });

                }else if(obj.event === 'delzx'){
                    layer.confirm('确定要删除该同学的家庭信息吗？', function(index){
                        // alert(data.happenid)
                        $.post("${pageContext.request.contextPath}/student/deljt",{familyid:data.familyid},function (data) {
                            table.reload('family');
                            layer.msg('删除成功！')
                            table.reload('family')
                        },'text')
                        layer.close(index);
                    });
                }
            })
    // ________________考试成绩_____________________________________
            table.on('tool(exam)', function(obj) {
                var data = obj.data;
                //console.log(obj)
                if (obj.event === 'upd') {
                    layer.open({
                        type: 2,
                        title: '修改学生成绩',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['1000px', '600px'],
                        content: '${pageContext.request.contextPath}/student/toUpdateExam?scoreId='+data.scoreId
                    });
                }
            })
        // ________答辩成绩_______________________________
            table.on('tool(dbtab)', function(obj) {
                var data = obj.data;

                //console.log(obj)
                if (obj.event === 'upd') {
                    layer.open({
                        type: 2,
                        title: '修改学生答辩成绩',
                        shadeClose: true,
                        shade: 0.4,
                        shadeclose:true,
                        area: ['1000px', '600px'],
                        content: '${pageContext.request.contextPath}/student/toUpdDb?replyId='+data.replyId
                    });
                }
            })

            // ____________________________分界线
        });
    </script>
</body>
</html>
