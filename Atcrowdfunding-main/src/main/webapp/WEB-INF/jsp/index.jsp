<%--
    后台显示的首页面
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
    <link rel="stylesheet" href="${APP_PATH}/css/carousel.css">
    <link rel="stylesheet" href="${APP_PATH}/jquery/pagination/pagination.css">
    <style>
        h3 {
            font-weight:bold;
        }
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
        /* 侧栏导航 */
        .sideBox{padding:10px;height:220px;background:#fff;margin-bottom:10px;overflow:hidden;}
        .sideBox .hd{height:30px; line-height:30px; background:#f60; padding:0 10px;text-align:center;overflow:hidden;}
        .sideBox .hd .more{color:#fff;}
        .sideBox .hd h3 span{font-weight:bold; font-size:14px;color:#fff;}
        .sideBox .bd{padding:5px 0 0;}

        #sideMenu .bd li{margin-bottom:2px; height:30px; line-height:30px;text-align:center; overflow:hidden;}
        #sideMenu .bd li a{display:block;background:#EAE6DD;}
        #sideMenu .bd li a:hover{background:#D5CFBF;}

        /* 列表页 */
        #mainBox{margin-bottom:10px;padding:10px;background:#fff;overflow:hidden;}
        #mainBox .mHd{border-bottom:2px solid #09c;height:30px;line-height:30px;}
        #mainBox .mHd h3{display:initial;*display:inline;zoom:1;padding:0 15px;background:#09c;color:#fff;}
        #mainBox .mHd h3 span{color:#fff;font-size:14px;font-weight:bold;}
        #mainBox .path{float:right;}

        /* 位置导航 */
        .path{ height:30px; line-height:30px; padding-left:10px;}
        .path a,.path span{ margin:0 5px;}

        /* 文章列表 */
        .newsList{padding:10px;text-align:left;}
        .newsList li{background:url("../images/share/point.jpg") no-repeat 2px 14px; padding-left:10px;height:30px; line-height:30px;}
        .newsList li a{display:inline-block;*display:inline;zoom:1;font-size:14px;}
        .newsList li .date{float:right; color:#999;}
        .newsList li.split{margin-bottom:10px;padding-bottom:10px;border-bottom:1px dotted #ddd;height:0px;line-height:0px;overflow:hidden;}

        /* 通用带图片的信息列表_普通式 */
        .picList{padding:10px;text-align:left;}
        .picList li{margin:0 5px;height:190px;}

        h3.break {
            font-size:16px;
            display: block;
            white-space: nowrap;
            word-wrap: normal;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        h3.break>a {
            text-decoration:none;
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

<!--  轮播图 -->
<div id="myCarousel" class="carousel slide" data-ride="carousel"></div>

<%--轮播图下面的广告--%>
<div class="container marketing">
    <div class="row" id="publishAdvertisementBox"></div>
    <div id="Pagination" class="pagination" style="padding-left: 500px"></div>
</div>

<%--科技--%>
<div id="Technology" class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="box ui-draggable" id="mainBox">
                <div class="mHd" style="">
                    <div class="path">
                        <a href="#">更多...</a>
                    </div>
                    <h3>
                        科技 <small style="color:#FFF;">开启智慧未来</small>
                    </h3>
                </div>
                <div class="mBd" id="publishTechnologyProject" style="padding-top:10px;">

                </div>
            </div>

        </div>
    </div>
</div>

<%--设计--%>
<div id="Design" class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="box ui-draggable" id="mainBox">
                <div class="mHd" style="">
                    <div class="path">
                        <a href="#">更多...</a>
                    </div>
                    <h3>
                        设计 <small style="color:#FFF;">创意改变生活</small>
                    </h3>
                </div>
                <div class="mBd" id="publishDesignProject" style="padding-top:10px;">

                </div>
            </div>

        </div>
    </div>
</div>

<%--农业--%>
<div id="Agriculture" class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="box ui-draggable" id="mainBox">
                <div class="mHd" style="">
                    <div class="path">
                        <a href="#">更多...</a>
                    </div>
                    <h3>
                        农业 <small style="color:#FFF;">网络天下肥美</small>
                    </h3>
                </div>
                <div class="mBd" id="publishAgricultureProject" style="padding-top:10px;">
                </div>
            </div>

        </div>
    </div>
</div>

<%--其他--%>
<div id="Others" class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="box ui-draggable" id="mainBox">
                <div class="mHd" style="">
                    <div class="path">
                        <a href="#">更多...</a>
                    </div>
                    <h3>
                        其他 <small style="color:#FFF;">发现更多惊喜</small>
                    </h3>
                </div>
                <div class="mBd" id="publishOthersProject" style="padding-top:10px;">
                </div>
            </div>

        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/back-to-top.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/pagination/jquery.pagination.js"></script>
<script>
    $(".thumbnail img").css("cursor", "pointer");
    $(".thumbnail img").click(function(){
        window.location.href = "project.html";
    });
    $(function () {
        //加载轮播图广告
        publishCarouseAdvertisement(0);
        //加载一般广告
        publishAdvertisement(0);
        //加载科技类项目
        publishTechnologyProject(0);
        //加载设计类项目
        publishDesignProject(0);
        //加载农业类项目
        publishAgricultureProject(0);
        //加载其他类项目
        publishOthersProject(0);
    })
</script>

<%--加载轮播图广告图片--%>
<script>
    function publishCarouseAdvertisement(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/advertisement/selectPublishCarouse.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;

                    var content = "";
                    content += '<ol class="carousel-indicators">\n' +
                               '<li data-target="#myCarousel" data-slide-to="0" class="active"></li>\n' +
                               '<li data-target="#myCarousel" data-slide-to="1"></li>\n' +
                               '<li data-target="#myCarousel" data-slide-to="2"></li>\n' +
                               '</ol>\n' +
                               '<div class="carousel-inner" role="listbox">';

                    $.each(data,function (i,n) {
                        if (i == "0"){
                            content += '<div class="item active" onclick="window.location.href=\'#\'" style="cursor:pointer;">\n' +
                                '<img src="${APP_PATH}/picture/advertisement/'+n.iconpath+'" alt="First slide">\n' +
                                '</div>'
                        }else if (i == "1") {
                            content += '<div class="item" onclick="window.location.href=\'#\'" style="cursor:pointer;">\n' +
                                '<img src="${APP_PATH}/picture/advertisement/'+n.iconpath+'" alt="Second slide">\n' +
                                '</div>'
                        }else if (i == "2") {
                            content += '<div class="item" onclick="window.location.href=\'#\'" style="cursor:pointer;">\n' +
                                '<img src="${APP_PATH}/picture/advertisement/'+n.iconpath+'" alt="Third slide">\n' +
                                '</div>'
                        }
                    });

                    content += '</div>\n' +
                               '<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">\n' +
                               '<span class="glyphicon glyphicon-chevron-left"></span>\n' +
                               '<span class="sr-only">Previous</span>\n' +
                               '</a>\n' +
                               '<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">\n' +
                               '<span class="glyphicon glyphicon-chevron-right"></span>\n' +
                               '<span class="sr-only">Next</span>\n' +
                               '</a>';

                    $("#myCarousel").html(content);

                } else {
                    //查询数据失败
                    layer.msg("轮播图加载失败");
                }
            },
            error : function () {
                layer.msg("轮播图加载失败");
            }
        });
    }

</script>

<%--加载发布一般的广告--%>
<script>
    function publishAdvertisement(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/advertisement/selectPublish.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;

                    var content = '';
                    /* 对后台返回的数据进行拼串展示 */
                    $.each(data,function(i,n){
                        content+="<div class='col-lg-4'>";
                        content+="<img src=\'${APP_PATH }/picture/advertisement/"+n.iconpath+"\' style=\'width: 100px; height: 100px;\'>";
                        content+="<h2>"+n.name+"</h2>";
                        content+="<p><a class='btn btn-default' href='#' role='button'>项目详情 &raquo;</a></p>";
                        content+="</div>";
                    });

                    // 将拼接到的数据放入标签的指定位置
                    $("#publishAdvertisementBox").html(content);

                } else {
                    //查询数据失败
                    layer.msg("数据加载失败");
                }
            },
            error : function () {
                layer.msg("数据加载失败");
            }
        });
    }
