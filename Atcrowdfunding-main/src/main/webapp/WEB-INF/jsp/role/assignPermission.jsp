<%--
    角色维护模块
        分配许可
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
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限分配列表:给角色 <span style="color: red"> ${role.name}</span> 分配权限<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>

                <div class="panel-body">
                   <%-- <button id="assignPermissionBtn" class="btn btn-success">分配许可</button>
                    <button style="width: 90px" type="button" onclick="window.location.href='${APP_PATH}/role/index.htm'" class="btn btn-info">返回</button>
                    <br>
                    <br>--%>
                    <ul id="treeDemo" class="ztree" onclick="return false"></ul>
                    <button id="assignPermissionBtn" class="btn btn-success">分配许可</button>
                    <button style="width: 90px" type="button" onclick="window.location.href='${APP_PATH}/role/index.htm'" class="btn btn-info">返回</button>

                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/script/menu.js"></script>
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


        var setting = {
            check : {
                enable : true  //在树节点前显示复选框
            },
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                    }
                }
            },
            async: {
                enable: true, //采用异步
                url:"${APP_PATH}/role/loadDataAsync.do?roleid=${param.roleid}", // ?id=1&n=xxx&lv=2
                autoParam:["id", "name=n", "level=lv"]
            },
            callback: {
                onClick : function(event, treeId, json) {
                    return false
                }
            }
        };
        //异步加载树:注意问题,服务器端返回的结果必须是一个数组.
        $.fn.zTree.init($("#treeDemo"), setting); //异步加载树的数据.
    });
</script>

<%--分配许可--%>
<script>
    $("#assignPermissionBtn").click(function(){

        var jsonObj = {
            roleid : "${param.roleid}"
        };

        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");

        var checkedNodes = treeObj.getCheckedNodes(true); // 获取被选中的节点


        $.each(checkedNodes,function(i,n){
            jsonObj["ids["+i+"]"] = n.id;
        });

            var loadingIndex = -1 ;
            $.ajax({
                type : "POST",
                url : "${APP_PATH}/role/doAssignPermission.do",
                data : jsonObj,
                beforeSend : function(){
                    loadingIndex = layer.msg('正在分配许可...', {icon: 16});
                    return true ;
                },
                success : function(result){
                    layer.close(loadingIndex);
                    if(result.success){
                        layer.msg("分配成功");
                        setTimeout(function () {{window.location.href="${APP_PATH}/role/index.htm"}},1000);
                    }else{
                        layer.msg("分配失败");
                    }
                },
                error : function(){
                    layer.msg("操作失败!");
                }
            });
    });
</script>

</body>
</html>

