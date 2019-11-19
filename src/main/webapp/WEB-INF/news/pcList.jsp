<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <link rel="stylesheet" href="${ctx}/static/news/css/style.css" />
    <link rel="stylesheet" href="${ctx}/static/news/css/templet.css?v=1" />
    <link rel="shortcut icon" href="${ctx}/static/news/img/favicon.ico" type="image/x-icon" />
    <title>新闻推荐</title>
</head>

<body>
<input type="hidden" id="page" value="1">
    <!---->
    <div class="header-wrap"></div>
    <div class="index-wrap">
        <div class="index-main clearfix">
            <!--左侧导航栏-->
            <div class="left-nav-wrap">
                <div class="left-nav-main ">
                    <ul class="nav-ul">
                        <a href="${ctx}/news/pcList" target="_self">
                            <img src="${ctx}/static/news/img/logo.png" height="50" width="140">
                        </a>
                        <li class="nav-ul-li active" cate="1">
                            <span class='nav-icon tuijian'></span>
                            <span class="lispan">推荐</span>
                        </li>
                        <li class="nav-ul-li" cate="2">
                            <span class='nav-icon junshi'></span>
                            <span class="lispan">热点</span>
                        </li>
                        <li class="nav-ul-li" cate="3">
                            <span class='nav-icon shehui'></span>
                            <span class="lispan">娱乐</span>
                        </li>
                        <li class="nav-ul-li" cate="4">
                            <span class='nav-icon qiche'></span>
                            <span class="lispan">科技</span>
                        </li>
                        <li class="nav-ul-li" cate="5">
                            <span class='nav-icon caijing'></span>
                            <span class="lispan">探索</span>
                        </li>
                        <li class="nav-ul-li" cate="6">
                            <span class='nav-icon jiankang'></span>
                            <span class="lispan">趣闻</span>
                        </li>
                        <li class="nav-ul-li" cate="7">
                            <span class='nav-icon jiankang'></span>
                            <span class="lispan">历史</span>
                        </li>
                    </ul>
                </div>
            </div>

            <!--中间新闻列表-->
            <div class="centre-wrap">
                <div class="centre-tip">头条新闻 > <span id="typespan">推荐</span></div>
                <div class="content-main">
                    <ul class="content-main-ul">

                    </ul>
                </div>
                <div class="data-cue tc beforeload">上滑加载更多</div>
                <div class="data-cue tc allclose" style="display:none;">已经全部加载了</div>
                <div class="data-cue-loading tc data-cue loading" style="display:none;"><span
                        class="loading-span"></span> &nbsp;&nbsp;&nbsp;&nbsp;加载中</div>

            </div>
            <!--右侧新闻列表-->
            <div class="right-wrap">
                <div class="hot-news"><span> 热门新闻 </span></div>
                <script type="text/javascript">
                    (function() {
                        var s = "_" + Math.random().toString(36).slice(2);
                        document.write('<div style="" id="' + s + '"></div>');
                        (window.slotbydup = window.slotbydup || []).push({
                            id: "u4768084",
                            container: s
                        });
                    })();
                </script>
                <!-- 多条广告如下脚本只需引入一次 -->
                <script type="text/javascript" src="//cpro.baidustatic.com/cpro/ui/c.js" async="async" defer="defer" >
                </script>
                <div class="hot-news-wrap">
                    <ul class="hot-news-ul">
                        <c:forEach items="${hotNews}" var="i">
                            <li class="clearfix">
                                <a href="${ctx}/news/newsDetail?newsId=${i.newsId}" target="_blank">
                                    <div class="img-div">
                                        <img src="${i.url}">
                                    </div>
                                    <div class="title-div">
                                        ${i.title}
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="right-wrap">
                <div class="hot-news"><span> 相关推荐啊 </span></div>

                <script type="text/javascript">
                    (function() {
                        var s = "_" + Math.random().toString(36).slice(2);
                        document.write('<div style="" id="' + s + '"></div>');
                        (window.slotbydup = window.slotbydup || []).push({
                            id: "u4649345",
                            container: s
                        });
                    })();
                </script>
                <!-- 多条广告如下脚本只需引入一次 -->
                <script type="text/javascript" src="//cpro.baidustatic.com/cpro/ui/c.js" async="async" defer="defer" >
                </script>

            </div>
        </div>
    </div>
    <script src="${ctx}/static/news/js/jquery.js"></script>
    <script src="${ctx}/static/news/js/scrollLoading.js"></script>
    <script src="${ctx}/static/news/js/pclist.js"></script>

<%--    <script>
        // console.log(document.body.clientHeight, $(window).height(), $(window).width());
        //$('.content-main-ul .list-li-img').scrollLoading();
    </script>--%>
    <script type="text/javascript">
        var path = "${ctx}";
    </script>
</body>

</html>