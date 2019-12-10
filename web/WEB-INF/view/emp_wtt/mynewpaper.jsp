<%--
  Created by IntelliJ IDEA.
  User: 梓怡
  Date: 2019/12/4
  Time: 19:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <jsp:include page="../include.jsp"></jsp:include>
    <title>Document</title>
    <style>
        .main{
            width: 450px;
            height: auto;
            margin: 0 auto;
        }
        .menu{
            font-size: 17px;
            padding-right: 30px;
            float: left;
        }
        .title{
            width: 520px;
            text-align: center;
            padding: 13px 0;
        }
    </style>
</head>
<body>
<button class="layui-btn layui-btn-primary" style="position: fixed" onclick="get_back()"><i class="layui-icon layui-icon-return"></i>返回</button>
<div class="main">
    <h1 class="title">宏图软件工作周报</h1>
    <div style="width:500px;padding:10px;float:left;color:#333">
        <div class="menu">部门：${list.depName}</div>
        <div class="menu">姓名：${list.empName}</div>
        <div class="menu">时间：${list.workDay}</div>
    </div>
    <div>
        <table class="layui-table" style="width: 100%;height: 800px">
            <tr>
                <td rowspan="3">
                    本周总结
                </td>
                <td>
                    <div>
                        本周情况
                    </div>
                </td>
                <td>
                    <div style="width:400px;height:100px">
                        ${list.weekCur}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    问题学生情况反馈
                </td>
                <td>
                    <div style="width:400px;height:100px">
                        ${list.studentQuestion}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    意见建议
                </td>
                <td>
                    <div style="width:400px;height:100px">
                        ${list.idea}
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    下周计划
                </td>
                <td>
                    下周计划
                </td>
                <td>
                    <div style="width:400px;height:100px">
                        ${list.weekNext}
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>

</body>
<script language="JavaScript">
    function get_back() {
        history.go(-1);
    }
</script>
</html>