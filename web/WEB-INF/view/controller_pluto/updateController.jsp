<%--
  Created by IntelliJ IDEA.
  User: Pluto
  Date: 2019/12/19
  Time: 20:52
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui/layui.js" ></script>
    <script src="${pageContext.request.contextPath}/js/echarts/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.4.1.min.js"></script>
    <link href="${pageContext.request.contextPath}/imgs/icon/favicon.ico" rel="icon" type="image/x-ico">
</head>
<body>

    <form class="layui-form" id="form1" method="post">
        <input type="hidden" name="idd" id="idd" value="${id}">
        <div id="con" style="margin-left: 10%;">

        </div>
        <button class="layui-btn" id="submit" lay-submit lay-filter="sub" style="margin-left: 32%;margin-top: 7%;">保存</button>
    </form>

    <script>

        // ____分界线____________________

        var ddd = [];
        $.ajax({
            url:"${pageContext.request.contextPath}/controller/toJson",
            type:"post",
            async:false,
            dataType:'json',
            success:function (data) {
                //console.log(data)
                ddd=data;
            }
        })
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
                    chekid.push(checkData[i].id);
                    // console.log(checkData[i].id);
                    for (let j = 0; j < checkData[i].children.length; j++) {
                        // console.log(checkData[i].children[j].id);
                        chekid.push(checkData[i].children[j].id);
                        for (let k = 0; k < checkData[i].children[j].children.length ; k++) {
                            chekid.push(checkData[i].children[j].children[k].id)
                            // console.log(checkData[i].children[j].children[k].id)
                        }
                    }
                }
                for (let i = 0; i < chekid.length; i++) {
                    console.log(chekid[i])
                }

                let mid = $('#idd').val();
                $.post("${pageContext.request.contextPath}/controller/updC",
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
                elem: '#con', //绑定标签元素
                data: ddd,    //加载菜单数据
                id: 'mytree',
                showCheckbox: true		//是否显示复选框
            });
            tree.setChecked('mytree',${oldData})

        });
    </script>
</body>
</html>