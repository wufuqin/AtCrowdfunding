<%--
  后台更新会员页面
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
                <li><a href="${APP_PATH}/member/memberIndex.htm">数据列表</a></li>
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="updateMemberForm">
                        <div class="form-group" style="width: 300px">
                            <label for="loginacct">登陆账号</label>
                            <input  type="text" class="form-control" id="loginacct" name="loginacct" value="${member.loginacct}" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="userpswd">登陆密码</label>
                            <input type="password" class="form-control" id="userpswd" name="userpswd" value="${member.userpswd}" placeholder="请输入登陆账号">
                        </div>

                        <div class="form-group" style="width: 300px">
                            <label for="username">用户名称</label>
                            <input type="text" class="form-control" id="username" name="username" value="${member.username}" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="email">邮箱地址</label>
                            <input type="email" class="form-control" id="email" name="email" value="${member.email}" placeholder="请输入邮箱地址">
                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="authstatus">实名认证状态</label>
                            <c:choose>
                                <c:when test="${member.authstatus eq '0'}">
                                    <input disabled type="text" class="form-control" id="authstatus" name="authstatus" value="未实名认证">
                                </c:when>
                                <c:when test="${member.authstatus eq '1'}">
                                    <input disabled type="text" class="form-control" id="authstatus" name="authstatus" value="实名认证申请中">
                                </c:when>
                                <c:when test="${member.authstatus eq '2'}">
                                    <input disabled type="text" class="form-control" id="authstatus" name="authstatus" value="已实名认证">
                                </c:when>
                            </c:choose>

                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="usertype">用户类型</label>
                            <c:choose>
                                <c:when test="${member.usertype eq '0'}">
                                    <input disabled type="text" class="form-control" id="usertype" name="usertype" value="个人">
                                </c:when>
                                <c:when test="${member.usertype eq '1'}">
                                    <input disabled type="text" class="form-control" id="usertype" name="usertype" value="企业">
                                </c:when>
                            </c:choose>

                        </div>

                        <div class="form-group" style="width: 300px">
                            <label for="realname">真实姓名</label>
                            <input  type="text" class="form-control" id="realname" name="realname" value="${member.realname}">
                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="cardnum">身份证号</label>
                            <input  type="text" class="form-control" id="cardnum" name="cardnum" value="${member.cardnum}">
                        </div>
                        <div class="form-group" style="width: 300px">
                            <label for="tel">手机号</label>
                            <input  type="text" class="form-control" id="tel" name="tel" value="${member.tel}">
                        </div>
                        <button type="submit" class="btn btn-success"> 修改</button>
                        <button type="reset" class="btn btn-info"> 重置</button>
                        <a href="${APP_PATH}/member/memberIndex.htm" type="button" class="btn btn-info"> 返回</a>
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
<script src="${APP_PATH}/jquery/jQuery.validate/jquery.validate.min.js"></script>
<script src="${APP_PATH}/script/checkUpdateMember.js"></script>
<script src="${APP_PATH}/script/card.js"></script>
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

<%--修改个人信息--%>
<script>
    function updateMember() {
        //获取添加的用户的信息
        var loginacct = $("#loginacct").val();
        var userpswd = $("#userpswd").val();
        var username = $("#username").val();
        var email = $("#email").val();

        if ($("#authstatus").val() == "未实名认证") {
            var authstatus = 0;
        }else if($("#authstatus").val() == "实名认证申请中") {
            var authstatus = 1;
        }else if($("#authstatus").val() == "已实名认证") {
            var authstatus = 2;
        }

        if ($("#usertype").val() == "个人") {
            var usertype = 0;
        }else if($("#usertype").val() == "企业") {
            var usertype = 1;
        }
        var realname = $("#realname").val();
        var cardnum = $("#cardnum").val();
        var tel = $("#tel").val();

        $.ajax({
            type : "POST",
            data : {
                "id" : ${member.id},
                "loginacct" : loginacct,
                "userpswd" : userpswd,
                "username" : username,
                "email" : email,
                "authstatus" : authstatus,
                "usertype" : usertype,
                "realname" : realname,
                "cardnum" : cardnum,
                "tel" : tel
            },
            url : "${APP_PATH}/member/doUpdate.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据修改中...', {icon: 16});
                //对表单数据进行校验
                return true;
            },

            success : function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("数据修改成功");
                    window.location.href="${APP_PATH}/member/memberIndex.htm";
                }else {
                    layer.msg("数据修改失败");
                }
            },
            error : function () {
                layer.msg("数据修改失败error");
            }
        });
    }
</script>

</body>
</html>
