<%--
  上传资质图片
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
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
        <li role="presentation" class="active"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <form id="uploadCertForm" style="margin-top:20px;" method="post" enctype="multipart/form-data">
        <c:forEach items="${queryCertByAcctType }" var="cert" varStatus="status">
            <div class="form-group" style="width: 480px">
                <label>${cert.name }</label>
                <input type="hidden" name="certimgs[${status.index }].certid" value="${cert.id }">
                <input type="file" name="certimgs[${status.index }].fileImg" class="form-control" >
                <br>
                <img src="${APP_PATH }/img/pic.jpg" style="display:none">
            </div>
        </c:forEach>
        <button type="button" onclick="window.location.href='${APP_PATH}/member/basicInfo.htm'" class="btn btn-info">上一步</button>
        <button type="button" id="nextBtn" class="btn btn-info">下一步</button>
    </form>
    <hr>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery-form/jquery-form.min.js"></script>

<script>
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    });
</script>

<%--图片预览--%>
<script>
    $(":file").change(function(event){
        var files = event.target.files;
        var file;

        if (files && files.length > 0) {
            file = files[0];

            var URL = window.URL || window.webkitURL;
            // 本地图片路径
            var imgURL = URL.createObjectURL(file);

            var imgObj = $(this).next().next(); //获取同辈紧邻的下一个元素
            //console.log(imgObj);
            imgObj.attr("src", imgURL);
            imgObj.show();
        }
    });
</script>

<%--提交资质表单数据--%>
<script>
    $("#nextBtn").click(function(){
        var loadingIndex = -1 ;
        var options = {
            url:"${APP_PATH}/member/doUploadCert.do",
            beforeSubmit : function(){
                loadingIndex = layer.msg('数据正在保存中', {icon: 16});
                return true ; //必须返回true,否则,请求终止.
            },
            success : function(result){
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("数据保存成功");
                    window.location.href="${APP_PATH}/member/apply.htm";
                }else{
                    layer.msg("数据保存失败");
                }
            }
        };

        $("#uploadCertForm").ajaxSubmit(options); //异步提交
        return ;
    });
</script>



</body>
</html>
