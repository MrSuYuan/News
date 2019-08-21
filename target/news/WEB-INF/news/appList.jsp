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

        <div>
            <div class="list-block media-list">
                <ul>
                    <span id="newsList"></span>
                    <%--<li>
                        <a href="#" class="item-link item-content">
                            <div class="item-media"><img src="http://gqianniu.alicdn.com/bao/uploaded/i4//tfscom/i3/TB10LfcHFXXXXXKXpXXXXXXXXXX_!!0-item_pic.jpg_250x250q60.jpg" style='width: 4rem;'></div>
                            <div class="item-inner">
                                <div class="item-title-row">
                                    <div class="item-title">标题</div>
                                </div>
                                <div class="item-subtitle">标题</div>
                                <div class="item-text">此处是文本内容...</div>
                            </div>
                        </a>
                    </li>--%>
                </ul>
            </div>
        </div>
    </div>
</div>

<script type='text/javascript' src='//g.alicdn.com/sj/lib/zepto/zepto.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm.min.js' charset='utf-8'></script>
<script type='text/javascript' src='//g.alicdn.com/msui/sm/0.6.2/js/sm-extend.min.js' charset='utf-8'></script>
<script src="${ctx}/static/js/jquery.js"></script>
<script type="text/javascript">
    var path = "${ctx}";
</script>
<script type='text/javascript'>

    /**
     * 页面进来初始化页面
     * 1推荐变红
     * 2加载推荐数据
     */
    $(document).ready(function(){
        var signList = $('.sign');
        signList[0].style.color = "red";
        loadData(1,1);
    })

    /**
     * 点击分类标签
     */
    function changeSign(sign) {
        //改变标签颜色
        var signList = $('.sign');
        for(var i = 0; i < signList.length; i++){
            signList[i].style.color = "black";
        }
        sign.style.color = "red";

        //加载新数据
        loadData(sign,1);
    }

    function loadData(sign,currentPage) {
        //加载新数据
        $.ajax({
            url: path + "/news/loadData",
            data:{
                "sign" : sign,
                "currentPage" : currentPage
            },
            type: "post",
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.code == 200){

                    var list = data.result;
                    var html = "";
                    for(var i=0;i<list.length;i++){
                        var news = list[i];
                        html += '<li>';
                        html += '<a href="#" class="item-link item-content">';
                        html += '<div class="item-media"><img src="'+news.url+'" style="width: 4rem;"></div>';
                        html += '<div class="item-inner">';
                        html += '<div class="item-title-row">';
                        html += '<div class="item-title">'+news.title+'</div>';
                        html += '</div>';
                        html += '<div class="item-subtitle">标题</div>';
                        html += '<div class="item-text">此处是文本内容...</div>';
                        html += '</div>';
                        html += '</a>';
                        html += '</li>';
                    }
                    $('#newsList').html(html);

                }else{
                    alert(data.message);
                }

            },
            error: function () {
                alert("Error");
            }
        });
    }

</script>
</body>
</html>

