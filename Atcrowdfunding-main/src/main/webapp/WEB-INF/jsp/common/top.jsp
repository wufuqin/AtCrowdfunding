<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
    后台页面的头部
        抽取出来，在后面需要的页面中直接调用即可
--%>
<%--服务器编号--%>;
<jsp:include page="/WEB-INF/jsp/common/topServer.jsp"/>
<li style="padding-top:8px; padding-right: 40px">
    <div class="btn-group">
        <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
            <i class="glyphicon glyphicon-user"></i> ${sessionScope.user.username} <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" role="menu">
            <li><a href="${APP_PATH}/user/setting.htm"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
            <%--<li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>--%>
            <li class="divider"></li>
            <li><a href="${APP_PATH}/logout.do" onclick="return confirm('确认退出？')"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
        </ul>
    </div>
</li>

<%--
<li style="margin-left:10px;padding-top:8px;">
    <button type="button" class="btn btn-default btn-danger">
        <span class="glyphicon glyphicon-question-sign"></span> 帮助
    </button>

</li>--%>
