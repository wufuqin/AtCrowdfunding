<%--
  会员页面顶部公共页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="navbar-header">
        <a class="navbar-brand" href="${APP_PATH}/index.htm" style="font-size:32px;">尚筹网-创意产品众筹平台</a>
    </div>
    <div id="navbar" class="navbar-collapse collapse" style="float:right;">
        <ul class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> ${sessionScope.member.username}<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="${APP_PATH}/member/setting.htm"><i class="glyphicon glyphicon-scale"></i> 会员中心</a></li>
                    <%--<li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>--%>
                    <li class="divider"></li>
                    <li><a href="${APP_PATH}/logout.do" onclick="return confirm('确认退出？')"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
