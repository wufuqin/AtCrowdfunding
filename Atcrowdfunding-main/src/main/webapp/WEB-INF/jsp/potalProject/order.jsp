<%--
  确认订单页面
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

        .label-type, .label-status, .label-order {
            background-color: #fff;
            color: #f60;
            padding : 5px;
            border: 1px #f60 solid;
        }
        #typeList  :not(:first-child) {
            margin-top:20px;
        }
        .label-txt {
            margin:10px 10px;
            border:1px solid #ddd;
            padding : 4px;
            font-size:14px;
        }
        .panel {
            border-radius:0;
        }

        .progress-bar-default {
            background-color: #ddd;
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

<div class="container theme-showcase" role="main">

    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div class="panel panel-default" >

                    <div class="panel-heading" style="text-align:center;">
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-2 column">
                                    <div class="progress" style="height:50px;border-radius:0;    position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">1. 确认回报内容</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>

                                <div class="col-md-2 column">
                                    <div class="progress" style="height:50px;border-radius:0;    position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">2. 确认收货地址</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>

                                <div class="col-md-2 column">
                                    <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">3. 确认订单</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(92, 184, 92, 1);
                                             border-top-color: rgba(92, 184, 92, 0);
                                             border-bottom-color: rgba(92, 184, 92, 0);
                                             border-right-color: rgba(92, 184, 92, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-2 column">
                                    <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">4. 付款</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-2 column">
                                    <div class="progress" style="height:50px;border-radius:0;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">5. 完成</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-body">
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            项目信息 <%--<a style="font-size:12px;" href="pay-step-1.html">修改数量</a>--%>
                                        </b>
                                    </blockquote>
                                </div>
                                <div class="col-md-12 column">
                                    <table class="table table-bordered" style="text-align:center;">
                                        <thead>
                                        <tr style="background-color:#ddd;">
                                            <td>项目名称</td>
                                            <td>发起人</td>
                                            <%--<td width="300">回报内容</td>--%>
                                            <td width="80">回报数量</td>
                                            <td>支持单价</td>
                                            <td>配送费用</td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>${potalProject.name}</td>
                                            <td>${companyMember.realname}</td>
                                            <td>1</td>
                                            <td style="color:#F60">￥ ${potalProject.supportNeedMoney}</td>
                                            <td>${potalProject.express}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            账单
                                        </b>
                                    </blockquote>
                                </div>

                                <%--<form style="margin-top:20px;padding-left: 20px" name=alipayment action="${APP_PATH}/alipay.trade.page.pay.jsp" method=post target="_blank">
                                    <div id="body1" class="show" name="divcontent">
                                        <dl class="content">
                                            <dt>商户订单号 ：</dt>
                                            <dd>
                                                <input disabled style="width: 480px" class="form-control" id="WIDout_trade_no" name="WIDout_trade_no" value="${orderId}" />
                                            </dd>
                                            <br>
                                            <dt>订单名称 ：</dt>
                                            <dd>
                                                <input disabled style="width: 480px" class="form-control" id="WIDsubject" name="WIDsubject" value="${potalProject.name}" />
                                            </dd>
                                            <br>
                                            <dt>付款金额 ：</dt>
                                            <dd>
                                                <input disabled style="width: 480px" class="form-control" id="WIDtotal_amount" name="WIDtotal_amount" value="${potalProject.supportNeedMoney}" />
                                            </dd>
                                            <br>
                                            <dt>商品描述：</dt>
                                            <dd>
                                                <input disabled style="width: 480px" class="form-control" id="WIDbody" name="WIDbody" value="${potalProject.remark}" />
                                            </dd>
                                            <br>

                                            <dd id="btn-dd">
                                                <span class="new-btn-login-sp">
                                                    <button type="submit" style="width: 480px" class="form-control btn-info">付 款</button>
                                                </span> <span style="color: red" class="note-help">如果您点击“付款”按钮，即表示您同意该次的执行操作。</span>
                                            </dd>
                                        </dl>
                                    </div>
                                </form>--%>

                                <form style="margin-top:20px;padding-left: 20px" name=alipayment action="${APP_PATH}/alipay.trade.page.pay.jsp" method=post target="_blank">
                                    <div id="body1" class="show" name="divcontent">
                                        <dl class="content">
                                            <dt>商户订单号 ：</dt>
                                            <dd>
                                                <input class="form-control" style="width: 500px" id="WIDout_trade_no" name="WIDout_trade_no" value="${orderId}" />
                                            </dd>
                                            <br>
                                            <dt>订单名称 ：</dt>
                                            <dd>
                                                <input class="form-control" style="width: 500px" id="WIDsubject" name="WIDsubject" value="${potalProject.name}" />
                                            </dd>
                                            <br>
                                            <dt>付款金额 ：</dt>
                                            <dd>
                                                <input class="form-control" style="width: 500px" id="WIDtotal_amount" name="WIDtotal_amount" value="${potalProject.supportNeedMoney}" />
                                            </dd>
                                            <br>
                                            <dt>商品描述：</dt>
                                            <dd>
                                                <input class="form-control" style="width: 500px" id="WIDbody" name="WIDbody" value="${potalProject.remark}" />
                                            </dd>
                                            <br>
                                            <dt></dt>
                                            <dd id="btn-dd">
                                                <span class="new-btn-login-sp">
                                                    <button type="submit" style="width: 500px" class="form-control btn-info">付 款</button>
                                                </span> <span style="color: red" class="note-help">如果您点击“付款”按钮，即表示您同意该次的执行操作。</span>
                                            </dd>
                                        </dl>
                                    </div>
                                </form>

                                <%--<div class="container">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <blockquote>
                                                <p >
                                                    <i class="glyphicon glyphicon-info-sign" style="color:#2a6496;"></i> 提示
                                                </p><br>
                                                <span style="font-size:12px;">1.众筹并非商品交易，存在一定风险。支持者根据自己的判断选择、支持众筹项目，与发起人共同实现梦想并获得发起人承诺的回报。<br>
                                                2.众筹平台仅提供平台网络空间及技术支持等中介服务，众筹仅存在于发起人和支持者之间，使用众筹平台产生的法律后果由发起人与支持者自行承担。<br>
                                                3.本项目必须在2017-06-04之前达到 ￥1000000.00 的目标才算成功，否则已经支持的订单将取消。订单取消或募集失败的，您支持的金额将原支付路径退回。<br>
                                                4.请在支持项目后15分钟内付款，否则您的支持请求会被自动关闭。<br>
                                                5.众筹成功后由发起人统一进行发货，售后服务由发起人统一提供；如果发生发起人无法发放回报、延迟发放回报、不提供回报后续服务等情况，您需要直接和发起人协商解决。<br>
                                                6.如您不同意上述风险提示内容，您有权选择不支持；一旦选择支持，视为您已确认并同意以上提示内容。</span>
                                            </blockquote>
                                        </div>
                                    </div>
                                </div>--%>
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
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script>

    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    });

</script>

</body>
</html>
