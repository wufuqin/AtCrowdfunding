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
                <a href="javascript:refreshCode();">
                    <img src="${APP_PATH}/CheckCodeServlet" title="看不清" id="vcode"/>
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
                <a href="${APP_PATH}/forget.htm">忘记密码</a>
            </label>

            <label style="float:right">
                <a href="${APP_PATH}/reg.htm">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="doLogin()" > 登录</a>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script>
    //异步请求方式
    function doLogin() {
        //获取用户输入的登录信息
        var loginacct = $("#floginacct");
        var userpswd = $("#fuserpswd");
        var checkCode = $("#fcheckCode");
        var type = $("#ftype").val();

        //对表单用户名数据进行校验
        if ($.trim(loginacct.val()) == "") {
            //alert("用户名不能为空！");
            layer.msg("用户名不能为空", {time:2000, icon:null, shift:6});
            loginacct.val("");   //输入框重新设置为空
            loginacct.focus();   //重新获取焦点
            return false;
        }
        //对表单密码数据进行校验
        if ($.trim(userpswd.val()) == "") {
            //alert("密码不能为空！");
            layer.msg("密码不能为空", {time:2000, icon:null, shift:6});
            userpswd.val("");   //输入框重新设置为空
            userpswd.focus();   //重新获取焦点
            return false;
        }
        //对表单验证码数据进行校验
        if ($.trim(checkCode.val()) == "") {
            //alert("验证码不能为空！");
            layer.msg("验证码不能为空", {time:2000, icon:null, shift:6});
            checkCode.val("");   //输入框重新设置为空
            checkCode.focus();   //重新获取焦点
            return false;
        }

        //使用ajax封装做异步请求
        $.ajax({
            type : "POST",
            data : {
                "loginacct" : loginacct.val(),
                "userpswd" : userpswd.val(),
                "checkCode" : checkCode.val(),
                "type" : type
            },
            url : "${APP_PATH}/doLogin.do",
            beforeSend : function () {
                //给出登录是提示
                loadingIndex = layer.msg('登录中', {icon: 16});
                //一般做表单数据校验
                return true;
            },
            success : function (result) {
                if (result.success){
                    //alert("登录成功");
                    layer.close(loadingIndex);
                    //layer.msg("登录成功", {time:3000, icon:6, shift:6});
                    //跳转到后台主页面
                    window.location.href = "${APP_PATH}/main.htm";
                }else {
                    //alert("登录失败");
                    //alert(result.message);
                    layer.msg(result.message, {time:2000, icon:5, shift:6});
                    refreshCode(); //自动切换验证码
                }
            },
            error : function () {
                layer.msg("登录失败", {time:2000, icon:5, shift:6});
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




















