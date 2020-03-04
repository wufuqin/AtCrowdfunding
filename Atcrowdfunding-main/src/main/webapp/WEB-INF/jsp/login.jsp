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
    <style>

    </style>
</head>



<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">众筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form id="loginForm" action="${APP_PATH }/doLogin.do" method="POST" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="floginacct" name="loginacct" value="superadmin" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="fuserpswd" name="userpswd" value="123456" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>

        <div class="form-group has-success has-feedback">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="fcheckCode" name="checkCode" placeholder="请输入验证码">
                </div>
                <%--<div id="vcode" class="col-md-6"><img src="${pageContext.request.contextPath}/CheckCodeServlet" alt="点击刷新" onclick="refreshCode()"/></div>--%>
                <a href="javascript:refreshCode();">
                    <img src="${pageContext.request.contextPath}/CheckCodeServlet" title="看不清" id="vcode"/>
                </a>

            </div>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" id="ftype" name="type" >
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
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.htm">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script>
    /*静态测试数据*/
    /*function dologin() {
        var type = $(":selected").val();
        if ( type == "user" ) {
            window.location.href = "main.html";
        } else {
            window.location.href = "index.html";
        }
    }*/

    //同步提交方式
   /* function dologin() {
        $("#loginForm").submit();
    }*/

    //异步请求方式
    function dologin() {
        //获取用户输入的登录信息
        var loginacct = $("#floginacct").val();
        var userpswd = $("#fuserpswd").val();
        var checkCode = $("#fcheckCode").val();
        var type = $("#ftype").val();


        //使用ajax封装做异步请求
        $.ajax({
            type : "POST",
            data : {
                "loginacct" : loginacct,
                "userpswd" : userpswd,
                "checkCode" : checkCode,
                "type" : type
            },
            url : "${APP_PATH}/doLogin.do",
            beforeSend : function () {
                //一般做表单数据校验
                return true;
            },
            success : function (result) {
                if (result.success){
                    alert("登录成功");
                }else {
                    alert("登录失败");
                }
            },
            error : function () {
                alert("error");
            }
        });
    }


</script>

<%-- 切换验证码 --%>
<script>
    function refreshCode(){
        //1.获取验证码图片对象
        var vcode = document.getElementById("vcode");
        //2.设置其src属性，加时间戳
        vcode.src = "${pageContext.request.contextPath}/CheckCodeServlet?time="+new Date().getTime();

    }
</script>

</body>
</html>
