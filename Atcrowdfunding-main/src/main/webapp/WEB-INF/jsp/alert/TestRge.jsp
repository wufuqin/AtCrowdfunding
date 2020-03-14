<%--
    注册页面
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
    <style>

    </style>
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

    <%-- 注册表单 --%>
    <form class="form-signin" role="form" id="registerForm" action="member">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="fphone" placeholder="请输入手机号：11位" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="fpassword" placeholder="请输入密码：6-18位" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="femail" placeholder="请输入邮箱：***@qq.com" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="fcode" placeholder="请输入验证码">
                </div>
                <%--<a href="javascript:refreshCode();">
                    <img src="${pageContext.request.contextPath}/CheckCodeServlet" title="看不清" id="vcode"/>
                </a>--%>
                <button id="getCode" style="width: 150px" type="button" class="form-control btn btn-lg ">获取验证码</button>
            </div>

        </div>

        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option>企业</option>
                <option>个人</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <a href="${APP_PATH}/unfinished.htm">第三方登录</a>
            </label>
            <label style="float:right">
                <a href="${APP_PATH}/login.htm">我有账号</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" href="${APP_PATH}/member.htm" > 注册</a>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>

<%-- 切换图片验证码 --%>
<script>
    function refreshCode(){
        //1.获取验证码图片对象
        var vcode = document.getElementById("vcode");
        //2.设置其src属性，加时间戳
        vcode.src = "${pageContext.request.contextPath}/CheckCodeServlet?time="+new Date().getTime();
    }
</script>

<%--获取短信验证码--%>
<script>

    var code = document.getElementById("getCode");
    var flag = 3;
    code.onclick = function () {

        $("#getCode").prop("class","btn btn-lg btn-success");
        if (flag < 3) {
            return;
        }

        /*var xhr = new XMLHttpRequest();
        xhr.open("get", "CheckCode?phone=" +document.getElementById("fphone").value, true);
        //监听请求状态
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && status == 200) {
                alert(xhr.responseText);
            }
        };
        xhr.send(null);*/

        timer();

    };

    function timer() {
        flag--;
        code.innerHTML = flag + "秒后重新获取";
        if (flag == 0) {
            code.innerHTML = "重新获取验证码";
            $("#getCode").removeClass();
            $("#getCode").prop("class","btn btn-lg form-control");
            flag = 3;
        } else {
            setTimeout("timer()", 1000);
        }
    }
</script>

</body>
</html>

















