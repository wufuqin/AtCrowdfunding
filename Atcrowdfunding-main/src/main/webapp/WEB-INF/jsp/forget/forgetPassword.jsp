<%--
    忘记密码
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
        <%--服务器编号--%>;
        <jsp:include page="/WEB-INF/jsp/common/topServer.jsp"/>
    </div>
</nav>
<div class="container">
    <form id="restPasswordEmailForm" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 发送重置密码邮件</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
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
                <button type="submit" class="btn btn-info form-control" style="width: 136px">确认</button>
            </div>
            <a type="button" class="btn btn-info form-control" style="width: 150px" href="${APP_PATH}/login.htm"> 返回</a>
        </div>

    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkRestPasswordEmail.js"></script>

<%--切换验证码--%>
<script>
    function refreshCode(){
        var vcode = document.getElementById("vcode");  //1.获取验证码图片对象
        vcode.src = "${pageContext.request.contextPath}/CheckCodeServlet?time="+new Date().getTime();   //2.设置其src属性，加时间戳
    }
</script>

<%--发送邮件--%>
<script>
    function restPassword() {
        //获取用户输入的邮箱和验证码
        var email = $("#email");
        var checkCode = $("#checkCode");

        $.ajax({
            type : "POST",
            data : {
                "email" : email.val(),
                "checkCode" : checkCode.val()
            },
            url : "${APP_PATH}/restPassword.do",
            beforeSend : function () {
                loadingIndex = layer.msg('验证码发送中', {icon: 16});
                return true;
            },
            success : function (result) {
                if (result.success){
                    layer.close(loadingIndex);
                    window.location.href = "${APP_PATH}/time.htm";
                }else {
                    layer.msg(result.message);
                    refreshCode(); // 刷新验证码
                }
            },
            error : function () {
                layer.msg("邮件发送失败");
                refreshCode(); // 刷新验证码
            }
        });
    }
</script>

</body>
</html>

























