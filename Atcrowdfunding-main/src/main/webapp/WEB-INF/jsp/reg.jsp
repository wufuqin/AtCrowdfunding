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
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/login.css">
    <style>

    </style>
    <%-- 校验注册表单 --%>
    <script>
        //校验登录名
        function checkLoginacct() {
            alert("校验登录名");
            return false;
        }

        //定义入口函数
        $(function () {
            //当表单提交时，调用所有的校验方法
            $("#registerForm").submit(function () {
                return checkLoginacct();
                //如果方法没有返回值，或者返回值为true则提交表单，false则不提交
            });
            //当组件失去焦点时，调用对应校验方法。

        });

    </script>
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

    <%-- 注册表单 --%>
    <form class="form-signin" role="form" id="registerForm" action="member">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="inputSuccess4" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="inputSuccess4" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="inputSuccess4" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <div class="row">
                <div class="col-md-6">
                    <input type="text" class="form-control" id="inputSuccess4" placeholder="请输入验证码">
                </div>
                <%--<div id="vcode" class="col-md-6"><img src="${pageContext.request.contextPath}/CheckCodeServlet" alt="点击刷新" onclick="refreshCode()"/></div>--%>
                <a href="javascript:refreshCode();">
                    <img src="${pageContext.request.contextPath}/CheckCodeServlet" title="看不清" id="vcode"/>
                </a>
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
                忘记密码
            </label>
            <label style="float:right">
                <a href="login.htm">我有账号</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" href="member.html" > 注册</a>
    </form>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>

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