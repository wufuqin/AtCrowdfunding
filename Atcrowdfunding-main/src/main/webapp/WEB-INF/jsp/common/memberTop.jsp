<%--
  会员页面顶部公共页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">

    <div id="navbar" class="navbar-collapse collapse" style="float:right; padding-right: 70px">
        <ul class="nav navbar-nav">
            <c:choose>
                <c:when test="${!(sessionScope.member.username eq null)}">
                    <li style="padding-top:9px">
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
                    <li style="padding-top:9px; padding-right: 25px">
                        <ul class="nav navbar-nav navbar-right">
                            <div class="row">
                                <a href="login.htm" type="button" class="btn btn-info form-control" style="width: 100px">登录</a>
                                <a href="reg.htm" type="button" class="btn btn-info form-control" style="width: 100px"> 注册</a>
                            </div>
                        </ul>
                    </li>
                </c:when>

            </c:choose>

        </ul>
    </div>
    
    <form class="form-inline" role="form" style="float:right; padding-right: 50px; padding-top: 9px">
        <div class="form-group has-feedback">
            <div class="input-group">
                <div class="input-group-addon">查询条件</div>
                <input class="form-control has-success" type="text" placeholder="请输入查询条件">
            </div>
        </div>
        <button type="button" class="btn btn-info"><i class="glyphicon glyphicon-search"></i> 查询</button>
    </form>


    <div style="float:right; padding-right: 30px; padding-top: 4px; font-size:32px">
        <a href="${APP_PATH}/index.htm">其他</a>
    </div>

    <div style="float:right; padding-right: 30px; padding-top: 4px; font-size:32px">
        <a href="${APP_PATH}/index.htm">农业</a>
    </div>
    <div style="float:right; padding-right: 30px; padding-top: 4px; font-size:32px">
        <a href="${APP_PATH}/index.htm">设计</a>
    </div>
    <div style="float:right; padding-right: 30px; padding-top: 4px; font-size:32px">
        <a href="${APP_PATH}/index.htm">科技</a>
    </div>
    <div style="float:right; padding-right: 30px; padding-top: 4px; font-size:32px">
        <a href="${APP_PATH}/index.htm">首页</a>
    </div>
</div>
