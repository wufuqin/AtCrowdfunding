<%--
  完成随机抽签功能
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/login.css">
</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">

</nav>
<div class="container">
    <form class="form-signin" role="form">
        <h2 class="form-signin-heading">随机抽签</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="studentId" name="studentId" placeholder="请输入学号" autofocus>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="name" name="name" placeholder="请输入姓名" style="margin-top:10px;">
        </div>

        <a class="btn btn-lg btn-success btn-block" onclick="doLogin()" > 开始抽签</a>
        <%--<a class="btn btn-lg btn-success btn-block" onclick="" > 查看抽签结果</a>--%>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkLoginForm.js"></script>

<%--登录请求--%>
<script>
    function doLogin() {
        var studentId = $("#studentId");
        var name = $("#name");

    $.ajax({
        type : "POST",
        data : {
            "studentId" : studentId.val(),
            "name" : name.val()
        },
        url : "${APP_PATH}/doDraw.do",
        beforeSend : function () {
            loadingIndex = layer.msg('抽签中...', {icon: 16});
            return true;
        },
        success : function (result) {
            if (result.success){
                layer.close(loadingIndex);
                layer.msg("抽签成功");
                window.location.href = "${APP_PATH}/showDrawId.htm";
            }else {
                layer.msg(result.message);
            }
        },
        error : function () {
            layer.msg("抽签失败");
        }
    });
    }
</script>

</body>
</html>





















