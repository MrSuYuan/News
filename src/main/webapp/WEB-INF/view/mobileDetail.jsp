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
    <div class="header-wrap" style="width: 100%;height: 80px">
        <div class="nav-main">
            <img src="${ctx}/static/img/logo.png" height="80" width="140">
        </div>
    </div>
    <!---->
    <div style="width: 90%;margin-left: 5%">

        <!---->
        <div>
            <div>
                <div>
                    <div style="font-size: 50px">头条新闻 > 正文</div>
                    <div style="font-size: 80px"><strong>${news.title}</strong></div>
                    <div style="font-size: 50px">${news.author}</div>
                    <div style="font-size: 50px">
                        ${news.content}
                    </div>
                    <div style="font-size: 50px"><strong>相关推荐</strong></div>
                    <div style="font-size: 50px">
                        <script zmua="d=m&s=b&u=u4213752&h=20:8" src="http://js.bjzghd.com/x.js"></script>
                        <script zmua="d=m&s=b&u=u4213752&h=20:8" src="http://js.bjzghd.com/x.js"></script>
                        <script zmua="d=m&s=b&u=u4213752&h=20:8" src="http://js.bjzghd.com/x.js"></script>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="${ctx}/static/js/jquery.js"></script>

</body>
</html>