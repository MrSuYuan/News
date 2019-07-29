<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta id="viewport" content="width=device-width, user-scalable=yes,initial-scale=1" name="viewport" />
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <link rel="stylesheet" href="${ctx}/static/css/style.css"/>
    <link rel="stylesheet" href="${ctx}/static/css/mobileList.css"/>
    <link rel="stylesheet" href="${ctx}/static/css/templet.css"/>
    <title>新闻详情</title>
</head>
<style>

</style>
<body nid="1" total="5" cate="7">
<input type="hidden" id="page" value="1">
<div class="pc-detail-wrap">
    <!---->
    <div style="position: fixed;width: 100%;height: 80px" class="header-wrap">
        <div class="nav-main">
            <a href="" class="logo">
                <img src="${ctx}/static/img/logo.png" style="margin-top: 15px" height="80" width="140">
            </a>
            <ul class="nav-ul">
                <li class="nav-ul-li active" cate="1" style="margin-top: 15px"><span><font size="6">推荐</font></span></li>
                <li class="nav-ul-li" cate="2" style="margin-top: 15px"><span><font size="6">热点</font></span></li>
                <li class="nav-ul-li" cate="3" style="margin-top: 15px"><span><font size="6">娱乐</font></span></li>
                <li class="nav-ul-li" cate="4" style="margin-top: 15px"><span><font size="6">科技</font></span></li>
                <li class="nav-ul-li" cate="5" style="margin-top: 15px"><span><font size="6">探索</font></span></li>
                <li class="nav-ul-li" cate="6" style="margin-top: 15px"><span><font size="6">趣闻</font></span></li>
                <li class="nav-ul-li" cate="7" style="margin-top: 15px"><span><font size="6">历史</font></span></li>
            </ul>
        </div>
    </div>

    <!--中间新闻列表-->
    <div class="content">
        <c:forEach items="${index}" var="i">
            <a href="${ctx}/news/mobileDetail?newsId=${i.newsId}" target="_blank" style="color:black">
            <c:if test="${i.type == 2}">
                <div style="width: 100%;height: 400px;margin-bottom:10px;">
                    <div style="width: 100%;height: 70px;margin-bottom:10px;"><font size="8"><strong>${i.title}</strong></font></div>
                    <div style="width: 100%;height: 260px;margin-bottom:10px;">
                        <c:forEach items="${i.pictureUrl}" var="l">
                            <img class="img list-li-img" style="width: 33%;height: 220px" src="${l}">
                        </c:forEach>
                    </div>
                    <div style="width: 100%;height: 50px"><font size="5">${i.author}</font></div>
                </div>
            </c:if>

            <c:if test="${i.type == 1}">
                <div style="width: 100%;height: 400px;margin-bottom:10px;">
                    <div style="width: 33%;height: 400px;display:inline;float:left">
                        <img class="img list-li-img" style="width: 100%;height: 350px;margin-top: 20px" src="${i.pictureUrl[0]}">
                    </div>
                    <div style="width: 65%;height: 400px;display:inline;float:right;margin-left: 1%">
                        <div style="width: 100%;height: 350px;margin-top: 10px"><font size="8"><strong>${i.title}</strong></font></div>
                        <div style="width: 100%;height: 50px;margin-bottom: 30px"><font size="5">${i.author}</font></div>
                    </div>
                </div>
            </c:if>
            <hr style="height:1px;border:none;border-top:1px solid #555555;" >
            </a>
        </c:forEach>
    </div>
    <div class="data-cue tc beforeload">上滑加载更多</div>
    <div class="data-cue tc allclose" style="display:none;">已经全部加载了</div>
    <div class="data-cue-loading tc data-cue loading" style="display:none;"><span
            class="loading-span"></span> &nbsp;&nbsp;&nbsp;&nbsp;加载中</div>

</div>
</body>
    <script src="${ctx}/static/js/jquery.js"></script>
    <script src="${ctx}/static/js/scrollLoading.js"></script>
    <script src="${ctx}/static/js/mobileList2.js"></script>
    <script>

        var path = "${ctx}";
        /*var screenHeught = window.screen.height;
        window.onscroll = function () {
            alert(screenHeught);
            alert(document.body.scrollTop);
            alert(document.body.scrollHeight);
            if(screenHeught + document.body.scrollTop >= document.body.scrollHeight){
                alert("加载新数据");
            }
        }*/

       /* $(function(){
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
        });*/
    </script>

</html>