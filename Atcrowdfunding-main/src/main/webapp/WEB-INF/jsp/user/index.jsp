<%--
    用户维护模块的首页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%-- 包含head部分 --%>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"/>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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

        <%--菜单区--%>
        <div class="col-sm-3 col-md-2 sidebar" >
            <div class="tree">
                <%--包含左侧菜单页面--%>
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
            </div>
        </div>

        <%--数据展示区--%>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryBtn" onclick="queryPageUserLike(1)" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button onclick="deleteBatchBtn()" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/user/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive" >
                        <table class="table  table-bordered">
                            <%-- 表格头部信息 --%>
                            <thead>
                                <tr >
                                    <th class="text-center" width="50">序号</th>
                                    <th class="text-center" width="30"><input id="checkAll" type="checkbox"></th>
                                    <th class="text-center">账号</th>
                                    <th class="text-center">名称</th>
                                    <th class="text-center">邮箱地址</th>
                                    <th class="text-center" width="200">操作</th>C
                                </tr>
                            </thead>

                            <%-- 查询出的数据 --%>
                            <tbody>
                                <%-- 查询出来的数据展示区 --%>
                            </tbody>

                            <%-- 分页导航条 --%>
                            <tfoot>
                                <tr >
                                    <td colspan="6" align="center">
                                        <ul class="pagination"></ul>
                                    </td>
                                </tr>
                            </tfoot>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 包含src部分 --%>
<jsp:include page="/WEB-INF/jsp/common/src.jsp"/>

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
        //调用查询用户数据方法
        queryPageUser(1);
    });

</script>

<%-- 异步查询用户数据 --%>
<script>
    function queryPageUser(pageno) {
        $.ajax({
           type : "POST",
           data : {
               "pageno" : pageno,
               "pagesize" : 5
           },
            url : "${APP_PATH}/user/doIndex.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据加载中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;
                    /*判断返回的集合中是否有数据*/
                    if (data.length == 0){
                        layer.msg("目前没有查询到用户信息",{time:2000, icon:6, shift:6});
                        return false;
                    }
                    //layer.msg("数据加载成功",{time:2000, icon:6, shift:6});
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+='<tr>';
                        content+='<td class="text-center" >'+(i+1)+'</td>';
                        content+='<td class="text-center" ><input type="checkbox" id="'+n.id+'"/></td>';
                        content+='<td class="text-center" >'+n.loginacct+'</td>';
                        content+='<td class="text-center" style="color: #0f0f0f">'+n.username+'</td>';
                        content+='<td class="text-center" >'+n.email+'</td>';
                        content+='<td>';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/user/assignRole.htm?id='+n.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i>分配权限</button>';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/user/update.htm?id='+n.id+'\'" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-pencil"></i>修改</button>';
                        content+='<button type="button" onclick="doDelete('+n.id+',\''+n.loginacct+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i>删除</button>';
                        content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("tbody").html(content);

                    /* 分页导航条拼串 */
                    var contentBar = '';
                    /* 判断是否为第一页 */
                    if(page.pageno==1 ){
                        contentBar+='<li class="disabled"><a href="#">上一页</a></li>';
                    }else{
                        contentBar+='<li><a href="#" onclick="queryPageUser('+(page.pageno-1)+')">上一页</a></li>';
                    }

                    /* 将所在也页设置 active属性 */
                    for(var i = 1 ; i<= page.totalno ; i++ ){
                        contentBar+='<li';
                        if(page.pageno==i){
                            contentBar+=' class="active"';
                        }
                        contentBar+='><a href="#" onclick="queryPageUser('+i+')">'+i+'</a></li>';
                    }

                    /* 判断是否为最后一页 */
                    if(page.pageno==page.totalno ){
                        contentBar+='<li class="disabled"><a href="#">下一页</a></li>';
                    }else{
                        contentBar+='<li><a href="#" onclick="queryPageUser('+(page.pageno+1)+')">下一页</a></li>';
                    }
                    $(".pagination").html(contentBar);

                } else {
                    //查询数据失败
                    layer.msg(result.message,{time:2000, icon:5, shift:6});
                }
            },
            error : function () {
                layer.msg("数据加载失败",{time:2000, icon:5, shift:6});
            }
        });
    }
</script>

