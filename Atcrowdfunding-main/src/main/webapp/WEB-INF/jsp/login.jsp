<%--
    登录页面
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
    <form id="loginForm" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginacct" name="loginacct" value="18377548732" placeholder="请输入登录账号" autofocus>

        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userpswd" name="userpswd" value="abc123`" placeholder="请输入登录密码" style="margin-top:10px;">
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
        <div class="form-group has-success has-feedback">
            <select class="form-control" id="type" name="type" >
                <option value="member">会员</option>
                <option value="user" selected>管理</option>
            </select>
        </div>

        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                <a href="${APP_PATH}/forget.htm">忘记密码</a>
            </label>

            <label style="float:right">
                <a href="${APP_PATH}/reg.htm">我要注册</a>
            </label>
        </div>
        <div class="row">
            <div class="col-md-6">
                <button type="submit" class="btn btn-info form-control" style="width: 136px">登录</button>
            </div>
            <a type="button" class="btn btn-info form-control" style="width: 150px" href="${APP_PATH}/index.htm"> 返回</a>
        </div>
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
        //获取用户输入的登录信息
        var loginacct = $("#loginacct");
        var userpswd = $("#userpswd");
        var checkCode = $("#checkCode");
        var type = $("#type");

        $.ajax({
            type : "POST",
            data : {
                "loginacct" : loginacct.val(),
                "userpswd" : userpswd.val(),
                "checkCode" : checkCode.val(),
                "type" : type.val()
            },
            url : "${APP_PATH}/doLogin.do",
            beforeSend : function () {
                loadingIndex = layer.msg('登录中', {icon: 16});
                return true;
            },
            success : function (result) {
                if (result.success){
                    layer.close(loadingIndex);
                    if (type.val() == "user"){
                        window.location.href = "${APP_PATH}/main.htm";   //跳转到后台主页面
                    }else if (type.val() == "member") {
                        window.location.href = "${APP_PATH}/member.htm";   //跳转到前台主页面
                    }else {
                        layer.msg("选择的登录类型不合法");
                    }
                }else {
                    layer.msg(result.message);
                    refreshCode(); //自动切换验证码
                }
            },
            error : function () {
                layer.msg("登录失败");
            }
        });
    }
</script>

<%-- 切换验证码 --%>
<script>
    function refreshCode(){
        var vcode = document.getElementById("vcode");  //1.获取验证码图片对象
        vcode.src = "${pageContext.request.contextPath}/CheckCodeServlet?time="+new Date().getTime();   //2.设置其src属性，加时间戳
    }
</script>

</body>
</html>




















