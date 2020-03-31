<%--
  会员个人设置页码
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
        #topcontrol {
            color: #fff;
            z-index: 99;
            width: 30px;
            height: 30px;
            font-size: 20px;
            background: #222;
            position: relative;
            right: 14px !important;
            bottom: 11px !important;
            border-radius: 3px !important;
        }

        #topcontrol:after {
            /*top: -2px;*/
            left: 8.5px;
            content: "\f106";
            position: absolute;
            text-align: center;
            font-family: FontAwesome;
        }

        #topcontrol:hover {
            color: #fff;
            background: #18ba9b;
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }

    </style>
</head>
<body>
<div class="navbar-wrapper">
    <div class="container">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <%--包含头部页面--%>
            <jsp:include page="/WEB-INF/jsp/common/memberTop.jsp"/>
        </nav>

    </div>
</div>
<div class="container">
    <div class="row clearfix">
        <div class="col-sm-3 col-md-3 column">
            <div class="row">
                <div class="col-md-12">
                    <div class="thumbnail" style="    border-radius: 0px;">
                        <img src="${APP_PATH}/img/services-box1.jpg" class="img-thumbnail" alt="">
                        <div class="caption" style="text-align:center;">
                            <h3>
                                ${sessionScope.member.username}
                            </h3>
                            <c:choose>
                                <c:when test="${member.authstatus eq '1'}">
                                    <span class="label label-warning" style="cursor:pointer;">实名认证申请中</span>
                                </c:when>
                                <c:when test="${member.authstatus eq '2'}">
                                    <span class="label label-success" style="cursor:pointer;">已实名认证</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="label label-danger" style="cursor:pointer;" onclick="window.location.href='${APP_PATH}/member/apply.htm'">未实名认证</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <div class="list-group">
                <div class="list-group-item active">
                    资产总览<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
                </div>
                <div class="list-group-item " style="cursor:pointer;" onclick="window.location.href='minecrowdfunding.html'">
                    我的众筹<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
                </div>
            </div>
        </div>
        <div class="col-sm-9 col-md-9 column">
            <div class="panel panel-default">
                <div class="panel-heading">个人信息<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>
                <div class="panel-body">
                    <form id="settingMemberForm">
                        <div class="form-group">
                            <label for="floginacct">登陆账号</label>
                            <input disabled type="text" class="form-control" id="floginacct" value="${sessionScope.member.loginacct}" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="floginacct">登陆密码</label>
                            <input type="password" class="form-control" id="fuserpswd" value="${sessionScope.member.userpswd}" placeholder="请输入登陆账号">
                        </div>

                        <div class="form-group">
                            <label for="fusername">用户名称</label>
                            <input type="text" class="form-control" id="fusername" value="${sessionScope.member.username}" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="femail">邮箱地址</label>
                            <input type="email" class="form-control" id="femail" value="${sessionScope.member.email}" placeholder="请输入邮箱地址">
                        </div>
                        <div class="form-group">
                            <label for="femail">实名认证状态</label>
                            <input disabled type="email" class="form-control" id="fauthstatus" value="${sessionScope.member.authstatus}">
                        </div>
                        <div class="form-group">
                            <label for="femail">用户类型</label>
                            <input disabled type="email" class="form-control" id="fusertype" value="${sessionScope.member.usertype}">
                        </div>
                        <div class="form-group">
                            <label for="femail">真实姓名</label>
                            <input disabled type="email" class="form-control" id="frealname" value="${sessionScope.member.realname}">
                        </div>
                        <div class="form-group">
                            <label for="femail">身份证号</label>
                            <input disabled type="email" class="form-control" id="fcardnum" value="${sessionScope.member.cardnum}">
                        </div>
                        <div class="form-group">
                            <label for="femail">手机号</label>
                            <input disabled type="email" class="form-control" id="ftel" value="${sessionScope.member.tel}">
                        </div>
                        <button onclick="updateSetting()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
                        <button onclick="resetMemberForm()" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                        <a href="${APP_PATH}/member.htm" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 返回</a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/back-to-top.js"></script>
<script src="${APP_PATH}/script/echarts.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>

<%--修改个人信息--%>
<script>
    function updateSetting() {
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
                "id" : ${sessionScope.member.id},
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
            url : "${APP_PATH}/member/updateSetting.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据修改中...', {icon: 16});
                //对表单数据进行校验
                return true;
            },

            success : function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    layer.msg("数据修改成功");
                    window.location.href="${APP_PATH}/member.htm";
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

<%--重置表单数据--%>
<script>
    function resetMemberForm() {
        //jQuery没有reset函数，使用需要性转换为dom对象使用 [0]
        $("#settingMemberForm")[0].reset();
    }
</script>
</body>
</html>
