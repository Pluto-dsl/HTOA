<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2019/12/15
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../include.jsp" />
</head>
<body>
<div id="addWin" style="display: none">
    <form id="addFrom" class="layui-form">
        <table align="center" style="margin-top: 5%;border-collapse: separate;border-spacing: 10px 30px;">
            <tr>
                <td id="test1"></td>
                <td>
                    <select name="number1"  lay-verify="required">
                        <option value="">选择分数</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td id="test2"></td>
                <td>
                    <select name="number2"  lay-verify="required">
                        <option value="">选择分数</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td id="test3"></td>
                <td>
                    <select name="number3"  lay-verify="required">
                        <option value="">选择分数</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td id="test4" ></td>
                <td>
                    <select name="number4"  lay-verify="required">
                        <option value="">选择分数</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td id="test5" name="test5"></td>
                <td>
                    <select name="number5"  lay-verify="required">
                        <option value="">选择分数</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" id="suggesText" name="suggesText">问题与意见</td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="sugges" name="sugges" required lay-verify="required" placeholder="问题与意见" autocomplete="off" class="layui-input">
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
<script>
    layui.use([ 'element', 'table', 'layer', 'form' ,'laydate'],function() {
        var element = layui.element;
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
    });
</script>
</html>
