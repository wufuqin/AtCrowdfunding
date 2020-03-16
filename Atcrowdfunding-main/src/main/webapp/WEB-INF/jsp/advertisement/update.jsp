<%--
  修改广告
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
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
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
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="updateAdvertisementForm" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="name">广告名称</label>
                            <input type="text" class="form-control" id="name" name="name" value="${advertisement.name}" placeholder="请输入广告名称">
                        </div>
                        <div class="form-group">
                            <label for="url">广告地址</label>
                            <input type="text" class="form-control" id="url" name="url" value="${advertisement.url}" placeholder="请输入广告地址">
                        </div>
                        <%--<div class="form-group">
                            <label for="advertPicture">广告图片</label>
                            <input type="file" class="form-control" id="advertPicture" name="advertPicture" value="目前回显文件失败" placeholder="请输入广告图片">
                        </div>--%>
                        <button  onclick="updateAdvertisement()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
                        <button  onclick="resetAdvertisementForm()" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
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
    });
</script>

<%--修改广告--%>
<script>
    function updateAdvertisement() {
        //获取添加的用户的信息
        var name = $("#name");
        var url = $("#url");


        $.ajax({
            type : "POST",
            data : {
                "name" : name.val(),
                "url" : url.val(),
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
                    layer.msg("数据修改成功...",{time:2000, icon:6, shift:6});
                    setTimeout(function () {{window.location.href="${APP_PATH}/advertisement/index.htm"}},2000);
                }else {
                    layer.msg("数据修改失败...",{time:2000, icon:5, shift:6});
                }
            },
            error : function () {
                layer.msg("数据修改失败...",{time:2000, icon:5, shift:6});
            }
        });
    }
</script>

<%--重置表单数据--%>
<script>
    function resetAdvertisementForm() {
        $("#updateAdvertisementForm")[0].reset();
    }
</script>

</body>
</html>
