<%--
    广告管理首页面
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 广告管理</a></div>
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
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button onclick="queryPageAdvertisementLike(0)" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button onclick="deleteBatchBtn()" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button onclick="window.location.href='${APP_PATH}/advertisement/add.htm'" type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th class="text-center" width="50">序号</th>
                                <th class="text-center" width="30"><input id="checkAll" type="checkbox"></th>
                                <th class="text-center">广告名称</th>
                                <th class="text-center">地址</th>
                                <th class="text-center">状态</th>
                                <th class="text-center" width="200">操作</th>
                            </tr>
                            </thead>
                            <%-- 查询出的数据 --%>
                            <tbody>
                            </tbody>
                            <%-- 分页导航条 --%>
                            <tfoot>
                            <tr >
                                <td colspan="8" align="center">
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
<script src="${APP_PATH}/jquery/pagination/jquery.pagination.js"></script>
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
        queryPageAdvertisement(0);
    });
</script>

<%-- 异步查询用户数据 --%>
<script>
    function queryPageAdvertisement(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/advertisement/doIndex.do",
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
                        layer.msg("目前没有查询到广告信息",{time:2000, icon:6, shift:6});
                        return false;
                    }
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+="<tr>";
                        content+="	<td class='text-center'>"+(i+1)+"</td>";
                        content+="	<td class='text-center' ><input type='checkbox' id='"+n.id+"'></td>";
                        content+="	<td class='text-center' >"+n.name+"</td>";
                        content+="	<td class='text-center' >"+n.url+"</td>";

                        //判断广告的状态
                        if(n.status=='0'){
                            content+="	<td class='text-center'>草稿</td>";
                        }else if(n.status=='1'){
                            content+="	<td class='text-center'>未审核</td>";
                        }else if(n.status=='2'){
                            content+="	<td class='text-center'>审核完成</td>";
                        }else if(n.status=='3'){
                            content+="	<td class='text-center'>发布</td>";
                        }else if(n.status=='4'){
                            content+="	<td class='text-center'>拒绝申请</td>";
                        }
                        content+='<td class="text-center">';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/advertisement/update.htm?id='+n.id+'\'" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-pencil"></i>修改</button>';
                        content+='<button type="button" onclick="doDelete('+n.id+',\''+n.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i>删除</button>';
                        content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("tbody").html(content);

                    // 创建分页
                    $("#Pagination").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: queryPageAdvertisement, //当前函数
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
</script>

<%-- 模糊查询 --%>
<script>
    function queryPageAdvertisementLike(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8,
                "queryText" : $("#queryText").val()
            },
            url : "${APP_PATH}/advertisement/doLike.do",
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
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+="<tr>";
                        content+="	<td class='text-center'>"+(i+1)+"</td>";
                        content+="	<td class='text-center' ><input type='checkbox' id='"+n.id+"'></td>";
                        content+="	<td class='text-center' >"+n.name+"</td>";
                        content+="	<td class='text-center' >"+n.url+"</td>";

                        //判断广告的状态
                        if(n.status=='0'){
                            content+="	<td class='text-center'>草稿</td>";
                        }else if(n.status=='1'){
                            content+="	<td class='text-center'>未审核</td>";
                        }else if(n.status=='2'){
                            content+="	<td class='text-center'>审核完成</td>";
                        }else if(n.status=='3'){
                            content+="	<td class='text-center'>发布</td>";
                        }else if(n.status=='4'){
                            content+="	<td class='text-center'>拒绝申请</td>";
                        }
                        content+='<td class="text-center">';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/advertisement/update.htm?id='+n.id+'\'" class="btn btn-primary btn-xs"><i class="glyphicon glyphicon-pencil"></i>修改</button>';
                        content+='<button type="button" onclick="doDelete('+n.id+',\''+n.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i>删除</button>';
                        content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("tbody").html(content);

                    // 创建分页
                    $("#Pagination").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: queryPageAdvertisementLike, //当前函数
                        items_per_page:8, //每页显示多少条
                        current_page :(page.pageno-1), //当前页
                        prev_text : "上一页",
                        next_text : "下一页"
                    });

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
    function doDelete(id,name) {
        layer.confirm("确认删除["+name+"]广告？", {icon: 3, title: '提示'}, function (cindex) {
            $.ajax({
                type : "POST",
                data : {
                    "id" : id
                },
                url : "${APP_PATH}/advertisement/doDelete.do",
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
                        setTimeout(function () {{window.location.href="${APP_PATH}/advertisement/index.htm"}},1000);
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
            layer.msg("请选择要删除的广告",{time:2000, icon:6, shift:6});
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
        layer.confirm("确认删除这些广告？", {icon: 3, title: '提示'}, function (cindex) {
            $.ajax({
                type : "POST",
                data : idStr,
                url : "${APP_PATH}/advertisement/doDeleteBatch.do",
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
                        setTimeout(function () {{window.location.href="${APP_PATH}/advertisement/index.htm"}},1000);
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




























