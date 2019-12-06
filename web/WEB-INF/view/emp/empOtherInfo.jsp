<%--
  Created by IntelliJ IDEA.
  User: 82346
  Date: 2019/12/6
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
    <div class="layui-tab" lay-filter="demo">
        <ul class="layui-tab-title">
            <li class="layui-this">工作经历</li>
            <li>教育背景</li>
            <li>家庭联系信息</li>
            <li>员工考核</li>
            <li>证件上传</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item">
                <table id="job" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item">
                <table id="education" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item">
                <table id="familyInfo" lay-filter="test"></table>
            </div>
            <div class="layui-tab-item">
                员工考核
            </div>
            <div class="layui-tab-item">
                证件上传
            </div>
        </div>
    </div>
</body>
<script>
    var element = layui.element;
    layui.use('element', function(){
        var element = layui.element;
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

    var table;
    layui.use('table', function(){
        table = layui.table;
        //工作经历
        table.render({
            elem: '#job'
            ,height: 500
            ,url: '<%=request.getContextPath()%>/zeroEmpInfo/job?empId=${empId}' //数据接口
            ,cols: [[ //表头
                {field: 'companyName', title: '公司名称', width:100/*, fixed: 'left'向右靠*/}
                ,{field: 'degree', title: '岗位', width:100}
                ,{field: 'startDate', title: '入职时间', width:100}
                ,{field: 'endDate', title: '离职时间', width:100}
                ,{field: 'reason', title: '离职原因', width:160}
                ,{field: 'Remark', title: '说明', width:200}
            ]]
        })
        //教育背景
        table.render({
            elem: '#education'
            ,height: 500
            ,url: '<%=request.getContextPath()%>/zeroEmpInfo/education?empId=${empId}' //数据接口
            ,cols: [[ //表头
                {field: 'collegeName', title: '学校名称', width:150/*, fixed: 'left'向右靠*/}
                ,{field: 'degree', title: '学历', width:100}
                ,{field: 'startDate', title: '入校时间', width:100}
                ,{field: 'endDate', title: '毕业时间', width:100}
                ,{field: 'Remark', title: '奖惩情况', width:200}
            ]]
        })
        //家庭联系人
        table.render({
            elem: '#familyInfo'
            ,height: 500
            ,url: '<%=request.getContextPath()%>/zeroEmpInfo/familyInfo?empId=${empId}' //数据接口
            ,cols: [[ //表头
                {field: 'contactName', title: '联系人名称', width:150}
                ,{field: 'relationship', title: '与员工关系', width:100}
                ,{field: 'Phone', title: '联系电话', width:120}
                ,{field: 'Remark', title: '说明', width:200}
            ]]
        })
        //时间处理
        //员工考核

        //证件上传

    })
</script>
</html>
