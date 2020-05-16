<%--
  会员主页面
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
    <link rel="stylesheet" href="${APP_PATH}/jquery/pagination/pagination.css">
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
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
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
                        <img src="http://47.95.223.197/test/pic/services-box1.jpg" class="img-thumbnail" alt="">
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
                <div class="list-group-item" style="cursor:pointer;" onclick="window.location.href='${APP_PATH}/member.htm'">
                    我的众筹<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
                </div>

            </div>
        </div>

        <div class="col-sm-9 col-md-9 column">
            <div id="myTabContent" class="tab-content" style="margin-top:10px;">
                <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">

                    <ul id="myTab1" class="nav nav-tabs">
                        <li role="presentation" class="active"><a href="#support">我支持的</a></li>
                        <li role="presentation"><a href="#add">我发起的</a></li>
                    </ul>
                    <div id="myTab1" class="tab-content" style="margin-top:10px;">
                        <div role="tabpanel" class="tab-pane fade active in" id="support" aria-labelledby="home-tab">
                            <div class="container-fluid">
                                <div class="row clearfix">
                                   <%-- <div class="col-md-12 column">
                                        <span class="label label-warning">全部</span> <span class="label" style="color:#000;">已支付</span> <span class="label " style="color:#000;">未支付</span>
                                    </div>--%>
                                    <div class="col-md-12 column" style="margin-top:10px;padding:0;">
                                        <table class="table table-bordered" style="text-align:center;">
                                            <thead>
                                            <tr style="background-color:#ddd;">
                                                <td>项目信息</td>
                                                <%--<td width="90">支持日期</td>--%>
                                                <td width="120">支持金额（元）</td>
                                                <td width="80">回报数量</td>
                                                <td width="80">交易状态</td>
                                                <%--<td width="120">操作</td>--%>
                                            </tr>
                                            </thead>

                                            <tbody id="mySupport">
                                                <%--展示项目数据--%>
                                            </tbody>

                                            <%-- 分页导航条 --%>
                                            <tfoot>
                                            <tr >
                                                <td colspan="6" align="center">
                                                    <%--使用pagination分页插件--%>
                                                    <%--显示分页的容器--%>
                                                    <div id="Pagination1" class="pagination"></div>
                                                </td>
                                            </tr>
                                            </tfoot>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane fade  " id="add" aria-labelledby="add-tab">
                            <div class="container-fluid">
                                <div class="row clearfix">
                                   <%-- <div class="col-md-12 column">
                                        <span class="label label-warning">全部</span> <span class="label" style="color:#000;">众筹中</span> <span class="label " style="color:#000;">众筹成功</span>  <span class="label " style="color:#000;">众筹失败</span>
                                    </div>--%>
                                    <div class="col-md-12 column" style="padding:0;margin-top:10px;">
                                        <table class="table table-bordered" style="text-align:center;">
                                            <thead>
                                            <tr style="background-color:#ddd;">
                                                <td style="width: 100px">项目信息</td>
                                                <td width="120">需要金额（元）</td>
                                                <td width="80">当前状态</td>
                                                <%--<td width="120">操作</td>--%>
                                            </tr>
                                            </thead>
                                            <tbody id="myProject">

                                            </tbody>
                                            <%-- 分页导航条 --%>
                                            <tfoot>
                                            <tr >
                                                <td colspan="6" align="center">
                                                    <%--使用pagination分页插件--%>
                                                    <%--显示分页的容器--%>
                                                    <div id="Pagination2" class="pagination"></div>
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
<script src="${APP_PATH}/jquery/pagination/jquery.pagination.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
    $('#myTab1 a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    });

    $(function () {
        //加载已经发布的众筹项目
        showMerchantProject(0);
        //加载会员支持的项目数据
        showMemberSupportProject(0);
    });

</script>

<%--加载会员支持的项目数据--%>
<script>
    function showMemberSupportProject(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 2
            },
            url : "${APP_PATH}/member/showMemberSupportProject.do",
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
                    var content = '';
                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+='<tr>';
                        content+='<td style="vertical-align:middle;">';
                        content+='<div class="thumbnail">';
                        content+='<div class="caption">';
                        content+='<h3>';
                        content+='<h3>'+n.name+'</h3>';
                        // content+='<p>订单编号:2x002231111</p>';
                        // content+='<p>';
                        // content+='<div style="float:left;"><i class="glyphicon glyphicon-screenshot" title="目标金额" ></i> '+n.name+' </div>';
                        // content+='<div style="float:right;"><i title="截至日期" class="glyphicon glyphicon-calendar"></i> 剩余8天 </div>';
                        // content+='<div style="float:right;"><i title="截至日期" class="glyphicon glyphicon-calendar"></i> 剩余8天 </div>';
                        // content+='</p>';
                        // content+='<br>';
                        // content+='<div class="progress" style="margin-bottom: 4px;">';
                        // content+='<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">';
                        // content+='<span >众筹成功</span>';
                        // content+='</div>';
                        // content+='</div>';
                        content+='</div>';
                        content+='</div>';
                        content+='</td>';
                        // content+='<td style="vertical-align:middle;">2017-05-23 11:31:22</td>';
                        content+='<td style="vertical-align:middle;">1.00</td>';
                        content+='<td style="vertical-align:middle;">1</td>';
                        content+='<td style="vertical-align:middle;">交易成功</td>';
                        // content+='<td style="vertical-align:middle;">';
                        // content+='<div class="btn-group-vertical" role="group" aria-label="Vertical button group">';
                        //content+='<button type="button" class="btn btn-default">删除订单</button>';
                        // content+='<button type="button" class="btn btn-default">交易详情</button>';
                        // content+='</div>';
                        // content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("#mySupport").html(content);

                    // 创建分页
                    $("#Pagination1").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 1, //主体页数
                        callback: showMemberSupportProject, //当前函数
                        items_per_page:3, //每页显示多少条
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

<%--加载商家发起的项目数据--%>
<script>
    function showMerchantProject(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 3
            },
            url : "${APP_PATH}/member/showMerchantProject.do",
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
                    var content = '';
                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+='<tr>';
                        content+='<td style="vertical-align:middle;">';
                        content+='<div class="thumbnail">';
                        content+='<div class="caption">';
                        content+='<p>';
                        content+=''+n.name+'';
                        content+='</p>';
                        // content+='<p>';
                        // content+='<div style="float:left;"><i class="glyphicon glyphicon-screenshot" title="目标金额" ></i> 已完成 100% </div>';
                        // content+='<div style="float:right;"><i title="截至日期" class="glyphicon glyphicon-calendar"></i> 剩余8天 </div>';
                        // content+='</p>';
                        // content+='<br>';
                        // content+='<div class="progress" style="margin-bottom: 4px;">';
                        // content+='<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">';
                        // content+='<span >众筹中</span>';
                        // content+='</div>';
                        content+='</div>';
                        content+='</div>';
                        content+='</div>';
                        content+='</td>';
                        content+='<td style="vertical-align:middle;">'+n.money+'</td>';
                        content+='<td style="vertical-align:middle; color: red">众筹中</td>';
                        // content+='<td style="vertical-align:middle;">';
                        // content+='<div class="btn-group-vertical" role="group" aria-label="Vertical button group">';
                        // content+='<button type="button" class="btn btn-default">项目预览</button>';
                        // content+='<button type="button" class="btn btn-default">删除项目</button>';
                        // content+='<button type="button" class="btn btn-default">问题管理</button>';
                        // content+='</div>';
                        // content+='</td>';
                        content+='</tr>';
                    });
                    // 将拼接到的数据放入 tbody标签的指定位置
                    $("#myProject").html(content);

                    // 创建分页
                    $("#Pagination2").pagination(page.totalsize, {
                        num_edge_entries: 2, //边缘页数
                        num_display_entries: 1, //主体页数
                        callback: showMerchantProject, //当前函数
                        items_per_page:3, //每页显示多少条
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

</body>
</html>




























