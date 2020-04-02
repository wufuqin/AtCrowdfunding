<%--
  填写验证码
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/theme.css">
    <style>
        #footer {
            padding: 15px 0;
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="navbar-wrapper">
    <div class="container">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <%--包含头部页面--%>
            <jsp:include page="/WEB-INF/jsp/common/memberTop.jsp"/>
        </nav>

    </div>
</div>

<div class="container theme-showcase" role="main">
    <div class="page-header">
        <h1>实名认证 - 申请</h1>
    </div>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" ><a href="#"><span class="badge">1</span> 基本信息</a></li>
        <li role="presentation" ><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation" ><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation" class="active"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <form role="form" id="checkAuthCoedForm" style="margin-top:20px;">
        <div class="form-group" style="width: 490px">
            <label for="authcode">验证码</label>
            <input type="text" class="form-control" id="authcode" name="authcode" placeholder="请输入你邮箱中接收到的验证码">
        </div>
        <button type="button" onclick="window.location.href='${APP_PATH}/member/checkEmail.htm'" class="btn btn-info">上一步</button>
        <button type="submit" class="btn btn-success">申请完成</button>
    </form>
    <hr>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkAuthCoed.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    });
</script>

<%--申请完成--%>
<script>
   function checkAuthCoed(){
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/member/finishApply.do",
            data : {
                authcode : $("#authcode").val()
            },
            beforeSend : function () {
                loadingIndex = layer.msg('实名认证申请中...', {icon: 16});
                return true;
            },
            success : function(result) {
                if ( result.success ) {
                    window.location.href = "${APP_PATH}/member.htm";
                } else {
                    layer.msg("实名认证申请失败");
                }
            }
        });
   }
</script>
</body>
</html>
