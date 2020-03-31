<%--
  重置密码页面
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
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="${APP_PATH}/index.htm" style="font-size:32px;">众筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>
<div class="container">
    <form id="restPasswordForm" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 重置密码</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginacct" name="loginacct" placeholder="请输入账户或者注册时的手机号" autofocus>
        </div>

        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userpswd" name="userpswd" placeholder="请输入密码" autofocus>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="请再次输入密码" autofocus>
        </div>

        <div class="form-group has-success has-feedback">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="checkCode" name="checkCode" placeholder="请输入验证码">
                </div>
                <a href="javascript:refreshCode();">
                    <img src="${APP_PATH}/CheckCodeServlet" title="看不清" id="vcode"/>
                </a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <a type="button"  class="btn btn-info form-control" style="width: 136px" onclick="restPassword()">确认</a>
            </div>
            <a type="button" class="btn btn-info form-control" style="width: 150px" href="${APP_PATH}/login.htm"> 返回</a>
        </div>

    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkRestPassword.js"></script>
<%--切换验证码--%>
<script>
    function refreshCode(){
        var vcode = document.getElementById("vcode");  //1.获取验证码图片对象
        vcode.src = "${pageContext.request.contextPath}/CheckCodeServlet?time="+new Date().getTime();   //2.设置其src属性，加时间戳
    }
</script>

<%--完成重置密码--%>
<script>
    function restPassword() {
        var floginacct = $("#floginacct");
        var fuserpswd = $("#fuserpswd");
        var ffuserpswd = $("#ffuserpswd");
        var fcheckCode = $("#fcheckCode");

        $.ajax({
            type : "POST",
            data : {
                "loginacct" : floginacct.val(),
                "userpswd" : fuserpswd.val(),
                "fuserpswd" : ffuserpswd.val(),
                "checkCode" : fcheckCode.val()
            },
            url : "${APP_PATH}/doRestPassword.do",
            beforeSend : function () {
                loadingIndex = layer.msg('密码重置中', {icon: 16});
                return true;
            },
            success : function (result) {
                if (result.success){
                    layer.close(loadingIndex);
                    window.location.href = "${APP_PATH}/restTime.htm";
                }else {
                    layer.msg(result.message);
                    refreshCode(); // 刷新验证码
                }
            },
            error : function () {
                layer.msg("密码重置失败");
                refreshCode(); // 刷新验证码
            }
        });
    }
</script>

</body>
</html>