</script>

<%--加载科技类项目--%>
<script>
    function publishTechnologyProject(pageIndex) {
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
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;

                    var content = "";
                    content += '<div class="row">';

                    $.each(data,function (i,n) {
                        content+="<div class='col-md-3'>";
                        content+="<div class='thumbnail'>";
                        content+="<img id='potalProject' src='${APP_PATH }/picture/project/"+n.filename+"' style='width: 300px; height: 150px;'>";
                        content+="<div class='caption'>";
                        content+="<h3 class='break'>";
                        content+="<a id='potalProject' href='${APP_PATH}/potalProject/index.htm?id="+n.id+"&memberid="+n.memberid+"'>"+n.name+"</a>";
                        content+="</h3>";
                        content+="<p>";
                        content+="<div style='float:left;'><i class='glyphicon glyphicon-screenshot' title='目标金额' ></i> $"+n.money+" </div>";
                        content+="<div style='float:right;'><i title='截至日期' class='glyphicon glyphicon-calendar'></i>"+n.createdate+" </div>";
                        content+="</p>";
                        content+="<br>";
                        content+="<div class='progress' style='margin-bottom: 4px;'>";
                        content+="<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 90%'>";
                        content+="<span >90% </span>";
                        content+="</div>";
                        content+="</div>";
                        content+="<div><span style='float:right;'><i class='glyphicon glyphicon-star-empty' ></i></span>  <span ><i class='glyphicon glyphicon-user' title='支持人数'></i> </span>支持人数:"+n.supporter+"</div>";
                        content+="</div>";
                        content+="</div>";
                        content+="</div>";
                    });

                    content += '</div>';

                    $("#publishTechnologyProject").html(content);

                } else {
                    //查询数据失败
                    layer.msg("科技项目加载失败");
                }
            },
            error : function () {
                layer.msg("科技项目加载失败");
            }
        });
    }

