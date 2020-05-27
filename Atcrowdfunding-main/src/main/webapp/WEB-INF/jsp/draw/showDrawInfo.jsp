<%--
    显示抽签信息
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%-- 包含head部分 --%>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"/>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">

</nav>

<div class="container-fluid">
    <div class="row">
        <%--数据展示区--%>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 抽签结果</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <button onclick="deleteBatchBtn()" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 批量删除</button>

                        <button onclick="newDraw()" type="button" class="btn btn-success" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-refresh"></i> 开启新一轮抽签</button>

                    </form>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive" >
                        <table class="table  table-bordered">
                            <%-- 表格头部信息 --%>
                            <thead>
                            <tr >
                                <th class="text-center" width="50">签号</th>
                                <th class="text-center" width="30"><input id="checkAll" type="checkbox"></th>
                                <th class="text-center">学号</th>
                                <th class="text-center">姓名</th>
                                <th class="text-center">抽签时间</th>

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
        queryPageDraw(0);
    });

</script>

<%-- 异步查询用户数据 --%>
<script>
    function queryPageDraw(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 38
            },
            url : "${APP_PATH}/drawInfo.do",
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
                        layer.msg("目前没有查询到信息",{time:2000, icon:6, shift:6});
                        return false;
                    }
                    var content = '';

                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+='<tr>';
                        content+='<td class="text-center" >'+n.draw+'</td>';
                        content+='<td class="text-center" ><input type="checkbox" id="'+n.id+'"/></td>';
                        content+='<td class="text-center" >'+n.studentId+'</td>';
                        content+='<td class="text-center" >'+n.name+'</td>';
                        content+='<td class="text-center" >'+n.createTime+'</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("tbody").html(content);

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

<%-- 模糊查询 --%>
<script>
    function queryPageUserLike(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8,
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
                        layer.msg("没有您要查询的用户信息");
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
                        content+='<td class="text-center" >'+n.username+'</td>';
                        content+='<td class="text-center" >'+n.email+'</td>';
                        content+='<td class="text-center">';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/user/assignRole.htm?id='+n.id+'\'" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i>分配权限</button>';
                        content+='<button type="button" onclick="window.location.href=\'${APP_PATH}/user/update.htm?id='+n.id+'\'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i>修改</button>';
                        content+='<button type="button" onclick="doDelete('+n.id+',\''+n.loginacct+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i>删除</button>';
                        content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("tbody").html(content);

                    /*使用pagination插件*/
                    // 创建分页
                    $("#Pagination").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 4, //主体页数
                        callback: queryPageUserLike, //当前函数
                        items_per_page:8, //每页显示多少条
                        current_page :(page.pageno-1), //当前页
                        prev_text : "上一页",
                        next_text : "下一页"
                    });

                } else {
                    //查询数据失败
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("数据加载失败");
            }
        });
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
            layer.msg("请选择要删除的用户");
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
        layer.confirm("确认删除这些数据？", {icon: 3, title: '提示'}, function (cindex) {
            $.ajax({
                type : "POST",
                data : idStr,
                url : "${APP_PATH}doDeleteBatch.do",
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
                        setTimeout(function () {{window.location.href="${APP_PATH}/showDrawInfo.htm"}},1000);
                    }else {
                        layer.msg(result.message);
                    }
                },
                error : function () {
                    layer.msg("数据删除失败");
                }
            });
        }, function (cindex) {
            layer.close(cindex);
        })
    }
</script>

<%--开启新一轮抽签--%>
<script>
    function newDraw() {
        $.ajax({
            type : "POST",
            url : "${APP_PATH}/newDraw.do",
            beforeSend : function () {
                loadingIndex = layer.msg('数据初始化中...', {icon: 16});
                return true;
            },
            success : function (result) {
                if (result.success){
                    layer.close(loadingIndex);
                    layer.msg("数据初始化成功");
                }else {
                    layer.msg(result.message);
                }
            },
            error : function () {
                layer.msg("数据初始化失败");
            }
        });
    }
</script>

</body>
</html>



















