<%--
  申请实名认证，选择账户类型
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="GB18030">
<head>
    <meta charset="GB18030">
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
        .seltype {
            position: absolute;
            margin-top: 70px;
            margin-left: 10px;
            color: green;
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
        <h1>实名认证 - 账户类型选择</h1>
    </div>
    <div style="padding-top:10px;">
        <div class="row">
            <div class="col-xs-6 col-md-3">

                <h2>商业公司</h2>
                <a href="#" class="thumbnail">

                    <img alt="100%x180" src="${APP_PATH}/img/services-box1.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
            <div class="col-xs-6 col-md-3">
                <h2>个体工商户</h2>
                <a href="#" class="thumbnail">
                    <img alt="100%x180" src="${APP_PATH}/img/services-box2.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
            <div class="col-xs-6 col-md-3">
                <h2>个人经营</h2>
                <a href="#" class="thumbnail">
                    <img alt="100%x180" src="${APP_PATH}/img/services-box3.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
            <div class="col-xs-6 col-md-3">
                <h2>政府及非营利组织</h2>
                <a href="#" class="thumbnail">
                    <img alt="100%x180" src="${APP_PATH}/img/services-box4.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
        </div>
        <button type="button" class="btn btn-danger btn-lg btn-block" onclick="window.location.href='${APP_PATH}/member/apply.html'">认证申请</button>
    </div>

</div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/script/docs.min.js"></script>
    <script>
        $(".thumbnail").click(function(){
            $('.seltype').remove();
            $(this).prepend('<div class="glyphicon glyphicon-ok seltype"></div>');
        });
    </script>
</body>
</html>