</script>

<%--加载设计类项目--%>
<script>
    function publishDesignProject(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/project/publishDesignProject.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;

                    //alert(data);

                    var content = "";
                    content += '<div class="row">';

                    $.each(data,function (i,n) {
                        content+="<div class='col-md-3'>";
                        content+="<div class='thumbnail'>";
                        content+="<img src='${APP_PATH }/picture/project/"+n.filename+"' style='width: 300px; height: 150px;'>";
                        content+="<div class='caption'>";
                        content+="<h3 class='break'>";
                        content+="<a href='${APP_PATH}/potalProject/index.htm?id="+n.id+"'>"+n.name+"</a>";
                        content+="</h3>";
                        content+="<p>";
                        content+="<div style='float:left;'><i class='glyphicon glyphicon-screenshot' title='目标金额' ></i> $"+n.money+" </div>";
                        content+="<div style='float:right;'><i title='截至日期' class='glyphicon glyphicon-calendar'></i>"+n.createdate+" </div>";
                        content+="</p>";
                        content+="<br>";
                        content+="<div class='progress' style='margin-bottom: 4px;'>";
                        content+="<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 90%'>";
                        content+="<span >90% </span>";
                        content+="</div>";
                        content+="</div>";
                        content+="<div><span style='float:right;'><i class='glyphicon glyphicon-star-empty' ></i></span>  <span ><i class='glyphicon glyphicon-user' title='支持人数'></i> </span>支持人数:"+n.supporter+"</div>";
                        content+="</div>";
                        content+="</div>";
                        content+="</div>";
                    });

                    content += '</div>';

                    $("#publishDesignProject").html(content);

                } else {
                    //查询数据失败
                    layer.msg("设计类项目加载失败");
                }
            },
            error : function () {
                layer.msg("设计类项目加载失败");
            }
        });
    }

