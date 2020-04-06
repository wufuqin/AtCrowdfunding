<%--
  添加项目页面
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
                <li><a href="${APP_PATH}/project/index.htm">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body" >
                    <form id="addProjectForm" method="post" enctype="multipart/form-data">
                        <div class="form-group" style="width: 300px">
                            <label for="name">项目名称</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入项目名称">
                        </div>

                        <div class="form-group" style="width: 300px">
                            <label for="projectType">项目类别</label>
                            <select class="form-control" id="projectType" name="projectType" >
                                <option selected >-- 请选择项目类别 --</option>
                                <option value="technology">科技类</option>
                                <option value="design">设计类</option>
                                <option value="agriculture">农业类</option>
                                <option value="others">其他</option>
                            </select>
                        </div>

                        <div class="form-group" style="width: 300px">
                            <label for="remark">项目简介</label><br>
                            <input type="text" class="form-control" id="remark" name="remark" placeholder="请输入项目简介">

                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="money">筹资金额</label>
                            <input type="number" class="form-control" id="money" name="money" placeholder="请输入筹资金额">
                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="day">筹资天数</label>
                            <input type="number" class="form-control" id="day" name="day" placeholder="请输入筹资天数">
                        </div>

                        <div class="form-group" style="width: 300px">
                            <label for="projectPicture">项目图片图片</label>
                            <input type="file" class="form-control" id="projectPicture" name="projectPicture" placeholder="请输入项目图片">
                        </div>

                        <%--<div class="form-group">
                            <label for="membername">发起人姓名</label>
                            <input type="text" class="form-control" id="membername" placeholder="请输入发起人ID">
                        </div>--%>

                        <button type="submit" class="btn btn-success">新增</button>
                        <button type="reset" class="btn btn-info">重置</button>
                        <button type="button" onclick="window.location.href='${APP_PATH}/project/index.htm'" class="btn btn-info">返回</button>

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
<script src="${APP_PATH}/script/menu.js"></script>
<script src="${APP_PATH}/jquery/jquery-form/jquery-form.min.js"></script>
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkAddProject.js"></script>
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

<%--上传图片--%>
<script>
    function addProject() {
        var options = {
            url:"${APP_PATH}/project/doAdd.do",
            beforeSubmit : function(){
                loadingIndex = layer.msg('数据正在保存中', {icon: 16});
                return true ; //必须返回true,否则,请求终止.
            },
            success : function(result){
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("项目数据保存成功");
                    window.location.href="${APP_PATH}/project/index.htm";
                }else{
                    layer.msg("项目数据保存失败");
                }
            }
        };

        $("#addProjectForm").ajaxSubmit(options); //异步提交
        return ;
    }
</script>

</body>
</html>