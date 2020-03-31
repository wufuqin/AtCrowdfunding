<%--
  修改项目信息页面
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
            <div><a class="navbar-brand" style="font-size:32px;" href="${APP_PATH}/role/index.htm">众筹平台 - 角色维护</a></div>
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
                <li class="active">修改项目信息</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="updateRoleForm">

                        <div class="form-group">
                            <label for="name">项目名称</label>
                            <input type="text" class="form-control" id="name" value="${project.name}" placeholder="请输入项目名称">
                        </div>
                        <div class="form-group">
                            <label for="remark">项目简介</label>
                            <input type="text" class="form-control" id="remark" value="${project.remark}" placeholder="请输入项目简介">
                        </div>
                        <div class="form-group">
                            <label for="money">筹资金额</label>
                            <input type="text" class="form-control" id="money" value="${project.money}" placeholder="请输入筹资金额">
                        </div>
                        <div class="form-group">
                            <label for="day">筹资天数</label>
                            <input type="text" class="form-control" id="day" value="${project.day}" placeholder="请输入筹资天数">
                        </div>
                        <button onclick="updateProject()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 修改</button>
                        <button onclick="resetProjectForm()" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
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
        showMenu();
    });
</script>

<%--修改用户数据--%>
<script>
    function updateProject() {
        //获取修改的项目的信息
        var name = $("#name");
        var remark = $("#remark");
        var money = $("#money");
        var day = $("#day");

        $.ajax({
            type : "POST",
            data : {
                "name" : name.val(),
                "remark" : remark.val(),
                "money" : money.val(),
                "day" : day.val(),
                "id" : "${project.id}"
            },
            url : "${APP_PATH}/project/doUpdate.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据修改中...', {icon: 16});
                //对表单数据进行校验
                return true;
            },

            success : function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("数据修改成功");
                    window.location.href="${APP_PATH}/project/index.htm";
                }else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("数据修改失败");
            }
        });
    }
</script>

<%--重置表单数据--%>
<script>
    function resetProjectForm() {
        //jQuery没有reset函数，使用需要性转换为dom对象使用 [0]
        $("#updateRoleForm")[0].reset();
    }
</script>

</body>
</html>
