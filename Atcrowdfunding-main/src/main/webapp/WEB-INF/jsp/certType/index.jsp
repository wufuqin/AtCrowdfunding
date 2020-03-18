<%--
  资质分类管理
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}

        input[type=checkbox] {
            width:18px;
            height:18px;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 分类管理</a></div>
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
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="tree">
                <%--包含左侧菜单页面--%>
                <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 资质分类表</h3>
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th class="text-center" >名称</th>
                                <th class="text-center" >商业公司</th>
                                <th class="text-center" >个体工商户</th>
                                <th class="text-center" >个人经营</th>
                                <th class="text-center" >政府及非营利组织</th>
                            </tr>
                            </thead>
                            <tbody>

                            <%--表格数据--%>
                            <c:forEach items="${allCert}" var="cert">
                                <tr>
                                    <td class="text-center">${cert.name}</td>
                                    <td class="text-center"><input type="checkbox" certid="${cert.id}" accttype="0"></td>
                                    <td class="text-center"><input type="checkbox" certid="${cert.id}" accttype="1"></td>
                                    <td class="text-center"><input type="checkbox" certid="${cert.id}" accttype="2"></td>
                                    <td class="text-center"><input type="checkbox" certid="${cert.id}" accttype="3"></td>
                                </tr>
                            </c:forEach>
                            </tbody>
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
    });
</script>

<%--回显数据--%>
<script>
    <c:forEach items="${certAcctTypeList}" var="cert">
        /*获取全部的checkbox属性*/
        $(":checkbox[certid='${cert.certid}'][accttype='${cert.accttype}']")[0].checked=true;
    </c:forEach>
</script>

<script>
    $(":checkbox").click(function(){
        var flg = this.checked;
        //通过this.certid能否获取自定义的属性值?
        var certid = $(this).attr("certid");
        var accttype = $(this).attr("accttype");

        if ( flg ) {

            // 增加账户类型和资质的关系
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/certType/insertAcctTypeCert.do",
                data : {
                    certid : certid,
                    accttype : accttype
                },
                success : function(result) {
                    if ( result.success ) {

                    } else {
                        layer.msg("分类关系保存失败", {time:1000, icon:5, shift:6});
                    }
                }
            });

        } else {

            // 删除账户类型和资质的关系
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/certType/deleteAcctTypeCert.do",
                data : {
                    certid : certid,
                    accttype : accttype
                },
                success : function(result) {
                    if ( result.success ) {

                    } else {
                        layer.msg("分类关系删除失败", {time:1000, icon:5, shift:6});
                    }
                }
            });
        }

    });
</script>

</body>
</html>























