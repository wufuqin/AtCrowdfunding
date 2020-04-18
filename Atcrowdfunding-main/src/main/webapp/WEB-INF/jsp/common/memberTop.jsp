<%--
  会员页面顶部公共页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container; text-center">

    <div id="navbar" class="navbar-collapse collapse" style="float:right; padding-right: 200px">
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
                                <a href="${APP_PATH}/login.htm" type="button" class="btn btn-warning form-control" style="width: 100px">登录</a>
                                <a href="${APP_PATH}/reg.htm" type="button" class="btn btn-warning form-control" style="width: 100px"> 注册</a>
                            </div>
                        </ul>
                    </li>
                </c:when>
            </c:choose>
        </ul>
    </div>
    <form class="form-inline text-center" role="form" style="float:right; padding-right: 50px; padding-top: 9px">
        <div class="form-group has-feedback">
            <div class="input-group">
                <div class="input-group-addon">查询条件</div>
                <input id="queryProjectText" class="form-control has-success" type="text" placeholder="请输入查询条件">
            </div>
        </div>
        <button onclick="queryProjectLike(0)" type="button" class="btn btn-info"><i class="glyphicon glyphicon-search"></i> 查询</button>
    </form>

    <div style="float:right; padding-left: 20px; padding-right: 50px; padding-top: 8px; font-size:25px">
        <a href="${APP_PATH}/index.htm#Others">其他</a>
    </div>
    <div style="float:right; padding-left: 20px; padding-top: 8px; font-size:25px">
        <a href="${APP_PATH}/index.htm#Agriculture">农业类</a>
    </div>
    <div style="float:right; padding-left: 20px; padding-top: 8px; font-size:25px">
        <a href="${APP_PATH}/index.htm#Design">设计类</a>
    </div>
    <div style="float:right; padding-left: 20px; padding-top: 8px; font-size:25px">
        <a href="${APP_PATH}/index.htm#Technology">科技类</a>
    </div>
    <div style="float:right; padding-left: 20px; padding-top: 8px; font-size:25px">
        <a href="${APP_PATH}/index.htm">首页</a>
    </div>
</div>
<div style="float:right; font-size: 25px; padding-top: 8px; color: black">
    Tomcat2
</div>

<%--项目搜索功能--%>
<%--
<script>
    function queryProjectLike(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/project/publishTechnologyProject.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                } else {
                    //查询数据失败
                    layer.msg("项目数据加载失败");
                }
            },
            error : function () {
                layer.msg("科技项目数据加载失败");
            }
        });
    }
</script>--%>





















