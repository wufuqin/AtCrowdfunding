<%--
   权限管理
      用户维护分配权限模块
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div><a class="navbar-brand" style="font-size:32px;" href="${APP_PATH}/user/index.htm">众筹平台 - 用户维护</a></div>
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
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label for="leftRoleList">未分配角色列表</label><br>
                            <select id="leftRoleList" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                               <c:forEach items="${leftRoleList}" var="role">
                                   <option value="${role.id}">${role.name}</option>
                               </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="leftToRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="rightToLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label for="rightRoleList">已分配角色列表</label><br>
                            <select id="rightRoleList" class="form-control" multiple size="10" style="width:300px;overflow-y:auto;">
                                <c:forEach items="${rightRoleList}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
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

<%--入口函数--%>
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

<%--分配角色--%>
<script>
    $("#leftToRightBtn").click(function () {
        //获取被选中的数据
        var leftOption = $("#leftRoleList option:selected");

        var jsonObj = {
            userid : "${param.id}"
        };

        $.each(leftOption,function (i,n) {
            jsonObj["ids["+i+"]"] = this.value;
        });

        layer.confirm("确认分配权限？", {icon: 3, title: '提示'}, function (cindex) {
        $.ajax({
            type : "POST",
            data :jsonObj,
            url : "${APP_PATH}/user/doAddAssignRole.do",
            beforeSend : function () {
                index = layer.msg('权限分配中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(index);
                if (result.success){
                    //将左边选中的数据添加到左边并且删除
                    $("#rightRoleList").append(leftOption);
                } else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("分配权限失败");
            }
        });
        },function (cindex) {
            layer.close(cindex);
        });
    });
</script>

<%--取消角色--%>
<script>
    $("#rightToLeftBtn").click(function () {
        //获取被选中的数据
        var  rightOption= $("#rightRoleList option:selected");

        var jsonObj = {
            userid : "${param.id}"
        };

        $.each(rightOption,function (i,n) {
            jsonObj["ids["+i+"]"] = this.value;
        });

        layer.confirm("确认取消权限？", {icon: 3, title: '提示'}, function (cindex) {
        $.ajax({
            type : "POST",
            data :jsonObj,
            url : "${APP_PATH}/user/doDeleteAssignRole.do",
            beforeSend : function () {
                index = layer.msg('权限取消中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(index);
                if (result.success){
                    //将右边选中的数据添加到左边并且删除
                    $("#leftRoleList").append(rightOption);
                } else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("取消权限失败");
            }
        });
        },function (cindex) {
            layer.close(cindex);
        });
    });
</script>

</body>
</html>



























