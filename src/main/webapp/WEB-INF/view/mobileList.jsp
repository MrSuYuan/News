<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>


<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>新闻列表</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm.min.css">
    <link rel="stylesheet" href="//g.alicdn.com/msui/sm/0.6.2/css/sm-extend.min.css">

</head>
<body>

<div class="page-group">
    <!-- 你的html代码 -->
    <div class="page">
        <header class="bar bar-nav">
            <h1 class="title">
                <span class="sign" onclick="changeSign(this)" value="1">推荐</span>&nbsp;&nbsp;
                <span class="sign" onclick="changeSign(this)" value="2">热点</span>&nbsp;&nbsp;
                <span class="sign" onclick="changeSign(this)" value="3">娱乐</span>&nbsp;&nbsp;
                <span class="sign" onclick="changeSign(this)" value="4">科技</span>&nbsp;&nbsp;
                <span class="sign" onclick="changeSign(this)" value="5">探索</span>&nbsp;&nbsp;
                <span class="sign" onclick="changeSign(this)" value="6">趣闻</span>&nbsp;&nbsp;
                <span class="sign" onclick="changeSign(this)" value="7">历史</span>
            </h1>
        </header>

        <div class="content">
            <!-- 这里是页面内容区 -->
            <div class="page-index">

                    <a href="${ctx}/mobileDetail?newsId=1" target="_blank" style="color:black">
                        <div class="card">
                            <div style="width: 100%;height: 70px;margin-bottom:10px;"><font size="8"><strong>标题</strong></font></div>
                            <div style="width: 100%;height: 260px;margin-bottom:10px;">
                                    <img class="img list-li-img" style="width: 33%;height: 220px" src="http://img.cashslide.cn/app/hippo/20190722/1775961e5a8727f7be7f653cfce613c86506596e.jpeg">
                                    <img class="img list-li-img" style="width: 33%;height: 220px" src="http://img.cashslide.cn/app/hippo/20190722/1775961e5a8727f7be7f653cfce613c86506596e.jpeg">
                                    <img class="img list-li-img" style="width: 33%;height: 220px" src="http://img.cashslide.cn/app/hippo/20190722/1775961e5a8727f7be7f653cfce613c86506596e.jpeg">
                            </div>
                            <div style="width: 100%;height: 50px"><font size="5">2018</font></div>
                        </div>
                    </a>

                <div class="card">
                    <div style="background-image:url(//gqianniu.alicdn.com/bao/uploaded/i4//tfscom/i3/TB10LfcHFXXXXXKXpXXXXXXXXXX_!!0-item_pic.jpg_250x250q60.jpg)" valign="bottom" class="card-header color-white no-border">旅途的山</div>
                    <div class="card-content">
                        <div class="card-content-inner">
                            <p class="color-gray">发表于 2015/01/15</p>
                            <p>此处是内容...</p>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="#" class="link">赞</a>
                        <a href="#" class="link">更多</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script src="${ctx}/static/js/jquery.js"></script>
<script type='text/javascript'>

    /**
     * 页面进来初始化页面
     * 1推荐变红
     * 2加载推荐数据
     */
    $(document).ready(function(){
        var signList = $('.sign');
        signList[0].style.color = "red";
    })

    function changeSign(sign) {
        alert(sign.innerText);
        var signList = $('.sign');
        for(var i = 0; i < signList.length; i++){
            signList[i].style.color = "black";
        }
        sign.style.color = "red";

    }

</script>
</body>
</html>

