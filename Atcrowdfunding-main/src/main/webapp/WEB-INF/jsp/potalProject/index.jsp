<%--
  点击前台项目之后的首页面
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
        .nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
            border-bottom-color: #ddd;
        }
        .nav-tabs>li>a {
            border-radius: 0;
        }
    </style>
</head>
<body>

<%--页面头部导航栏--%>
<div class="navbar-wrapper">
    <div class="container">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <%--包含头部页面--%>
            <jsp:include page="/WEB-INF/jsp/common/memberTop.jsp"/>
        </nav>
    </div>
</div>

<%--项目信息--%>
<div class="container theme-showcase" role="main">

    <%--众筹导航条--%>
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <nav class="navbar navbar-default" role="navigation">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li>
                                <a rel="nofollow" href="#"><i class="glyphicon glyphicon-home"></i> 众筹首页</a>
                            </li>
                            <li >
                                <a rel="nofollow" href="#"><i class="glyphicon glyphicon-th-large"></i> 众筹项目</a>
                            </li>
                            <li>
                                <a rel="nofollow" href="#"><i class="glyphicon glyphicon-edit"></i> 发起众筹</a>
                            </li>
                            <li>
                                <a rel="nofollow" href="#"><i class="glyphicon glyphicon-user"></i> 我的众筹</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>

    <%--项目简介--%>
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div class="jumbotron nofollow" style="    padding-top: 10px;">
                    <h3>
                        ${potalProject.name}
                    </h3>
                    <div style="float:left;width:70%;">
                        项目简介：${potalProject.remark}
                    </div>
                    <div style="float:right;">
                        <button type="button" class="btn btn-default"><i style="color:#f60" class="glyphicon glyphicon-heart"></i> 关注人数 ${potalProject.follower}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--项目图片及具体数据--%>
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div class="row clearfix">

                    <%--项目图片--%>
                    <div class="col-md-8 column">
                        <%--<img alt="140x140" width="740" src="${APP_PATH}/img/product_detail_head.jpg" />--%>
                        <img alt="140x140" width="740" src="http://47.95.223.197/test/pic/${potalProject.filename}" />
                    </div>

                    <%--右侧信息栏--%>
                    <div class="col-md-4 column">

                        <%--众筹项目信息--%>
                        <div class="panel panel-default" style="border-radius: 0px;">

                            <%--众筹状态--%>
                            <div class="panel-heading" style="background-color: #fff;border-color: #fff;">
                                <span class="label label-success"><i class="glyphicon glyphicon-tag"></i> 众筹中</span>
                            </div>

                            <%--当前众筹信息--%>
                            <div class="panel-body">
                                <h3 >
                                    已筹资金：${potalProject.raiseMoney}
                                </h3>
                                <p><span>目标金额 ： ${potalProject.money}</span><span style="float:right;">达成 ： ${potalProject.completion}%</span></p>
                                <div class="progress" style="height:10px; margin-bottom: 5px;">
                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${potalProject.completion}%;"></div>
                                </div>
                                <p>剩余时间${potalProject.createdate}</p>
                                <div>
                                    <p><span>已有${potalProject.supporter}人支持该项目</span></p>
                                </div>
                            </div>

                            <%--发起众筹方介绍--%>
                            <div class="panel-footer" style="    background-color: #fff;
                                    border-top: 1px solid #ddd;
                                    border-bottom-right-radius: 0px;
                                    border-bottom-left-radius: 0px;">
                                <div class="container-fluid">
                                    <div class="row clearfix">
                                        <div class="col-md-3 column" style="padding:0;">
                                            <img alt="140x140" src="${APP_PATH}/img/services-box2.jpg" data-holder-rendered="true" style="width: 80px; height: 80px;">
                                        </div>
                                        <div class="col-md-9 column">
                                            <div class="">

                                                <c:choose>
                                                    <c:when test="${member.authstatus eq '0'}">
                                                        <h4>
                                                            <b>发起者：${member.realname}</b> <span style="float:right;font-size:12px;" class="label label-success">未认证</span>
                                                        </h4>
                                                    </c:when>
                                                    <c:when test="${member.authstatus eq '1'}">
                                                        <h4>
                                                            <b>发起者：${member.realname}</b> <span style="float:right;font-size:12px;" class="label label-success">认证中</span>
                                                        </h4>
                                                    </c:when>
                                                    <c:when test="${member.authstatus eq '2'}">
                                                        <h4>
                                                            <b>发起者：${member.realname}</b> <span style="float:right;font-size:12px;" class="label label-success">已认证</span>
                                                        </h4>

                                                    </c:when>
                                                </c:choose>


                                                <p style="font-size:12px">
                                                    简介：${member.introduction}

                                                </p>
                                                <p style="font-size:12px">
                                                    联系电话：${member.tel}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <%--支持详情1--%>
                        <div class="panel panel-default" style="border-radius: 0px;">
                            <div class="panel-heading">
                                <h3 >
                                    支持所需金额： ￥${potalProject.supportNeedMoney}
                                </h3>
                            </div>
                            <div class="panel-body">
                                <p>配送费用：${potalProject.express}</p>
                                <p>预计发放时间：项目筹款成功后的50天内</p>
                                <button onclick="toReport()" type="button" class="btn  btn-info btn-lg btn-block" >立即支持</button>
                                <br>
                                <p>感谢您的支持，在项目筹款成功后，您将获得由发起方提供的一份神秘大礼包。</p>
                            </div>
                        </div>

                        <%--&lt;%&ndash;支持详情2&ndash;%&gt;
                        <div class="panel panel-default" style="border-radius: 0px;">
                            <div class="panel-heading">
                                <h3 >
                                    ￥149.00 <span style="float:right;font-size:12px;">限额2000位，剩余1966位</span>
                                </h3>
                            </div>
                            <div class="panel-body">
                                <p>配送费用：包邮</p>
                                <p>预计发放时间：项目筹款成功后的50天内</p>
                                <button type="button" class="btn  btn-warning btn-lg" onclick="window.location.href='pay-step-1.html'">支持</button>
                                <br><br>
                                <p>感谢您的支持，在众筹开始后，您将以79元的优惠价格获得“遇见彩虹?”智能插座一件（参考价208元）。</p>
                            </div>
                        </div>--%>

                        <%--风险提示--%>
                        <div class=" panel panel-default" style="border-radius: 0px;">
                            <div class="panel-heading">
                                <h3 >
                                    风险提示
                                </h3>
                            </div>
                            <div class="panel-body">
                                <p>1.众筹并非商品交易，存在一定风险。支持者根据自己的判断选择、支持众筹项目，与发起人共同实现梦想并获得发起人承诺的回报。<br>
                                    2.众筹平台仅提供平台网络空间及技术支持等中介服务，众筹仅存在于发起人和支持者之间，使用众筹平台产生的法律后果由发起人与支持者自行承担。<br>
                                    3.本项目必须在2017-06-09之前达到￥10000.00 的目标才算成功，否则已经支持的订单将取消。订单取消或募集失败的，您支持的金额将原支付路径退回。<br>
                                    4.请在支持项目后15分钟内付款，否则您的支持请求会被自动关闭。<br>
                                    5.众筹成功后由发起人统一进行发货，售后服务由发起人统一提供；如果发生发起人无法发放回报、延迟发放回报、不提供回报后续服务等情况，您需要直接和发起人协商解决。<br>
                                    6.如您不同意上述风险提示内容，您有权选择不支持；一旦选择支持，视为您已确认并同意以上提示内容。</p>
                            </div>
                        </div>

                        <%--为你推荐--%>
                        <%--<div><h2>为你推荐</h2><hr></div>
                        <div class="prjtip panel panel-default" style="border-radius: 0px;">
                            <div class="panel-body">
                                <img src="${APP_PATH}/img/product-3.png" width="100%" height="100%">
                            </div>
                        </div>
                        <div class="prjtip panel panel-default" style="border-radius: 0px;">
                            <div class="panel-body">
                                <img src="${APP_PATH}/img/product-4.jpg" width="100%" height="100%">
                            </div>
                        </div>--%>

                    </div>

                </div>
            </div>
        </div>
    </div>