</script>

<%--加载农业类项目--%>
<script>
    function publishAgricultureProject(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/project/publishAgricultureProject.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;
                    var content = "";
                    content += '<div class="row">';

                    $.each(data,function (i,n) {
                        content+="<div class='col-md-3'>";
                        content+="<div class='thumbnail'>";
                        content+="<img src='${APP_PATH }/picture/project/"+n.filename+"' style='width: 300px; height: 150px;'>";
                        content+="<div class='caption'>";
                        content+="<h3 class='break'>";
                        content+="<a href='${APP_PATH}/potalProject/index.htm?id="+n.id+"'>"+n.name+"</a>";
                        content+="</h3>";
                        content+="<p>";
                        content+="<div style='float:left;'><i class='glyphicon glyphicon-screenshot' title='目标金额' ></i> $"+n.money+" </div>";
                        content+="<div style='float:right;'><i title='截至日期' class='glyphicon glyphicon-calendar'></i>"+n.createdate+" </div>";
                        content+="</p>";
                        content+="<br>";
                        content+="<div class='progress' style='margin-bottom: 4px;'>";
                        content+="<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 90%'>";
                        content+="<span >90% </span>";
                        content+="</div>";
                        content+="</div>";
                        content+="<div><span style='float:right;'><i class='glyphicon glyphicon-star-empty' ></i></span>  <span ><i class='glyphicon glyphicon-user' title='支持人数'></i> </span>支持人数:"+n.supporter+"</div>";
                        content+="</div>";
                        content+="</div>";
                        content+="</div>";
                    });

                    content += '</div>';

                    $("#publishAgricultureProject").html(content);

                } else {
                    //查询数据失败
                    layer.msg("设计类项目加载失败");
                }
            },
            error : function () {
                layer.msg("设计类项目加载失败");
            }
        });
    }
</script>

<%--加载其他类项目--%>
<script>
    function publishOthersProject(pageIndex) {
        $.ajax({
            type : "POST",
            data : {
                "pageno" : pageIndex + 1,
                "pagesize" : 8
            },
            url : "${APP_PATH}/project/publishOthersProject.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                    //查询数据成功
                    var page = result.page;
                    var data = page.datas;
                    var content = "";
                    content += '<div class="row">';
                    $.each(data,function (i,n) {
                        content+="<div class='col-md-3'>";
                        content+="<div class='thumbnail'>";
                        content+="<img src='${APP_PATH }/picture/project/"+n.filename+"' style='width: 300px; height: 150px;'>";
                        content+="<div class='caption'>";
                        content+="<h3 class='break'>";
                        content+="<a href='${APP_PATH}/potalProject/index.htm?id="+n.id+"'>"+n.name+"</a>";
                        content+="</h3>";
                        content+="<p>";
                        content+="<div style='float:left;'><i class='glyphicon glyphicon-screenshot' title='目标金额' ></i> $"+n.money+" </div>";
                        content+="<div style='float:right;'><i title='截至日期' class='glyphicon glyphicon-calendar'></i>"+n.createdate+" </div>";
                        content+="</p>";
                        content+="<br>";
                        content+="<div class='progress' style='margin-bottom: 4px;'>";
                        content+="<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='0' aria-valuemin='0' aria-valuemax='100' style='width: 90%'>";
                        content+="<span >90% </span>";
                        content+="</div>";
                        content+="</div>";
                        content+="<div><span style='float:right;'><i class='glyphicon glyphicon-star-empty' ></i></span>  <span ><i class='glyphicon glyphicon-user' title='支持人数'></i> </span>支持人数:"+n.supporter+"</div>";
                        content+="</div>";
                        content+="</div>";
                        content+="</div>";
                    });
                    content += '</div>';
                    $("#publishOthersProject").html(content);

                } else {
                    //查询数据失败
                    layer.msg("设计类项目加载失败");
                }
            },
            error : function () {
                layer.msg("设计类项目加载失败");
            }
        });
    }
</script>

</body>
</html>
