<%--
    短信注册测试页面
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

    <%-- 注册表单 --%>
    <form class="form-signin" role="form" id="registerForm" action="member">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="tel" name="tel" placeholder="请输入手机号：11位" autofocus>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" autofocus>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userpswd" name="userpswd" placeholder="请输入密码：6-18位" style="margin-top:10px;">
        </div>
        <div class="form-group has-success has-feedback">
            <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱：***@qq.com" style="margin-top:10px;">
        </div>
        <div class="form-group has-success has-feedback">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="code" name="code" placeholder="请输入验证码">
                </div>
                <button id="getCode" style="width: 150px" type="button" class="form-control btn btn-lg ">获取验证码</button>
            </div>

        </div>

        <div class="form-group has-success has-feedback">
            <select id="fusertype" class="form-control" >
                <option value="1">企业</option>
                <option value="0">个人</option>
            </select>
        </div>
        <div class="checkbox">
            <label style="float:right">
                <a href="${APP_PATH}/login.htm">我有账号</a>
            </label>
        </div>
        <br>
        <div class="row">
            <div class="col-md-6">
                <a type="button" class="btn btn-info form-control" style="width: 136px" onclick="doRge()">注册</a>
            </div>
            <a type="button" class="btn btn-info form-control" style="width: 150px" href="${APP_PATH}/index.htm"> 返回</a>
        </div>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkReg.js"></script>

<%--注册--%>
<script>
    function doRge() {
        //获取用户输入的注册信息
        var tel = $("#tel");
        var username = $("#username");
        var userpswd = $("#userpswd");
        var email = $("#email");
        var code = $("#code");
        var usertype = $("#fusertype");

        $.ajax({
            type : "POST",
            data : {
                "tel" : tel.val(),
                "username" : username.val(),
                "userpswd" : userpswd.val(),
                "email" : email.val(),
                "usertype" : usertype.val(),
                "checkCode" : code.val()
            },
            url : "${APP_PATH}/doRge.do",
            beforeSend : function () {
                loadingIndex = layer.msg('注册中', {icon: 16});
                return true;
            },
            success : function (result) {
                if (result.success){
                    layer.close(loadingIndex);
                    window.location.href = "${APP_PATH}/regTime.htm";
                }else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("注册失败");
            }
        });
    }
</script>

<%--获取短信验证码--%>
<script>
    var code = document.getElementById("getCode");
    var flag = 60;
    code.onclick = function () {

        $("#getCode").prop("class","btn btn-lg btn-success");
        if (flag < 60) {
            return;
        }

        var xhr = new XMLHttpRequest();
        xhr.open("get", "${APP_PATH}/CheckCode?tel=" +document.getElementById("tel").value, true);
        //监听请求状态
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && status == 200) {
                alert(xhr.responseText);
            }
        };
        xhr.send(null);
        timer();

    };

    function timer() {
        flag--;
        code.innerHTML = flag + "秒后重新获取";
        if (flag == 0) {
            code.innerHTML = "重新获取验证码";
            $("#getCode").removeClass();
            $("#getCode").prop("class","btn btn-lg form-control");
            flag = 60;
        } else {
            setTimeout("timer()", 1000);
        }
    }
</script>

</body>
</html>

















