<%--
  Created by IntelliJ IDEA.
  User: 老实方丈
  Date: 2019/12/5
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <div class="site-text site-block">
        <form>
            <div class="layui-form-item">
                <label class="layui-form-label">输入框</label>
                <div class="layui-input-block">
                    <input type="text" name="" required lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">选择框</label>
                <div class="layui-input-block">
                    <%--<select name="city" lay-verify="">
                        <option value="010">北京</option>
                        <option value="021" disabled>上海（禁用效果）</option>
                        <option value="0571" selected>杭州</option>
                    </select>--%>
                    <div class="layui-unselect layui-form-select">
                        <div class="layui-select-title">
                            <input type="text" placeholder="请选择" value readonly class="layui-input layui-unselect">
                            <i class="layui-edge"></i>
                        </div>
                        <dl class="layui-anim layui-anim-upbit">
                            <dd lay-value class="layui-select-tips">请选择</dd>
                            <dd lay-value="0" class="">北京</dd>
                            <dd lay-value="1" class="">上海</dd>
                            <dd lay-value="2" class="">深圳</dd>
                        </dl>
                    </div>
                </div>
            </div>

        </form>
    </div>
</body>
<script>

</script>
</html>