</div>

<%--点击立即支持之后弹出的生态框--%>
<%--
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
    <div class="modal-dialog "  style="width:960px;height:400px;" role="document">
        <div class="modal-content" data-spy="scroll" data-target="#myScrollspy">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">选择支持项</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row clearfix">
                        <div class="col-sm-3 col-md-3 column" id="myScrollspy">
                            <ul class="nav nav-tabs nav-stacked">
                                <li class="active"><a href="#section-1">￥1.00</a></li>
                                <li class="active"><a href="#section-2">￥149.00</a></li>
                                <li class="active"><a href="#section-3">￥249.00</a></li>
                                <li class="active"><a href="#section-4">￥549.00</a></li>
                                <li class="active"><a href="#section-5">￥1999.00</a></li>
                            </ul>
                        </div>
                        <div id="navList" class="col-sm-9 col-md-9 column" style="height:400px;overflow-y:auto;">
                            <h2 id="section-1" style="border-bottom:1px dashed #ddd;" ><span style="font-size:20px;font-weight:bold;">￥1.00</span><span style="font-size:12px;margin-left:60px;">无限额，223位支持者</span></h2>
                            <p>配送费用：全国包邮</p>
                            <p>预计发放时间：项目筹款成功后的30天内</p>
                            <button type="button" class="btn  btn-warning btn-lg " onclick="window.location.href='pay-step-1.html'">支持</button>
                            <br><br>
                            <p>每满1750人抽取一台活性富氢净水直饮机，至少抽取一台。抽取名额（小数点后一位四舍五入）=参与人数÷1750人，由苏宁官方抽取。</p>
                            <hr>
                            <h2 id="section-2" style="border-bottom:1px dashed #ddd;" ><span style="font-size:20px;font-weight:bold;">￥149.00</span><span style="font-size:12px;margin-left:60px;">无限额，223位支持者</span></h2>
                            <p>配送费用：全国包邮</p>
                            <p>预计发放时间：项目筹款成功后的30天内</p>
                            <button type="button" class="btn  btn-warning btn-lg " onclick="window.location.href='pay-step-1.html'">支持</button>
                            <br><br>
                            <p>每满1750人抽取一台活性富氢净水直饮机，至少抽取一台。抽取名额（小数点后一位四舍五入）=参与人数÷1750人，由苏宁官方抽取。</p>
                            <hr>
                            <h2 id="section-3" style="border-bottom:1px dashed #ddd;" ><span style="font-size:20px;font-weight:bold;">￥249.00</span><span style="font-size:12px;margin-left:60px;">无限额，223位支持者</span></h2>
                            <p>配送费用：全国包邮</p>
                            <p>预计发放时间：项目筹款成功后的30天内</p>
                            <button type="button" class="btn  btn-warning btn-lg " onclick="window.location.href='pay-step-1.html'">支持</button>
                            <br><br>
                            <p>每满1750人抽取一台活性富氢净水直饮机，至少抽取一台。抽取名额（小数点后一位四舍五入）=参与人数÷1750人，由苏宁官方抽取。</p>
                            <hr>
                            <h2 id="section-4" style="border-bottom:1px dashed #ddd;" ><span style="font-size:20px;font-weight:bold;">￥549.00</span><span style="font-size:12px;margin-left:60px;">无限额，223位支持者</span></h2>
                            <p>配送费用：全国包邮</p>
                            <p>预计发放时间：项目筹款成功后的30天内</p>
                            <button type="button" class="btn  btn-warning btn-lg " onclick="window.location.href='pay-step-1.html'">支持</button>
                            <br><br>
                            <p>每满1750人抽取一台活性富氢净水直饮机，至少抽取一台。抽取名额（小数点后一位四舍五入）=参与人数÷1750人，由苏宁官方抽取。</p>
                            <hr>
                            <h2 id="section-5" style="border-bottom:1px dashed #ddd;" ><span style="font-size:20px;font-weight:bold;">￥1999.00</span><span style="font-size:12px;margin-left:60px;">无限额，223位支持者</span></h2>
                            <p>配送费用：全国包邮</p>
                            <p>预计发放时间：项目筹款成功后的30天内</p>
                            <button type="button" class="btn  btn-warning btn-lg " onclick="window.location.href='pay-step-1.html'">支持</button>
                            <br><br>
                            <p>每满1750人抽取一台活性富氢净水直饮机，至少抽取一台。抽取名额（小数点后一位四舍五入）=参与人数÷1750人，由苏宁官方抽取。</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
--%>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/back-to-top.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script>
    $(".prjtip img").css("cursor", "pointer");
    $(".prjtip img").click(function(){
        window.location.href = '#';
    });
</script>

<%--去到确认回报页面--%>
<script>
    function toReport() {
        $.ajax({
            type : "POST",
            url : "${APP_PATH}/potalProject/checkMemberLoginStatus.do",
            beforeSend : function () {
                return true;
            },
            success : function (result) {
                if (result.success){
                    window.location.href="${APP_PATH}/potalProject/toReport.htm?id=${potalProject.id}&memberid=${member.id}";
                } else {
                    //查询数据失败
                    layer.msg("您可能还没有登录，请先登录");
                }
            },
            error : function () {
                layer.msg("您可能还没有登录，请先登录");
            }
        });
    }
</script>


</body>
</html>

















