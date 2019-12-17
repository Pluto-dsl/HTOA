<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/6
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
    <style>
        /*.layui-table-cell{
            height:auto !important;
        }*/
    </style>
</head>
<body>
    <div class="layui-tab" lay-filter="demo">
        <ul class="layui-tab-title">
            <li class="layui-this">工作经历</li>
            <li>教育背景</li>
            <li>家庭联系信息</li>
            <li>员工考核</li>
            <li>证件上传</li>
            <li><button onclick="toemp()" class="layui-btn">返回</button></li>
        </ul><%--工具栏--%>
        <div class="layui-tab-content">
            <script type="text/html" id="jobTop">
                    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i></a>
                    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i></a>
                    <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
            </script>
            <div class="layui-tab-item layui-show"><!--工作经历-->
                <table id="job" lay-filter="t1"></table>
            </div>
            <script type="text/html" id="educationTop"><!--教育背景-->
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del" ><i class="layui-icon">&#xe640;</i></a>
            </script>
            <div class="layui-tab-item">
                <table id="education" lay-filter="t2"></table>
            </div>
            <script type="text/html" id="familyInfoTop"><!--家庭联系信息-->
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
            </script>
            <div class="layui-tab-item">
                <table id="familyInfo" lay-filter="t3"></table>
            </div>
            <script type="text/html" id="aduitTop"><!--员工考核-->
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add"> <i class="layui-icon">&#xe654;</i></a>
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit"> <i class="layui-icon">&#xe642;</i></a>
            <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
            </script>
            <div class="layui-tab-item">
                <table id="aduit" lay-filter="t4"></table>
            </div>
            <script type="text/html" id="AnnexTop"><!--证件上传-->
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="add" id="upload" title="新增"> <i class="layui-icon">&#xe654;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="upl" title="下载证件图"> <i class="layui-icon">&#xe601;</i></a>
                <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del" title="删除"><i class="layui-icon">&#xe640;</i></a>
            </script>
            <div class="layui-tab-item">
                <table id="Annex" lay-filter="t5"></table>
            </div>
        </div>
    </div>
    <!--添加弹窗-->
    <!--工作经历-->
    <div  id="windowsJob"  style="margin-left: 5%;display: none;">
        <form id="jobform" class="layui-form" <%--action="<%=request.getContextPath()%>/zeroEmpInfo/addjob"--%> style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <input type="hidden"  name="Empid" value="${empId}"/>
                <input type="hidden" id="jobid"  name="Jobid" value="0"/>
                <label class="layui-form-label">公司名称:</label>
                <div  class="layui-input-block">
                    <input id="companyName" type="text" name="companyName" required lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">岗位:</label>
                <div class="layui-input-block">
                    <input id="degree" type="text" name="degree" required lay-verify="required" class="layui-input" <%--readonly="readonly"不可编辑--%>>
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">入职时间:</label>
                <div class="layui-input-block">
                    <input id="startDate" type="text" name="startDate" required lay-verify="required" class="layui-input" >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">离职时间:</label>
                <div class="layui-input-block">
                    <input id="endDate" type="text" name="endDate" required lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">离职原因:</label>
                <div class="layui-input-block">
                    <input id="reason" type="text" name="reason"  class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明:</label>
                <div class="layui-input-block">
                    <textarea id="Remark" name="Remark" class="layui-textarea"> </textarea>
                </div>
            </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="jobAction" >保存</button>
                </div>
            </div>
        </form>
    </div>
    <!--教育背景-->
    <div  id="windowsEducation"  style="margin-left: 5%;display: none;">
        <form id="educationform" class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <input type="hidden"  name="Empid" value="${empId}"/>
                <input type="hidden" id="collegeid"  name="collegeid" value="0"/>
                <label class="layui-form-label">学校名称:</label>
                <div  class="layui-input-block">
                    <input id="collegeName" type="text" name="collegeName" required lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">学历:</label>
                <div class="layui-input-block">
                    <input id="edegree" type="text" name="degree" required lay-verify="required" class="layui-input" <%--readonly="readonly"不可编辑--%>>
                </div>

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">入校时间:</label>
                <div class="layui-input-block">
                    <input id="estartDate" type="text" name="startDate" required lay-verify="required" class="layui-input" >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">离校时间:</label>
                <div class="layui-input-block">
                    <input id="eendDate" type="text" name="endDate" required lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明:</label>
                <div class="layui-input-block">
                    <textarea id="eRemark" name="Remark" class="layui-textarea"> </textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="educationformAction" >保存</button>
                </div>
            </div>
        </form>
    </div>
    <!--家庭联系信息-->
    <div  id="windowsFamilyInfo"  style="margin-left: 5%;display: none;">
        <form id="familyInfoform" class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <input type="hidden"  name="Empid" value="${empId}"/>
                <input type="hidden" id="familyid"  name="familyid" value="0"/>
                <label class="layui-form-label">联系人名称:</label>
                <div  class="layui-input-block">
                    <input id="contactName" type="text" name="contactName" required lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">与员工关系:</label>
                <div class="layui-input-block">
                    <input id="relationship" type="text" name="relationship" required lay-verify="required" class="layui-input" <%--readonly="readonly"不可编辑--%>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系电话:</label>
                <div class="layui-input-block">
                    <input id="Phone" type="text" name="Phone" required lay-verify="required" class="layui-input" <%--readonly="readonly"不可编辑--%>>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明:</label>
                <div class="layui-input-block">
                    <textarea id="fRemark" name="Remark" class="layui-textarea"> </textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="familyInfoAction" >保存</button>
                </div>
            </div>
        </form>
    </div>
    <!--员工考核-->
    <div  id="windowsaduit"  style="margin-left: 5%;display: none;">
        <form id="aduitform" class="layui-form"  style="margin-right: 100px;margin-top: 35px;" method="post">
            <div class="layui-form-item">
                <input type="hidden"  name="Empid" value="${empId}"/>
                <input type="hidden" id="aduitLogid"  name="aduitLogid" value="0"/>
                <label class="layui-form-label">考核指标:</label>
                <div  class="layui-input-block">
                    <select lay-filter="aduitid" name="aduitModelid">
                        <c:forEach items="${empaduit}" var="aduit">
                            <option value="${aduit.aduitModelid}">${aduit.aduitName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">考核分数:</label>
                <div class="layui-input-block">
                    <select id="feng" name="Scores">
                        <c:if test="${scores>0}">
                            <c:forEach  begin="1" end="${scores}" varStatus="index">
                                <option value="${index.count}">+${index.count}</option>
                            </c:forEach>
                        </c:if>
                        <c:if test="${scores<0}">
                            <c:forEach  begin="1" end="${scores}" varStatus="index">
                                <option value="-${index.count}">-${index.count}</option>
                            </c:forEach>
                        </c:if>
                    </select>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明:</label>
                <div class="layui-input-block">
                    <textarea id="dRemark" name="Remark" class="layui-textarea"> </textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="aduitAction" >保存</button>
                </div>
            </div>
        </form>
    </div>
    <!--证件上传-->
    <div  id="windowsannex"  style="margin-left: 5%;display: none;">
        <form id="annexform" class="layui-form" action="<%=request.getContextPath()%>/zeroEmpInfo/addannex?empId=${empId}" style="margin-right: 100px;margin-top: 35px;" method="post" enctype="multipart/form-data">
            <div class="layui-form-item">
                <input type="hidden"  name="Empid" value="${empId}"/><%--被操作员工id--%>
                <label class="layui-form-label">证件名称:</label>
                <div  class="layui-input-block">
                    <input id="annexName" type="text" name="annexName" required lay-verify="required"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">上传证件:</label>
                <div class="layui-input-block">
                        <input type="file" multiple name="annexPath" onchange="upload(this)"  required lay-verify="required"/>
                            <%--<div class="layui-upload uploadbuchong" style="margin-top: 20px;margin-left: 60px;">
                                <button type="button" class="layui-btn layui-btn-normal" id="test8" name="face"><i class="layui-icon">&#xe67c;</i>上传图片</button>
                            </div>--%>
                    <div id="huixian" style="height:100px"></div>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明:</label>
                <div class="layui-input-block">
                    <textarea id="aRemark" name="Remark" class="layui-textarea"> </textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit lay-filter="annexAction" >上传</button>
                </div>
            </div>
        </form>
    </div>
</body>
<script>
    //员工
    layui.use([ 'laydate','element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        //时间选择器
        laydate.render({//入职时间
            elem: '#startDate', //指定元素
        });
        laydate.render({//入职时间
            elem: '#endDate' //指定元素
        });
        //工作经历
        table.render({
                id:'jobId',
                elem: '#job'
                ,height: 500
                ,url: '<%=request.getContextPath()%>/zeroEmpInfo/job?empId=${empId}' //数据接口
                ,toolbar: '#jobTop' //开启头部工具栏，并为其绑定左侧模板
                //,totalRow: true //开启合计行
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left',templet:"<input type='hidden' value='{{d.jobId}}'/>"}
                    ,{field: 'jobid', title: 'id',hide:'true'}
                    ,{field: 'companyName', title: '公司名称', width:100, fixed: 'center'/*向右靠*/}
                    ,{field: 'degree', title: '岗位', width:100}
                    ,{field: 'startDate', title: '入职时间', width:150,templet : "<div>{{layui.util.toDateString(d.startDate, 'yyyy年MM月dd日')}}</div>"}
                    ,{field: 'endDate', title: '离职时间', width:150,templet : "<div>{{layui.util.toDateString(d.endDate, 'yyyy年MM月dd日')}}</div>"}
                    ,{field: 'reason', title: '离职原因', width:160}
                    ,{field: 'remark', title: '说明', width:200}
                ]]
        });
        //头部工具栏
        var jobwin;
        table.on('toolbar(t1)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                var data = checkStatus.data;
                switch(obj.event){
                    case 'add':
                        jobwin = layer.open({
                            type: 1,
                            title:'新增工作经历',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['600px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#windowsJob')
                            ,cancel: function(index, layero){
                                //关闭清空表单
                                document.getElementById("jobform").reset();
                                return true;
                            }
                        });
                        break;
                    case 'edit'://编辑
                        if(data.length === 0){
                            layer.msg('请选择一行');
                        } else if(data.length > 1){
                            layer.msg('只能同时编辑一个');
                        } else {
                            jobwin = layer.open({
                                type: 1,
                                title:'编辑工作经历',
                                skin: 'layui-layer-demo', //样式类名
                                closeBtn: 1, //不显示关闭按钮
                                area: ['600px', '550px'],
                                fixed: false, //不固定
                                maxmin: true,
                                shadeClose: true, //开启遮罩关闭
                                content: $('#windowsJob'),
                                success: function(layero, index){
                                    $(data).each(function (index,elemnt) {
                                        $("#jobid").val(elemnt.jobid);
                                        $("#companyName").val(elemnt.companyName);
                                        $("#degree").val(elemnt.degree);
                                        $("#startDate").val(layui.util.toDateString(elemnt.startDate, 'yyyy-MM-dd'));
                                        $("#endDate").val(layui.util.toDateString(elemnt.startDate, 'yyyy-MM-dd'));
                                        $("#reason").val(elemnt.reason);
                                        $("#Remark").val(elemnt.remark);
                                    });
                                },
                                cancel: function(index, layero){
                                    //关闭清空表单
                                    document.getElementById("jobform").reset();
                                    $("#companyName").val(0);
                                    return true;
                                }
                            });
                        }
                        break;
                    case 'del'://删除
                        if(data.length === 0){
                            layer.msg('请至少选择一行');
                        } else {
                            var allid="";
                            $(data).each(function (index,elemnt) {
                                //console.log(elemnt.jobid);
                                allid +=elemnt.jobid+",";
                            });
                            allid = allid.substr(0,allid.length-1);
                            layer.confirm('确定删除吗?', function(index){
                                layer.close(index);
                                //向服务端发送删除指令
                                $.post("<%=request.getContextPath()%>/zeroEmpInfo/delJob",{allid:allid},function (d) {
                                    table.reload('jobId',{
                                        url:'<%=request.getContextPath()%>/zeroEmpInfo/job?empId=${empId}',
                                    })//删除后刷新表格
                                },"text")
                            });
                        }
                        break;
                }
            });

        //新增工作经历
        form.on('submit(jobAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/zeroEmpInfo/addjob", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    if(data='yes'){
                        table.reload('jobId',{
                            url:'<%=request.getContextPath()%>/zeroEmpInfo/job?empId=${empId}',
                        })
                    }
                    layer.close(jobwin);
                    layer.msg('保存成功!');
                    document.getElementById("educationform").reset();
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    });
    /*
    layui.use('element', function(){
        var element = layui.element;
        //获取hash来切换选项卡，假设当前地址的hash为lay-id对应的值
        var layid = location.hash.replace(/^#current=/, '');//current为刚才定义的lay-filter
        element.tabChange('current', layid); //假设当前地址为：http://a.com#current=two，那么选项卡会自动切换到“资产发现”这一项
        //监听Tab切换，以改变地址hash值
        element.on('tab(current)', function(){
            location.hash = 'current='+ this.getAttribute('lay-id');
        });
    });*/

    //教育背景------------------------------------------------------------------------------------------------------
    layui.use([ 'laydate','element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        //时间选择器
        //时间选择器
        laydate.render({//入职时间
            elem: '#estartDate', //指定元素
        });
        laydate.render({//入职时间
            elem: '#eendDate' //指定元素
        });
        //var educationTable;
        layui.use('table', function(){
            table = layui.table;
            table.render({
                id:'etabe'
                ,elem: '#education'
                ,height: 500
                ,url: '<%=request.getContextPath()%>/zeroEmpInfo/education?empId=${empId}' //数据接口
                ,toolbar: '#educationTop' //开启头部工具栏，并为其绑定左侧模板
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'},//开启多选
                    ,{field: 'collegeid', title: 'id',hide:'true'}
                    ,{field: 'collegeName', title: '学校名称', width:150/*, fixed: 'left'向右靠*/}
                    ,{field: 'degree', title: '学历', width:100}
                    ,{field: 'startDate', title: '入校时间', width:150,templet : "<div>{{layui.util.toDateString(d.startDate, 'yyyy年MM月dd日')}}</div>"}
                    ,{field: 'endDate', title: '毕业时间', width:150,templet : "<div>{{layui.util.toDateString(d.endDate, 'yyyy年MM月dd日')}}</div>"}
                    ,{field: 'remark', title: '奖惩情况', width:200}
                ]]
            })
        });
        //头部工具栏
        var educationwin;
        table.on('toolbar(t2)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch(obj.event){
                case 'add':
                    educationwin = layer.open({
                        type: 1,
                        title:'新增教育背景',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['600px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windowsEducation')
                        ,cancel: function(index, layero){
                            //关闭清空表单
                            document.getElementById("educationform").reset();
                            return true;
                        }
                    });
                    break;
                case 'edit'://编辑
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        educationwin = layer.open({
                            type: 1,
                            title:'编辑教育背景',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['600px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#windowsEducation'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt) {
                                    $("#collegeid").val(elemnt.collegeid);
                                    $("#collegeName").val(elemnt.collegeName);
                                    $("#edegree").val(elemnt.degree);
                                    $("#estartDate").val(layui.util.toDateString(elemnt.startDate, 'yyyy-MM-dd'));
                                    $("#eendDate").val(layui.util.toDateString(elemnt.endDate, 'yyyy-MM-dd'));
                                    $("#eRemark").val(elemnt.remark);
                                });
                            },
                            cancel: function(index, layero){
                                //关闭清空表单
                                document.getElementById("educationform").reset();
                                $("#collegeid").val(0);
                                return true;
                            }
                        });
                    }
                    break;
                case 'del'://删除
                    if(data.length === 0){
                        layer.msg('请至少选择一行');
                    } else {
                        var allid="";
                        $(data).each(function (index,elemnt) {
                            //console.log(elemnt.jobid);
                            allid +=elemnt.collegeid+",";
                        });
                        allid = allid.substr(0,allid.length-1);
                        layer.confirm('确定删除吗?', function(index){
                            layer.close(index);
                            //向服务端发送删除指令
                            $.post("<%=request.getContextPath()%>/zeroEmpInfo/deleducation",{allid:allid},function (d) {
                                table.reload('etabe',{//删除后刷新表格
                                    url:'<%=request.getContextPath()%>/zeroEmpInfo/education?empId=${empId}',
                                })
                            },"text")
                        });
                    }
                    break;
            }
        });
        //新增教育背景
        form.on('submit(educationformAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/zeroEmpInfo/addeducation", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    if(data='yes'){
                        table.reload('etabe',{
                            url:'<%=request.getContextPath()%>/zeroEmpInfo/education?empId=${empId}',
                        })
                    }
                    layer.close(educationwin);
                    layer.msg('保存成功!');
                    document.getElementById("educationform").reset();
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    })


    //家庭信息------------------------------------------------------------------------------------------
    layui.use([ 'laydate','element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;

        layui.use('table', function(){
            table = layui.table;
            //家庭联系人
            table.render({
                elem: '#familyInfo'
                ,id:'ftable'
                ,height: 500
                ,url: '<%=request.getContextPath()%>/zeroEmpInfo/familyInfo?empId=${empId}' //数据接口
                ,toolbar: '#familyInfoTop' //开启头部工具栏，并为其绑定左侧模板
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'},//开启多选
                    ,{field: 'familyid', title: 'id',hide:'true'}
                    ,{field: 'contactName', title: '联系人名称', width:150}
                    ,{field: 'relationship', title: '与员工关系', width:100}
                    ,{field: 'phone', title: '联系电话', width:120}
                    ,{field: 'remark', title: '说明', width:200}
                ]]
            })
        });

        //头部工具栏
        var familyInfowin;
        table.on('toolbar(t3)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch(obj.event){
                case 'add':
                    familyInfowin = layer.open({
                        type: 1,
                        title:'新建家庭联系信息',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['600px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windowsFamilyInfo')
                        ,cancel: function(index, layero){
                            //关闭清空表单
                            document.getElementById("familyInfoform").reset();
                            return true;
                        }
                    });
                    break;
                case 'edit'://编辑
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        familyInfowin = layer.open({
                            type: 1,
                            title:'编辑家庭联系信息',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['600px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#windowsFamilyInfo'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt) {
                                    $("#familyid").val(elemnt.familyid);
                                    $("#contactName").val(elemnt.contactName);
                                    $("#relationship").val(elemnt.relationship);
                                    $("#Phone").val(elemnt.phone);
                                    $("#fRemark").val(elemnt.remark);
                                });
                            },
                            cancel: function(index, layero){
                                //关闭清空表单
                                document.getElementById("familyInfoform").reset();
                                $("#familyid").val(0);
                                return true;
                            }
                        });
                    }
                    break;
                case 'del'://删除
                    if(data.length === 0){
                        layer.msg('请至少选择一行');
                    } else {
                        var allid="";
                        $(data).each(function (index,elemnt) {
                            //console.log(elemnt.jobid);
                            allid +=elemnt.familyid+",";
                        });
                        allid = allid.substr(0,allid.length-1);
                        layer.confirm('确定删除吗?', function(index){
                            layer.close(index);
                            //向服务端发送删除指令
                            $.post("<%=request.getContextPath()%>/zeroEmpInfo/delfamilyInfo",{allid:allid},function (d) {
                                table.reload('ftable',{//删除后刷新表格
                                    url:'<%=request.getContextPath()%>/zeroEmpInfo/familyInfo?empId=${empId}',
                                })
                            },"text")
                        });
                    }
                    break;
            }
        });
        //新增教育背景
        form.on('submit(familyInfoAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/zeroEmpInfo/addfamilyInfo", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    if(data='yes'){
                        table.reload('ftable',{
                            url:'<%=request.getContextPath()%>/zeroEmpInfo/familyInfo?empId=${empId}',
                        })
                        layer.close(familyInfowin);
                        layer.msg('保存成功!');
                        document.getElementById("familyInfoform").reset();
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    })
    //员工考核-----------------------------------------------------------------------------------------------
    layui.use([ 'laydate','element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        $ = layui.jquery;
        var form = layui.form;


        layui.use('table', function(){
            table = layui.table;
            //家庭联系人
            table.render({
                elem: '#aduit'
                ,id:'dtable'
                ,height: 500
                ,url: '<%=request.getContextPath()%>/zeroEmpInfo/aduit?empId=${empId}' //数据接口
                ,toolbar: '#aduitTop' //开启头部工具栏，并为其绑定左侧模板
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'},//开启多选
                    ,{field: 'aduitLogid', title: 'id',hide:'true'}
                    ,{field: 'aduitModelid', title: 'mid',hide:'true'}
                    ,{field: 'Empid', title: 'eid', hide:'true'}
                    ,{field: 'aduitName', title: '考核指标', width:200}
                    ,{field: 'Scores', title: '考核分数', width:100}
                    ,{field: 'auditDate', title: '考核时间', width:200,templet : "<div>{{layui.util.toDateString(d.auditDate, 'yyyy年MM月dd日 HH:mm')}}</div>"}
                    ,{field: 'Image', title: '图片', width:110,templet: function (d) {
                            console.log(d.Image)
                            if (d.Image!=null){
                                return "<div><img src='"+d.Image+"' style='width: 100px'/></div>";
                            }else{
                                return "";
                            }
                        }
                    }
                    ,{field: 'Remark', title: '说明', width:200}
                    ,{field: 'auditPerson', title: '录入人员', width:200}
                ]]
            })
        });

        //头部工具栏
        var aduitwin;
        table.on('toolbar(t4)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch(obj.event){
                case 'add':
                    $("#aduitLogid").val(0);
                    aduitwin = layer.open({
                        type: 1,
                        title:'新增员工考核',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['800px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windowsaduit')
                        //关闭时清空表单
                        //document.getElementById("annexform").reset();

                    });
                    break;
                case 'edit'://编辑
                    if(data.length === 0){
                        layer.msg('请选择一行进行下载');
                    }else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        aduitwin = layer.open({
                            type: 1,
                            title:'编辑家庭联系信息',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['800px', '550px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#windowsaduit'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt) {
                                    var aduitLogid = elemnt.aduitLogid;
                                    $("#aduitLogid").val(aduitLogid);
                                    $("#dRemark").val(elemnt.Remark);
                                });
                            },
                            cancel: function(index, layero){
                                $("#aduitLogid").val(0);
                                return true;
                            }
                        });
                    }
                    break;
                case 'del'://删除
                    if(data.length === 0){
                        layer.msg('请至少选择一行');
                    } else {
                        var allid="";
                        $(data).each(function (index,elemnt) {
                            allid +=elemnt.aduitLogid+",";
                        });
                        allid = allid.substr(0,allid.length-1);
                        layer.confirm('确定删除吗?', function(index){
                            layer.close(index);
                            //向服务端发送删除指令
                            $.post("<%=request.getContextPath()%>/zeroEmpInfo/deladuit",{allid:allid},function (d) {
                                table.reload('dtable',{//删除后刷新表格
                                    url:'<%=request.getContextPath()%>/zeroEmpInfo/aduit?empId=${empId}',
                                })
                            },"text")
                        });
                    }
                    break;
            }
        });
        //动态级联分数
        form.on('select(aduitid)', function (data) {
            var id = data.elem[data.elem.selectedIndex].value;
            //选择考核指标将分数
            $("#feng").empty();
            //根据考核指标id查询分数
            $.ajax({
                url:"<%=request.getContextPath()%>/zeroEmpInfo/aduitScore",
                type: "post",
                data:{
                    id : id
                },
                datatype: "text",
                success:function (data) {
                    var fengs
                    if(data>0){
                        for (var i = 1; i <=data ; i++) {
                            fengs += "<option value=\"" + i + "\">+" + i + "</option>";
                        }
                    }else if(data<0){
                        data = data * (-1);
                        for (var i = 1; i <=data ; i++) {
                            fengs += "<option value=\"-" + i + "\">-" + i + "</option>";
                        }
                    }
                    $("#feng").append(fengs);
                    form.render('select');
                }
            });
        });
        //新增考核
        form.on('submit(aduitAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%=request.getContextPath()%>/zeroEmpInfo/addaduit", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    if(data='yes'){
                        table.reload('dtable',{
                            url:'<%=request.getContextPath()%>/zeroEmpInfo/aduit?empId=${empId}',
                        })
                        layer.close(aduitwin);
                        layer.msg('保存成功!');
                        document.getElementById("aduitform").reset();
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });
    })

    //证件上传---------------------------------------------------------------------------------------------------
    layui.use([ 'laydate','element', 'table', 'layer', 'form' ,'laydate','upload'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;

        var upload = layui.upload;

       /* upload.render({
            elem: '#test8'
            ,size:1024*10//限制文件大小，单位 KB
            ,auto: false//非自动上传
            /!*,accept:'images'*!/
            ,acceptMime: 'image/jpg, image/png'
            ,multiple: true
        });*/
        layui.use('table', function(){
            table = layui.table;
            //家庭联系人
            table.render({
                elem: '#Annex'
                ,id:'atable'
                ,height: 500
                ,url: '<%=request.getContextPath()%>/zeroEmpInfo/annex?empId=${empId}' //数据接口
                ,toolbar: '#AnnexTop' //开启头部工具栏，并为其绑定左侧模板
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'},//开启多选
                    ,{field: 'annexId', title: 'id',hide:'true'}
                    ,{field: 'empName', title: '员工名称', width:150}
                    ,{field: 'annexName', title: '证件名称', width:100}
                    ,{field: 'annexPath', title: '证件图', width:110,templet : "<div><img src='<%=request.getContextPath()%>/{{d.annexPath}}' style='width: 100px'/></div>"}
                    ,{field: 'annexDate', title: '上传时间', width:200,templet : "<div>{{layui.util.toDateString(d.annexDate, 'yyyy年MM月dd日 HH:mm')}}</div>"}
                    ,{field: 'sessionName', title: '上传人', width:200}
                    ,{field: 'remark', title: '备注', width:200}
                ]]
            })
        });

        //头部工具栏
        var annexwin;
        table.on('toolbar(t5)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            var data = checkStatus.data;
            switch(obj.event){
                case 'add':
                    annexwin = layer.open({
                        type: 1,
                        title:'上传证件信息',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['600px', '550px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#windowsannex')
                        //关闭时清空表单
                        //document.getElementById("annexform").reset();
                    });
                    break;
                case 'upl'://下载
                    if(data.length === 0){
                        layer.msg('请选择一行进行下载');
                    }else {
                        $(data).each(function (index,element) {
                            var imgurl ='<%=request.getContextPath()%>/'+element.annexPath;
                            var a = $("<a></a>").attr("href", imgurl).attr("download", element.annexName+".png").appendTo("body");
                            a[0].click();
                            a.remove();
                        });
                    }
                    break;
                case 'del'://删除
                    if(data.length === 0){
                        layer.msg('请至少选择一行');
                    } else {
                        var allid="";
                        $(data).each(function (index,elemnt) {
                            //console.log(elemnt.jobid);
                            allid +=elemnt.annexId+",";
                        });
                        allid = allid.substr(0,allid.length-1);
                        layer.confirm('确定删除吗?', function(index){
                            layer.close(index);
                            //向服务端发送删除指令
                            $.post("<%=request.getContextPath()%>/zeroEmpInfo/delannex",{allid:allid},function (d) {
                                table.reload('atable',{//删除后刷新表格
                                    url:'<%=request.getContextPath()%>/zeroEmpInfo/annex?empId=${empId}',
                                })
                            },"text")
                        });
                    }
                    break;
            }
        });

        /*//新增文件上传
        form.on('submit(annexAction)', function(data){
            $.ajax({
                type: 'post',
                url: "<%--<%=request.getContextPath()%>--%>/zeroEmpInfo/addannex?empId=<%--${empId}--%>", // ajax请求路径
                async:true,
                dataType: "text",
                data:data.field,
                success: function(data){
                    if(data='yes'){
                        table.reload('atable',{//刷新表格
                            url:'<%--<%=request.getContextPath()%>--%>/zeroEmpInfo/annex?empId=<%--${empId}--%>',
                        })
                        layer.close(annexwin);
                        layer.msg('上传成功!');
                        document.getElementById("annexform").reset();
                    }
                }
            });
            return false;//禁止跳转，否则会提交两次，且页面会刷新
        });*/
    })

    //图片回显方法
    function upload(obj){
        var f = obj.files;
        var str = "";
        for(var i=0;i<f.length;i++){
            var reader = new FileReader();
            reader.readAsDataURL(f[i]);
            reader.onload = function(e){
                str+='<img src="'+e.target.result+'" height="100px"/>';
                document.getElementById("huixian").innerHTML = str;
            }
        }
    }
    function toemp() {
        window.location.href="<%=request.getContextPath()%>/zeroEmp/toemp";
    }
</script>
</html>
