<%--
    实名认证审核
--%>
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
    <link rel="stylesheet" href="${APP_PATH}/jquery/pagination/pagination.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 实名认证审核</a></div>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <%--<form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button onclick="AuthCertLike(0)" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>--%>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr class="text-center">
                                <th class="text-center" width="50">序号</th>
                                <th class="text-center">流程名称</th>
                                <th class="text-center">流程版本</th>
                                <th class="text-center">任务名称</th>
                                <th class="text-center">申请会员</th>
                                <th class="text-center" width="100">操作</th>
                            </tr>
                            </thead>
                            <%-- 查询出的数据 --%>
                            <tbody></tbody>
                            <%-- 分页导航条 --%>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <%--使用pagination分页插件--%>
                                    <%--显示分页的容器--%>
                                    <div id="Pagination" class="pagination"></div>
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

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/script/menu.js"></script>
<script src="${APP_PATH}/jquery/pagination/jquery.pagination.js"></script>
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
        queryPageAuthCert(0);
    });
</script>

<%--查询数据--%>
<script>
    function queryPageAuthCert(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/authCert/doIndex.do",
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
                        layer.msg("目前没有查询到资质信息");
                        return false;
                    }
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data, function(i, task){
                        content += '<tr>';
                        content += '<td class="text-center">'+(i+1)+'</td>';
                        content += '<td class="text-center">'+task.procDefName+'</td>';
                        content += '<td class="text-center">'+task.procDefVersion+'</td>';
                        content += '<td class="text-center">'+task.taskName+'</td>';
                        content += '<td class="text-center">'+task.member.username+'</td>';
                        content += '<td class="text-center">';
                        content += '<button type="button" onclick="window.location.href=\'${APP_PATH}/authCert/show.htm?taskid='+task.taskid+'&memberid='+task.member.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i>审核</button>';
                        content += '</td>';
                        content += '</tr>';
                    });
                    $("tbody").html(content);

                    /*使用pagination插件*/
                    // 创建分页
                    $("#Pagination").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: queryPageAuthCert, //当前函数
                        items_per_page:8, //每页显示多少条
                        current_page :(page.pageno-1), //当前页
                        prev_text : "上一页",
                        next_text : "下一页"
                    });


                } else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("数据加载失败");
            }
        });
    }
</script>

<%--模糊查询--%>
<%--<script>
    function AuthCertLike(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8,
                "queryText" : $("#queryText").val()
            },
            url : "${APP_PATH}/authCert/AuthCertLike.do",
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
                        layer.msg("目前没有查询到资质信息",{time:2000, icon:6, shift:6});
                        return false;
                    }
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data, function(i, task){
                        content += '<tr>';
                        content += '<td class="text-center">'+(i+1)+'</td>';
                        content += '<td class="text-center">'+task.procDefName+'</td>';
                        content += '<td class="text-center">'+task.procDefVersion+'</td>';
                        content += '<td class="text-center">'+task.taskName+'</td>';
                        content += '<td class="text-center">'+task.member.username+'</td>';
                        content += '<td class="text-center">';
                        content += '<button type="button" onclick="window.location.href=\'${APP_PATH}/authCert/show.htm?taskid='+task.taskid+'&memberid='+task.member.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        content += '</td>';
                        content += '</tr>';
                    });
                    $("tbody").html(content);

                    /*使用pagination插件*/
                    // 创建分页
                    $("#Pagination").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: AuthCertLike, //当前函数
                        items_per_page:8, //每页显示多少条
                        current_page :(page.pageno-1), //当前页
                        prev_text : "上一页",
                        next_text : "下一页"
                    });


                } else {
                    layer.msg(result.message,{time:2000, icon:5, shift:6});
                }
            },
            error : function () {
                layer.msg("数据加载失败",{time:2000, icon:5, shift:6});
            }
        });
    }
</script>--%>

</body>
</html>

