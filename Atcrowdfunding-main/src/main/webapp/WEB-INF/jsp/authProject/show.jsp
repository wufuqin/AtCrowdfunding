<%--
  查看并且审核项目
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
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">项目信息</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <div class="panel-body">
                        <form>
                            <div class="form-group">
                                <label >项目名称: </label>
                                ${project.name }
                            </div>
                            <div class="form-group">
                                <label>目标金额: </label>
                                ${project.money }
                            </div>
                            <div class="form-group">
                                <label>总筹天数: </label>
                                ${project.day }
                            </div>
                            <div class="form-group">
                                <label>创建时间: </label>
                                ${project.createdate }
                            </div>
                            <div class="form-group">
                                <label>状态: </label>
                                未审核
                            </div>

                            <hr>
                            <div class="form-group">
                                <img src="${APP_PATH }/picture/advertisement/${Project.filename}">
                            </div>
                            <%--上传图片--%>
                            <script>
                                function addAdvertisement() {
                                    var options = {
                                        url:"${APP_PATH}/advertisement/doAdd.do",
                                        beforeSubmit : function(){
                                            loadingIndex = layer.msg('数据正在保存中', {icon: 6});
                                            return true ; //必须返回true,否则,请求终止.
                                        },
                                        success : function(result){
                                            layer.close(loadingIndex);
                                            if(result.success){
                                                layer.msg("广告数据保存成功", {time:1000, icon:6});
                                                window.location.href="${APP_PATH}/advertisement/index.htm";
                                            }else{
                                                layer.msg("广告数据保存失败", {time:1000, icon:5, shift:6});
                                            }
                                        }
                                    };

                                    $("#addAdvertisementForm").ajaxSubmit(options); //异步提交
                                    return ;
                                }
                            </script>
                            <button onclick="passProject()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 通过</button>
                            <button onclick="refuseProject()" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 拒绝</button>
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
    function passProject() {
        $.ajax({
            type : "POST",
            data : {
                "id" : ${project.id }
            },
            url : "${APP_PATH}/authProject/passProject.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据加载中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    window.location.href = "${APP_PATH}/authProject/index.htm";
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
    function refuseProject() {
        $.ajax({
            type : "POST",
            data : {
                "id" : ${project.id }
            },
            url : "${APP_PATH}/authProject/refuseProject.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据加载中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    window.location.href = "${APP_PATH}/authProject/index.htm";
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