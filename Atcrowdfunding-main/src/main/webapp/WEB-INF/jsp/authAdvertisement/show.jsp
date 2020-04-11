<%--
 审核广告页面
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

    <link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH }/css/main.css">
    <link rel="stylesheet" href="${APP_PATH }/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 实名认证审核</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <%@include file="/WEB-INF/jsp/common/top.jsp"%>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%@include file="/WEB-INF/jsp/common/menu.jsp" %>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="${APP_PATH}/main.htm">首页</a></li>
                <li><a href="${APP_PATH}/authAdvertisement/index.htm">数据列表</a></li>
                <li class="active">广告信息</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <div class="panel-body">
                        <form>
                            <div class="form-group">
                                <label >广告名称: </label>
                                ${advertisement.name }
                            </div>
                            <div class="form-group">
                                <label>发布区域: </label>
                                <c:if test="${advertisement.url eq 'top'}">
                                    轮播图广告
                                </c:if>
                                <c:if test="${advertisement.url eq 'body'}">
                                    一般广告
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label>广告状态: </label>
                                未审核
                            </div>

                            <hr>
                            <div class="form-group">
                                <img src="http://47.95.223.197/test/pic/${advertisement.iconpath}" style="width: 300px; height: 200px">
                            </div>

                            <button onclick="passAdvertisement()" type="button" class="btn btn-success"> 通过</button>
                            <button onclick="refuseAdvertisement()" type="button" class="btn btn-danger"> 拒绝</button>
                            <button type="button" onclick="window.location.href='${APP_PATH}/authAdvertisement/index.htm'" class="btn btn-info">返回</button>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH }/script/docs.min.js"></script>
<script src="${APP_PATH }/jquery/layer/layer.js"></script>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

</script>

<%--通过申请--%>
<script>
    function passAdvertisement() {
        $.ajax({
            type : "POST",
            data : {
                "id" : ${advertisement.id }
            },
            url : "${APP_PATH}/authAdvertisement/passAdvertisement.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据加载中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    window.location.href = "${APP_PATH}/authAdvertisement/index.htm";
                } else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("操作失败");
            }
        });
    }
</script>

<%--拒绝申请--%>
<script>
    function refuseAdvertisement() {
        $.ajax({
            type : "POST",
            data : {
                "id" : ${advertisement.id }
            },
            url : "${APP_PATH}/authAdvertisement/refuseAdvertisement.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据加载中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    window.location.href = "${APP_PATH}/authAdvertisement/index.htm";
                } else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("操作失败");
            }
        });
    }
</script>

</body>
</html>

























