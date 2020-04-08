<%--
  填写实名认证的基本信息
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
        <li role="presentation" class="active"><a href="#"><span class="badge">1</span> 基本信息</a></li>
        <li role="presentation"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <%--表单数据--%>
    <form role="form" id="updateMemberBasicInfoForm" style="margin-top:20px;">
        <div class="form-group" style="width: 480px">
            <label for="realname">真实名称</label>
            <input type="text" class="form-control" id="realname" name="realname" value="${memberInfo.realname}" placeholder="请输入真实名称">
        </div>
        <div class="form-group" style="width: 480px">
            <label for="cardnum">身份证号码</label>
            <input type="text" class="form-control" id="cardnum" name="cardnum" value="${memberInfo.cardnum}" placeholder="请输入身份证号码">
        </div>
        <div class="form-group" style="width: 480px">
            <label for="tel">电话号码</label>
            <input type="text" class="form-control" id="tel" name="tel" value="${memberInfo.tel}" placeholder="请输入电话号码">
        </div>
        <div class="form-group" style="width: 480px">
            <label for="introduction">简介</label>
            <input type="text" class="form-control" id="introduction" name="introduction" value="${memberInfo.introduction}" placeholder="(可不填)请输入账户简介">
        </div>
        <button type="button" onclick="window.location.href='${APP_PATH}/member/acctType.htm'" class="btn btn-info">上一步</button>
        <button type="submit"  class="btn btn-info">下一步</button>
    </form>
    <hr>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkUpdateMemberBasicInfo.js"></script>
<script src="${APP_PATH}/script/card.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    });
</script>

<script>
    function updateMemberBasicInfo(){
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/member/updateBasicInfo.do",
            data : {
                realname : $("#realname").val(),
                cardnum  : $("#cardnum").val(),
                tel      : $("#tel").val(),
                introduction : $("#introduction").val()
            },
            beforeSend : function () {
                loadingIndex = layer.msg('基本信息更新中...', {icon: 16});
                return true;
            },
            success : function(result) {
                if ( result.success ) {
                    window.location.href = "${APP_PATH}/member/apply.htm";
                } else {
                    layer.msg("基本信息更新失败");
                }
            }
        });
    }
</script>
</body>
</html>
