<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <link rel="stylesheet" href="${ctx}/static/css/style.css"/>
    <link rel="stylesheet" href="${ctx}/static/css/templet.css"/>
    <title>新闻详情</title>
</head>
<body nid="1" total="5" cate="7">
<div class="pc-detail-wrap">
    <!---->
    <div class="header-wrap">
        <div class="nav-main">
            <a href="${ctx}/news/pcList" target="_self">
                <img src="${ctx}/static/img/logo.png" height="50" width="140">
            </a>
        </div>
    </div>
    <!---->
    <div class="pc-detail-main">
        <div class="right-wrap">
            <div class="hot-news"><span>实时热点</span></div>
            <div class="hot-news-wrap">
                <ul class="hot-news-ul">
                    <c:forEach items="${hotNews}" var="i">
                        <li class="clearfix">
                            <a href="${ctx}/news/newsDetail?newsId=${i.newsId}" target="_self">
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
            <div class="hot-news"><span> 相关推荐 </span></div>

            <script type="text/javascript">
                (function() {
                    var s = "_" + Math.random().toString(36).slice(2);
                    document.write('<div style="" id="' + s + '"></div>');
                    (window.slotbydup = window.slotbydup || []).push({
                        id: "u4768098",
                        container: s
                    });
                })();
            </script>
            <!-- 多条广告如下脚本只需引入一次 -->
            <script type="text/javascript" src="//cpro.baidustatic.com/cpro/ui/c.js" async="async" defer="defer" >
            </script>

            <%--<div class="hot-news-wrap">

            </div>--%>
        </div>
        <!---->
        <div class="pc-content-main">
            <div class="pc-content">
                <div class="centre-tip">头条新闻 > 正文<%--<span id="typespan">推荐</span>正文</div>--%>
                <div class="content-title">${news.title}</div>
                <div class="content-time">${news.author}</div>
                <p>
                    <%--
                    背负着过去的痛苦，夹杂着现实的烦恼，这对于人的心灵而言是无任何益处。时间是小偷，他来时悄无声息，走后损失惨重，机会也是如此。如果你能像看别人缺点一样，如此准确的发现自己的缺点，那么你的生命将会不平凡。据有关部门统计，截止到2017年底，中国的汽车持有量达到了3亿多辆，而拥有驾照的人数则高达4亿多人次，每年的寒暑假期间， 都是报名考驾照人数最多的时间段，一些高中毕业生以及大学在校生纷纷利用假期时间报名驾考，这在学校是很常见的事情了，然而自从明年开始，你的驾照就再也不是以前的驾照了！
                    --%>
                    ${news.content}
                </p>
            </div>

        </div>
    </div>
</div>
</div>
<script src="${ctx}/static/js/jquery.js"></script>
<script src="${ctx}/static/js/scrollLoading.js"></script>
<script src="${ctx}/static/js/pclist.js"></script>
<script>
    $(function(){
        var total=$('body').attr('total');
        var page,pagestr;
        var tempurl=window.location.href;
        var temphref=window.location.host+'?cate='+request('cate');
        var temphost = tempurl.substring(0,tempurl.indexOf("?") + 1)+"cate="+request('cate')+'&p=';
        request('p') ? page=request('p'):page=1;
        pagestr='';
        if(page > 1){
            pagestr+='<a href="'+temphost+(page-1)+'">上一页</a>'
        }
        if(total >= 1){

            total=parseInt(total);
            for(var i=1; i <= total; i++){
                if(i == page){
                    pagestr+='<a href="'+temphost+i+'" class="cur">'+i+'</a>';
                }else{
                    pagestr+='<a href="'+temphost+i+'">'+i+'</a>';
                }
            }
        }
        pagestr+='<a href="'+temphref+'" target="_blank">'+(total+1)+'</a><a href="'+temphref+'" target="_blank">下一页</a>';
        $('#pagination').html(pagestr);
    });
</script>
</body>
</html>