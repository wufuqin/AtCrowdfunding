<%--
  后台更新会员页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                <li class="active">修改</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="updateMemberForm">
                        <div class="form-group">
                            <label for="floginacct">登陆账号</label>
                            <input  type="text" class="form-control" id="floginacct" value="${member.loginacct}" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="floginacct">登陆密码</label>
                            <input type="password" class="form-control" id="fuserpswd" value="${member.userpswd}" placeholder="请输入登陆账号">
                        </div>

                        <div class="form-group">
                            <label for="fusername">用户名称</label>
                            <input type="text" class="form-control" id="fusername" value="${member.username}" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="femail">邮箱地址</label>
                            <input type="email" class="form-control" id="femail" value="${member.email}" placeholder="请输入邮箱地址">
                        </div>
                        <div class="form-group">
                            <label for="femail">实名认证状态</label>
                            <input  type="email" class="form-control" id="fauthstatus" value="${member.authstatus}">
                        </div>
                        <div class="form-group">
                            <label for="femail">用户类型</label>
                            <input  type="email" class="form-control" id="fusertype" value="${member.usertype}">
                        </div>
                        <div class="form-group">
                            <label for="femail">真实姓名</label>
                            <input  type="email" class="form-control" id="frealname" value="${member.realname}">
                        </div>
                        <div class="form-group">
                            <label for="femail">身份证号</label>
                            <input  type="email" class="form-control" id="fcardnum" value="${member.cardnum}">
                        </div>
                        <div class="form-group">
                            <label for="femail">手机号</label>
                            <input  type="email" class="form-control" id="ftel" value="${member.tel}">
                        </div>
                        <button onclick="updateMember()" type="button" class="btn btn-success"> 修改</button>
                        <button onclick="resetMemberForm()" type="button" class="btn btn-danger"> 重置</button>
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
        var floginacct = $("#floginacct");
        var fuserpswd = $("#fuserpswd");
        var fusername = $("#fusername");
        var femail = $("#femail");
        var fauthstatus = $("#fauthstatus");
        var fusertype = $("#fusertype");
        var frealname = $("#frealname");
        var fcardnum = $("#fcardnum");
        var ftel = $("#ftel");

        $.ajax({
            type : "POST",
            data : {
                "id" : ${member.id},
                "loginacct" : floginacct.val(),
                "userpswd" : fuserpswd.val(),
                "username" : fusername.val(),
                "email" : femail.val(),
                "authstatus" : fauthstatus.val(),
                "usertype" : fusertype.val(),
                "realname" : frealname.val(),
                "cardnum" : fcardnum.val(),
                "tel" : ftel.val()
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
                    layer.msg("数据修改成功",{time:2000, icon:6, shift:6});
                    window.location.href="${APP_PATH}/member/memberIndex.htm";
                }else {
                    layer.msg("数据修改失败",{time:2000, icon:5, shift:6});
                }
            },
            error : function () {
                layer.msg("数据修改失败error",{time:2000, icon:5, shift:6});
            }
        });
    }
</script>

<%--重置表单数据--%>
<script>
    function resetMemberForm() {
        //jQuery没有reset函数，使用需要性转换为dom对象使用 [0]
        $("#updateMemberForm")[0].reset();
    }
</script>

</body>
</html>
