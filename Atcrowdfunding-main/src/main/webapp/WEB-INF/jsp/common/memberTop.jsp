<%--
  会员页面顶部公共页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <div class="navbar-header">
        <a class="navbar-brand" href="${APP_PATH}/index.htm" style="font-size:32px;">尚筹网-创意产品众筹平台</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse" style="float:right;">
        <ul class="nav navbar-nav">
            <c:choose>
                <c:when test="${!(sessionScope.member.username eq null)}">
                    <li style="padding-top:8px">
                        <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                            <i class="glyphicon glyphicon-user"></i> ${sessionScope.member.username} <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="${APP_PATH}/member/setting.htm"><i class="glyphicon glyphicon-scale"></i> 会员中心</a></li>
                            <li class="divider"></li>
                            <li><a href="${APP_PATH}/logout.do" onclick="return confirm('确认退出？')"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                        </ul>
                    </li>
                </c:when>

                <c:when test="${sessionScope.member.username eq null}">
                    <li style="padding-top:15px; padding-right: 50px">
                        <ul class="nav navbar-nav navbar-right">
                            <div class="row">
                                <a href="login.htm" type="button" class="btn btn-info form-control" style="width: 50px">登录</a>
                                <a href="reg.htm" type="button" class="btn btn-info form-control" style="width: 50px"> 注册</a>
                            </div>
                        </ul>
                    </li>
                </c:when>

            </c:choose>

        </ul>
    </div>
</div>