<%-- 模糊查询 --%>
<script>
    function queryPageUserLike(pageno) {
        $.ajax({
           type : "POST",
           data : {
               "pageno" : pageno,
               "pagesize" : 5,
               "queryText" : $("#queryText").val()
           },
            url : "${APP_PATH}/user/doLike.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据加载中...', {icon: 16});
                return true;
            },
            success : function (result) {
                layer.close(loadingIndex);
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;
                    /*判断返回的集合中是否有数据*/
                    if (data.length == 0){
                        layer.msg("没有您要查询的用户信息",{time:2000, icon:6, shift:6});
                        return false;
                    }
                    //layer.msg("数据加载成功",{time:2000, icon:6, shift:6});
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+='<tr>';
                        content+='<td class="text-center" >'+(i+1)+'</td>';
                        content+='<td class="text-center" ><input type="checkbox" id="'+n.id+'" /></td>';
                        content+='<td class="text-center" >'+n.loginacct+'</td>';
                        content+='<td class="text-center" style="color: #0f0f0f">'+n.username+'</td>';
                        content+='<td class="text-center" >'+n.email+'</td>';
                        content+='<td>';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/user/assignRole.htm?id='+n.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i>分配权限</button>';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/user/update.htm?id='+n.id+'\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i>修改</button>';
                        content+='<button type="button" onclick="doDelete('+n.id+',\''+n.loginacct+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i>删除</button>';
                        content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("tbody").html(content);

                    /* 分页导航条拼串 */
                    var contentBar = '';
                    /* 判断是否为第一页 */
                    if(page.pageno==1 ){
                        contentBar+='<li class="disabled"><a href="#">上一页</a></li>';
                    }else{
                        contentBar+='<li><a href="#" onclick="queryPageUserLike('+(page.pageno-1)+')">上一页</a></li>';
                    }

                    /* 将所在也页设置 active属性 */
                    for(var i = 1 ; i<= page.totalno ; i++ ){
                        contentBar+='<li';
                        if(page.pageno==i){
                            contentBar+=' class="active"';
                        }
                        contentBar+='><a href="#" onclick="queryPageUserLike('+i+')">'+i+'</a></li>';
                    }

                    /* 判断是否为最后一页 */
                    if(page.pageno==page.totalno ){
                        contentBar+='<li class="disabled"><a href="#">下一页</a></li>';
                    }else{
                        contentBar+='<li><a href="#" onclick="queryPageUserLike('+(page.pageno+1)+')">下一页</a></li>';
                    }
                    $(".pagination").html(contentBar);

                } else {
                    //查询数据失败
                    layer.msg(result.message, {time:2000, icon:5, shift:6});
                }
            },
            error : function () {
                layer.msg("数据加载失败",{time:2000, icon:5, shift:6});
            }
        });
    }
</script>

<%-- 单条数据删除功能 --%>
<script>
    function doDelete(id,loginacct) {
        layer.confirm("确认删除["+loginacct+"]用户？", {icon: 3, title: '提示'}, function (cindex) {
            $.ajax({
                type : "POST",
                data : {
                    "id" : id
                },
                url : "${APP_PATH}/user/doDelete.do",
                beforeSend : function () {
                    layer.close(cindex);
                    loadingIndex = layer.msg('数据删除中...', {icon: 16});
                    //对表单数据进行校验
                    return true;
                },

                success : function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        loadingIndex = layer.msg('数据删除成功,正在更新数据...', {icon: 16});
                        //设置定时，让提示框显示一定时间
                        setTimeout(function () {{window.location.href="${APP_PATH}/user/index.htm"}},1000);
                    }else {
                        layer.msg(result.message,{time:2000, icon:5, shift:6});
                    }
                },
                error : function () {
                    layer.msg("数据删除失败",{time:2000, icon:5, shift:6});
                }
            });
        }, function (cindex) {
            layer.close(cindex);
        })
    }
</script>

<%--实现复选框的联动效果--%>
<script>
    $("#checkAll").click(function () {
        var checkedStatus = this.checked;
        //通过后代元素设置input的chenkbox属性
        $("tbody tr td input[type='checkbox']").prop("checked",checkedStatus);
    });
</script>

<%--批量删除--%>
<script>
    function deleteBatchBtn() {
        //获取被选中的复选框数据的id值
        var selectCheckbox = $("tbody tr td input:checked");
        
        //判断是否有选中的数据
        if (selectCheckbox.length==0) {
            layer.msg("请选择要删除的用户",{time:2000, icon:6, shift:6});
            return false;
        }
        
        //遍历id数组，进行循环拼串
        var idStr = "";
        $.each(selectCheckbox,function (i,n) {
            if (i != 0) {
                idStr += "&";
            }
            idStr += "id="+n.id;
        });
        //alert(idStr);
        layer.confirm("确认删除这些用户？", {icon: 3, title: '提示'}, function (cindex) {
            $.ajax({
                type : "POST",
                data : idStr,
                url : "${APP_PATH}/user/doDeleteBatch.do",
                beforeSend : function () {
                    layer.close(cindex);
                    loadingIndex = layer.msg('数据删除中...', {icon: 16});
                    //对表单数据进行校验
                    return true;
                },

                success : function (result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        loadingIndex = layer.msg('数据删除成功,正在更新数据...', {icon: 16});
                        //设置定时，让提示框显示一定时间
                        setTimeout(function () {{window.location.href="${APP_PATH}/user/index.htm"}},1000);
                    }else {
                        layer.msg(result.message,{time:2000, icon:5, shift:6});
                    }
                },
                error : function () {
                    layer.msg("数据删除失败",{time:2000, icon:5, shift:6});
                }
            });
        }, function (cindex) {
            layer.close(cindex);
        })
    }
</script>

</body>
</html>


















