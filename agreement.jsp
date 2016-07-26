<%@ page import="org.omg.CORBA.Request" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/jsp/common/taglibs.jspf" %>
<!doctype html>
<html>
<head>
  <meta http-equiv="Content-Type" charset="UTF-8" />
  <meta http-equiv="Cache-Control" content="no-cache" />
  <title>项目详情</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0, minimal-ui"/>
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <meta name="format-detection" content="telephone=no" />
  <meta name="format-detection" content="email=no" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link href="${ctx}/static/h5/css/zdmoney.min.css" rel="stylesheet" type="text/css" />
  <style type="text/css">
    p,ul{ margin: 0; padding: 0;}
    em,i{ font-style: normal;}
    img{max-width:100%;}
    ul li{list-style: none;padding:0; margin:0;}
    .banner{line-height:0; font-size:0; overflow:hidden;}

    .page{background: #f2f2f2;}
    .left{float:left}
    .right{float:right;}
    .clear:after{content:'';clear:both;display:block;visibility: hidden;height:0px; width:0px;font-size:0px;}
    .clear{zoom:1}
    .toolbar{background:#ea3e4f !important;}
    .toolbar:before{background:none!important;}
    .toolbar .nowBuybtn{color: #fff; margin: 0 auto; width: 100%; height: 100%; text-align: center; line-height: 44px;}

    .productPage .proInfoBox{ border-bottom: 1px solid #d7d7d7;}
    .productPage .proInfoBox li:nth-child(odd){padding: 10px;background: #fff; height: 24px; line-height: 24px;}
    .productPage .proInfoBox li:nth-child(even){padding: 10px;background: #f8f8f8;height: 24px; line-height: 24px;}
    .productPage .proInfoBox .pIcon{display: inline-block; width: 25px; height: 25px; background:url(${ctx}/static/h5/images/picon.png) no-repeat;background-size:100% auto;}
    .productPage .proInfoBox .proNameIcon{background-position:0 0;}
    .productPage .proInfoBox .proRateIcon{background-position:0 -26px;}
    .productPage .proInfoBox .principalIcon{background-position:0 -52px;}
    .productPage .proInfoBox .featureIcon{background-position:0 -78px;}
    .productPage .proInfoBox .interestIcon{background-position:0 -104px;}
    .productPage .proInfoBox .repaymentIcon{background-position:0 -130px;}
    .productPage .proInfoBox .infoName{display: inline-block; vertical-align: 8px; color: #666; margin-left: 5px;}
    .productPage .proInfoBox .c222{ color: #222;}
    .productPage .proInfoBox .rightBox{display: inline-block; overflow: hidden; height: 24px; line-height: 24px; width: 70%; text-align: right;}
    .productPage .title{ padding: 10px; color: #222; min-height: 24px; line-height: 24px;}
    .productPage .content{background: #fff; border-top: 1px solid #d7d7d7;border-bottom: 1px solid #d7d7d7; padding: 10px; min-height: 24px; line-height: 24px; color: #666;}
    .productPage .showAgree{margin-top: 10px; margin-bottom: 10px; border-top: 1px solid #d7d7d7; border-bottom: 1px solid #d7d7d7; background: #fff; min-height: 24px; line-height: 24px; position: relative;}
    .productPage .arrow{display:inline-block; width:12px; height:20px;background:url(${ctx}/static/h5/images/arrow.png) no-repeat;background-size:100% auto; position: absolute; right: 10px; top:12px;}
    .productPage .showTxt{padding: 10px; color: #222;}

  </style>
</head>
<body>
<div class="views">
  <div class="view view-main">
    <div class="pages">
      <div class="page" data-page="index">
        <div class="page-content">
          <div class="productPage">
            <div class="proInfoBox">
              <ul>
                <li class="clear">
                  <span class="left"><i class="pIcon proNameIcon"></i><i class="infoName">产品名称</i></span>
                  <span class="right c222">${result.msgEx.infos.productName}</span>
                </li>
                <li class="clear">
                  <span class="left"><i class="pIcon proRateIcon"></i><i class="infoName">预期年化收益率</i></span>
                  <span class="right c222"><fmt:formatNumber value="${(result.msgEx.infos.yearRate-0.00049)}" pattern="#0.0%"/></span>
                </li>
                <li class="clear">
                  <span class="left"><i class="pIcon principalIcon"></i><i class="infoName">项目本金</i></span>
                  <span class="right c222"><fmt:formatNumber value="${result.msgEx.infos.productPrincipal}" type="currency" pattern="#,#00.00"/>元</span>
                </li>
                <li class="clear">
                  <span class="left"><i class="pIcon interestIcon"></i><i class="infoName">起息规则</i></span>
                  <span class="right c222 rightBox">${result.msgEx.infos.interestRule}</span>
                </li>
                <li class="clear">
                  <span class="left"><i class="pIcon repaymentIcon"></i><i class="infoName">还款方式</i></span>
                  <span class="right c222 rightBox">${result.msgEx.infos.repayType}</span>
                </li>
              </ul>
            </div>
            <div class="box">
              <p class="title">项目特点</p>
              <div class="content">
                <p>${result.msgEx.infos.productFeature}</p>
              </div>
            </div>
            <div class="box">
              <p class="title">产品介绍</p>
              <div class="content">
                ${result.msgEx.infos.productDesc}
              </div>
            </div>
            <div class="box">
              <p class="title">资金到账</p>
              <div class="content">
                ${result.msgEx.infos.fundArrivalDesc}
              </div>
            </div>
            <div class="box">
              <p class="title">风控措施</p>
              <div class="content">
                <p>${result.msgEx.infos.riskMeasures}</p>
              </div>
            </div>
            <div class="showAgree">
              <a href="${ctx}/commonDispatchRequest?method=500016&resultPage=front/picInfo&productId=<%=request.getParameter("productId")%>" class="external">
                <p class="showTxt">信息披露</p>
                <span class="arrow"></span>
              </a>
            </div>
            <div class="showAgree">
              <c:choose>
                <c:when test="${result.msgEx.infos.contractType=='LOAN' || result.msgEx.infos.contractType=='SUBJECT'}">
                  <a href="${ctx}/agreement?hasTrans=20" class="external">
                    <p class="showTxt">查看投资协议</p>
                    <span class="arrow"></span>
                  </a>
                </c:when>
                <c:otherwise>
                  <a href="${ctx}/agreement?hasTrans=10" class="external">
                    <p class="showTxt">查看投资协议</p>
                    <span class="arrow"></span>
                  </a>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>
<script type="text/javascript" src="${ctx}/static/h5/js/zdmoney.min.js"></script>
<script>
  window.$$ = window.Dom7;
  window.myApp=new Framework7({
    cache:false,
    fastClicks:false,
    pushState:true
  });
  window.mainView = myApp.addView('.view-main', {
    dynamicNavbar: true,
    domCache: true
  });
  console.info(${result});
</script>
</body>
</html>
