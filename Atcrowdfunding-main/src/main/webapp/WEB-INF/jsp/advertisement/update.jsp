<%--
  修改广告
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
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
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
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <%-- 包含页面头部 --%>
                <jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%--包含左侧菜单页面--%>
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="${APP_PATH}/main.htm">首页</a></li>
                <li><a href="${APP_PATH}/advertisement/index.htm">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="updateAdvertisementForm" method="POST" enctype="multipart/form-data">
                        <div class="form-group" style="width: 350px">
                            <label for="name">广告名称</label>
                            <input type="text" class="form-control" id="name" name="name" value="${advertisement.name}" placeholder="请输入广告名称">
                        </div>

                        <div class="form-group" style="width: 350px">
                            <label for="url">选择广告区域</label>
                            <select class="form-control" id="url" name="url" >


                                <c:if test="${advertisement.url eq null}">
                                    <option selected >-- 请选择广告区域 --</option>
                                    <option value="top">轮播图广告</option>
                                    <option value="body">一般广告</option>
                                </c:if>

                                <c:if test="${advertisement.url eq 'top'}">
                                    <option >-- 请选择广告区域 --</option>
                                    <option selected value="top">轮播图广告</option>
                                    <option value="body">一般广告</option>
                                </c:if>

                                <c:if test="${advertisement.url eq 'body'}">
                                    <option >-- 请选择广告区域 --</option>
                                    <option value="top">轮播图广告</option>
                                    <option selected value="body">一般广告</option>
                                </c:if>

                            </select>

                        </div>
                       <%-- <div class="form-group" style="width: 350px">
                            <label for="advertPicture">广告图片</label>
                            <input type="file" class="form-control" id="advertPicture" value="${advertisement.iconpath}" placeholder="请输入广告图片">
                        </div>--%>
                        <div class="form-group" style="width: 350px">
                            <img src="http://47.95.223.197/test/pic/${advertisement.iconpath}" style="width: 350px; height: 200px">
                        </div>

                        <button type="submit" class="btn btn-success">修改</button>
                        <button type="reset" class="btn btn-info">重置</button>
                        <button type="button" onclick="window.location.href='${APP_PATH}/advertisement/index.htm'" class="btn btn-info">返回</button>

                    </form>
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
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH }/jquery/jquery-form/jquery-form.min.js"></script>
<script src="${APP_PATH}/script/menu.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkUpdateAdvertisement.js"></script>
<script type="text/javascript">
    /*入口函数*/
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
        showMenu();
    });
</script>

<%--修改广告--%>
<script>
    function updateAdvertisement() {
        //获取添加的用户的信息
        var name = $("#name");
        var url = $("#url");
        var advertPicture = $("#advertPicture");

        $.ajax({
            type : "POST",
            data : {
                "name" : name.val(),
                "url" : url.val(),
                "advertPicture" : advertPicture.val(),
                "id" : "${advertisement.id}"
            },
            url : "${APP_PATH}/advertisement/doUpdate.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据修改中...', {icon: 16});
                //对表单数据进行校验
                return true;
            },

            success : function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("数据修改成功...");
                    setTimeout(function () {{window.location.href="${APP_PATH}/advertisement/index.htm"}},1000);
                }else {
                    layer.msg("数据修改失败...");
                }
            },
            error : function () {
                layer.msg("数据修改失败...");
            }
        });
    }
</script>

<%--上传图片--%>
<%--<script>
    function updateAdvertisement() {
        var options = {
            url:"${APP_PATH}/advertisement/doUpdate.do",
            beforeSubmit : function(){
                loadingIndex = layer.msg('数据正在保存中', {icon: 16});
                return true ; //必须返回true,否则,请求终止.
            },
            success : function(result){
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("广告数据保存成功");
                    window.location.href="${APP_PATH}/advertisement/index.htm";
                }else{
                    layer.msg("广告数据保存失败");
                }
            }
        };

        $("#updateAdvertisementForm").ajaxSubmit(options); //异步提交
        return ;
    }
</script>--%>

</body>
</html>
