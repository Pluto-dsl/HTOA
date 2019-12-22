<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/21
  Time: 7:42
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
    <title>Document</title>
    <jsp:include page="../include.jsp"/>
</head>
<body>
    <form class="layui-form" id="form1" method="post">
        <input type="hidden" name="idd" id="idd" value="${id}">
        <div id="acc" style="margin-left: 10%;">

        </div>
        <button class="layui-btn" id="submit" lay-submit lay-filter="sub" style="margin-left: 32%;margin-top: 7%;">保存</button>
    </form>
</body>
    <script>
        // console.log(ddd);
        layui.use(['tree', 'util','form'], function() {
            let tree = layui.tree,
                layer = layui.layer,
                util = layui.util;
            let form = layui.form;

            form.on('submit(sub)', function(data){
                var data = data.field;

                let checkData = tree.getChecked('mytree');
                let chekid = [];
                for (var i = 0; i <checkData.length ; i++) {
                    // chekid.push(checkData[i].id);
                    for (let j = 0; j < checkData[i].children.length; j++) {
                        chekid.push(checkData[i].children[j].id);
                    }
                }

                let mid = $('#idd').val();
                $.post("${pageContext.request.contextPath}/controller/addUserCs",
                    {
                        mid:mid,
                        checkIds:chekid
                    },
                    function (data) {
                    },"text");
                // window.parent.location.reload();
                let index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);//关闭当前页
            })

            //渲染
            let inst1 = tree.render({
                elem: '#acc', //绑定标签元素
                data: ${json},    //加载菜单数据
                id: 'mytree',
                showCheckbox: true		//是否显示复选框
            });
            tree.setChecked('mytree',${selected})

        });
    </script>
</html>
