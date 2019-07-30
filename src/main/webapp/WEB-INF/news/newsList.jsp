<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html style="font-size: 65.4px;" data-dpr="2">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新闻</title>
    <meta name="format-detection" content="telephone=no">
    <meta name="description" content="新闻">
    <meta name="pathname" content="usergrowth_mobile_list">
    <link href="${ctx}/static/css/newsList.css" rel="stylesheet">
    <meta name="viewport" content="initial-scale=0.5, maximum-scale=0.5, minimum-scale=0.5, user-scalable=no">
    <style type="text/css">
        .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container{position:fixed;top:50%;display:inline-block;right:15px;z-index:1400}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container{right:30px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container{right:45px}.FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .qzHOK{width:75px}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .qzHOK{width:150px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .qzHOK{width:225px}.FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .CtYYQcwfJPPkx{position:absolute;top:-8px;right:0;width:20px}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .CtYYQcwfJPPkx{top:-16px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .CtYYQcwfJPPkx{top:-24px}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .CtYYQcwfJPPkx{width:40px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .icon-container .CtYYQcwfJPPkx{width:60px}.FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{width:40px;height:32px;background:url(${ctx}/static/img/popup_banner_close.png) no-repeat 50%;background-size:17px;position:absolute;left:0;top:0;opacity:.7}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{width:80px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{width:120px}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{height:64px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{height:96px}[data-dpr="2"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{background-size:34px}[data-dpr="3"] .FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus-close{background-size:51px}.FFNxqpFxUxiDdymXEjtDDWVHAgR .xkpjpgEPnSSMngdYsNOnofza,.FFNxqpFxUxiDdymXEjtDDWVHAgR .aOFygqEbuytNXZfEgrB{position:fixed;width:8.65625rem;height:11.5625rem;top:50%;left:50%;-webkit-transform:translate(-50%,-50%);-moz-transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%);transform:translate(-50%,-50%);z-index:1400}.FFNxqpFxUxiDdymXEjtDDWVHAgR .aOFygqEbuytNXZfEgrB{background:url(${ctx}/static/img/wap_bonus.png) no-repeat 50%;background-size:cover}.FFNxqpFxUxiDdymXEjtDDWVHAgR .xkpjpgEPnSSMngdYsNOnofza{background:url(${ctx}/static/img/wap_bonus.png) no-repeat 50%;background-size:cover}.FFNxqpFxUxiDdymXEjtDDWVHAgR .bonus{display:block}.FFNxqpFxUxiDdymXEjtDDWVHAgR .mask{display:block;position:absolute;width:100%;height:100%;z-index:1000;left:0;top:0;background:rgba(0,0,0,.3)}
    </style>
    <style>
        a,blockquote,body,button,code,dd,div,dl,dt,em,fieldset,form,h1,h2,h3,h4,h5,h6,html,iframe,img,input,label,li,object,ol,p,q,small,span,strong,table,tbody,td,th,tr,ul{margin:0;padding:0;border:0}#yAHtmvYEDPgIJBVjSFrHqDusYc{font-family:STHeiti,Microsoft YaHei,Helvetica,Arial,sans-serif;-webkit-text-size-adjust:none;word-break:break-word;width:100%;height:50px;z-index:5000}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc{height:100px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc{height:150px}#yAHtmvYEDPgIJBVjSFrHqDusYc.banner-top{position:relative}#yAHtmvYEDPgIJBVjSFrHqDusYc.daQeXzyzojGItFscgbZw{position:fixed;bottom:0}#yAHtmvYEDPgIJBVjSFrHqDusYc .qAMEUBFqomEywjw{position:fixed;width:100%;height:50px;background:rgba(0,0,0,.7);background-repeat:no-repeat;background-position:bottom;background-size:100% 100%;color:#fff}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .qAMEUBFqomEywjw{height:100px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .qAMEUBFqomEywjw{height:150px}#yAHtmvYEDPgIJBVjSFrHqDusYc .pannel-top{top:0}#yAHtmvYEDPgIJBVjSFrHqDusYc .PcBESWpTqhZZVqg{bottom:0}#yAHtmvYEDPgIJBVjSFrHqDusYc .show-top-pannel{-webkit-transform:translateY(0);transform:translateY(0);-webkit-transition:all .5s cubic-bezier(.19,1,.22,1);transition:all .5s cubic-bezier(.19,1,.22,1)}#yAHtmvYEDPgIJBVjSFrHqDusYc .hide-top-pannel{-webkit-transform:translateY(-100%);transform:translateY(-100%);-webkit-transition:all .3s cubic-bezier(.55,.055,.675,.19);transition:all .3s cubic-bezier(.55,.055,.675,.19)}#yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label,#yAHtmvYEDPgIJBVjSFrHqDusYc .close,#yAHtmvYEDPgIJBVjSFrHqDusYc .logo,#yAHtmvYEDPgIJBVjSFrHqDusYc .open{position:absolute;top:50%;-webkit-transform:translateY(-50%);transform:translateY(-50%)}#yAHtmvYEDPgIJBVjSFrHqDusYc .logo{height:30px;width:30px;left:15px;background:url(${ctx}/static/img/banner_toutiao_icon.png) no-repeat;overflow:hidden;background-size:30px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{height:60px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{height:90px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{width:60px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{width:90px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{left:30px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{left:45px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{background-size:60px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo{background-size:90px}#yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{height:20px;background:hsla(0,0%,100%,.6);width:0;margin-top:10px;margin-left:10px;-webkit-animation-delay:3s;-webkit-box-shadow:0 0 20px 4px #fff;-webkit-transform:rotate(15deg);-webkit-animation:ani-mask 1s;-webkit-animation-fill-mode:forwards;-webkit-animation-iteration-count:infinite}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{height:40px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{height:60px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{margin-top:20px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{margin-top:30px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{margin-left:20px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .logo .mask{margin-left:30px}.mask{display:none}#yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label{left:50px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label{left:100px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label{left:150px}#yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label p{color:#fff;font-size:12px;line-height:15px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label p{font-size:24px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label p{font-size:36px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label p{line-height:30px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label p{line-height:45px}#yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label .tb{font-size:15px;padding-bottom:3px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label .tb{font-size:30px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label .tb{font-size:45px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label .tb{padding-bottom:6px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .banner-label .tb{padding-bottom:9px}#yAHtmvYEDPgIJBVjSFrHqDusYc .close{height:40px;width:20px;padding:5px;position:absolute;right:0;background:url(${ctx}/static/img/banner_ic_close.png) no-repeat 50%;background-size:14px;top:50%;-webkit-transform:translateY(-50%);transform:translateY(-50%)}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{height:80px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{height:120px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{width:40px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{width:60px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{padding:10px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{padding:15px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{background-size:28px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .close{background-size:42px}#yAHtmvYEDPgIJBVjSFrHqDusYc .open{right:40px;width:60px;font-size:13px;line-height:30px;padding:0 10px;border-radius:6px;background:#ff424b;display:inline-block;color:#fff;text-align:center}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{right:80px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{right:120px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{width:120px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{width:180px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{font-size:26px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{font-size:39px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{line-height:60px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{line-height:90px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{padding:0 20px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{padding:0 30px}[data-dpr="2"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{border-radius:12px}[data-dpr="3"] #yAHtmvYEDPgIJBVjSFrHqDusYc .open{border-radius:18px}#yAHtmvYEDPgIJBVjSFrHqDusYc,#yAHtmvYEDPgIJBVjSFrHqDusYc *,#yAHtmvYEDPgIJBVjSFrHqDusYc:after,#yAHtmvYEDPgIJBVjSFrHqDusYc :after,#yAHtmvYEDPgIJBVjSFrHqDusYc:before,#yAHtmvYEDPgIJBVjSFrHqDusYc :before{box-sizing:content-box}
    </style>
    <style>
        a,blockquote,body,button,code,dd,div,dl,dt,em,fieldset,form,h1,h2,h3,h4,h5,h6,html,iframe,img,input,label,li,object,ol,p,q,small,span,strong,table,tbody,td,th,tr,ul{margin:0;padding:0;border:0}#VgDnSORTiVmaQwAzbjij{font-family:STHeiti,Microsoft YaHei,Helvetica,Arial,sans-serif;-webkit-text-size-adjust:none;word-break:break-word;width:100%;height:50px;z-index:5000}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij{height:100px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij{height:150px}#VgDnSORTiVmaQwAzbjij.AyfkXNpdyfZLQNd{position:relative}#VgDnSORTiVmaQwAzbjij.banner-bottom{position:fixed;bottom:0}#VgDnSORTiVmaQwAzbjij .ezlsreMNXvywAoSg{position:fixed;width:100%;height:50px;background:rgba(0,0,0,.7);background-repeat:no-repeat;background-position:bottom;background-size:100% 100%;color:#fff}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .ezlsreMNXvywAoSg{height:100px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .ezlsreMNXvywAoSg{height:150px}#VgDnSORTiVmaQwAzbjij .YIDCyrAaXXJDuQN{top:0}#VgDnSORTiVmaQwAzbjij .pannel-bottom{bottom:0}#VgDnSORTiVmaQwAzbjij .oPCr{-webkit-transform:translateY(0);transform:translateY(0);-webkit-transition:all .5s cubic-bezier(.19,1,.22,1);transition:all .5s cubic-bezier(.19,1,.22,1)}#VgDnSORTiVmaQwAzbjij .SiVCYzyqzLOgxy{-webkit-transform:translateY(-100%);transform:translateY(-100%);-webkit-transition:all .3s cubic-bezier(.55,.055,.675,.19);transition:all .3s cubic-bezier(.55,.055,.675,.19)}#VgDnSORTiVmaQwAzbjij .banner-label,#VgDnSORTiVmaQwAzbjij .close,#VgDnSORTiVmaQwAzbjij .logo,#VgDnSORTiVmaQwAzbjij .open{position:absolute;top:50%;-webkit-transform:translateY(-50%);transform:translateY(-50%)}#VgDnSORTiVmaQwAzbjij .logo{height:30px;width:30px;left:15px;background:url(${ctx}/static/img/banner_toutiao_icon.png) no-repeat;overflow:hidden;background-size:30px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo{height:60px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo{height:90px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo{width:60px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo{width:90px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo{left:30px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo{left:45px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo{background-size:60px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo{background-size:90px}#VgDnSORTiVmaQwAzbjij .logo .mask{height:20px;background:hsla(0,0%,100%,.6);width:0;margin-top:10px;margin-left:10px;-webkit-animation-delay:3s;-webkit-box-shadow:0 0 20px 4px #fff;-webkit-transform:rotate(15deg);-webkit-animation:ani-mask 1s;-webkit-animation-fill-mode:forwards;-webkit-animation-iteration-count:infinite}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo .mask{height:40px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo .mask{height:60px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo .mask{margin-top:20px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo .mask{margin-top:30px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .logo .mask{margin-left:20px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .logo .mask{margin-left:30px}.mask{display:none}#VgDnSORTiVmaQwAzbjij .banner-label{left:50px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .banner-label{left:100px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .banner-label{left:150px}#VgDnSORTiVmaQwAzbjij .banner-label p{color:#fff;font-size:12px;line-height:15px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .banner-label p{font-size:24px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .banner-label p{font-size:36px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .banner-label p{line-height:30px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .banner-label p{line-height:45px}#VgDnSORTiVmaQwAzbjij .banner-label .tb{font-size:15px;padding-bottom:3px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .banner-label .tb{font-size:30px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .banner-label .tb{font-size:45px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .banner-label .tb{padding-bottom:6px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .banner-label .tb{padding-bottom:9px}#VgDnSORTiVmaQwAzbjij .close{height:40px;width:20px;padding:5px;position:absolute;right:0;background:url(${ctx}/static/img/banner_ic_close.png) no-repeat 50%;background-size:14px;top:50%;-webkit-transform:translateY(-50%);transform:translateY(-50%)}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .close{height:80px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .close{height:120px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .close{width:40px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .close{width:60px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .close{padding:10px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .close{padding:15px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .close{background-size:28px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .close{background-size:42px}#VgDnSORTiVmaQwAzbjij .open{right:40px;width:60px;font-size:13px;line-height:30px;padding:0 10px;border-radius:6px;background:#ff424b;display:inline-block;color:#fff;text-align:center}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .open{right:80px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .open{right:120px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .open{width:120px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .open{width:180px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .open{font-size:26px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .open{font-size:39px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .open{line-height:60px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .open{line-height:90px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .open{padding:0 20px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .open{padding:0 30px}[data-dpr="2"] #VgDnSORTiVmaQwAzbjij .open{border-radius:12px}[data-dpr="3"] #VgDnSORTiVmaQwAzbjij .open{border-radius:18px}#VgDnSORTiVmaQwAzbjij,#VgDnSORTiVmaQwAzbjij *,#VgDnSORTiVmaQwAzbjij:after,#VgDnSORTiVmaQwAzbjij :after,#VgDnSORTiVmaQwAzbjij:before,#VgDnSORTiVmaQwAzbjij :before{box-sizing:content-box}
    </style>
</head>
<body class="None android withHeader article utms-None utmm-None utmc-None list-page" style="font-size: 12px;">

<div style="display:none">
    <input type="hidden" name="csrfmiddlewaretoken" value="c6c767ed7687c2979e16561e09709c3a">
</div>
<div id="main">
    <div data-reactroot="" id="indexContainer" class="indexContainer withHeader ">
        <header id="indexHeader">
            <div class="top_bar">
                <div class="abs_m">
                    <a href="https://m.toutiao.com/#" class="refresh_title btn"></a><a href="https://m.toutiao.com/#" class="refresh_btn btn"></a>
                </div>
            </div>
            <div class="top_menu_bar">
                <div id="top_menu" class="top_menu_list">

                    <span class="btn cur" onclick="changeSign(this)" value="1">推荐</span>&nbsp;&nbsp;
                    <span class="btn" onclick="changeSign(this)" value="2">热点</span>&nbsp;&nbsp;
                    <span class="btn" onclick="changeSign(this)" value="3">娱乐</span>&nbsp;&nbsp;
                    <span class="btn" onclick="changeSign(this)" value="4">科技</span>&nbsp;&nbsp;
                    <span class="btn" onclick="changeSign(this)" value="5">探索</span>&nbsp;&nbsp;
                    <span class="btn" onclick="changeSign(this)" value="6">趣闻</span>&nbsp;&nbsp;
                    <span class="btn" onclick="changeSign(this)" value="7">历史</span>

                </div>
            </div>
        </header><span></span>
        <div>
            <content id="pageletListContent" class="feed-list-container"><!-- react-empty: 31 -->
                <div class="list_content" data-pull-fresh="1">

                    <span id="newsList"></span>

                </div>
                <div class="list_bottom">
                    <section class="loadmoretip"><a href="https://m.toutiao.com/#">加载中...</a></section>
                </div>
            </content>
        </div>
        <!-- react-empty: 40 --><!-- react-empty: 41 -->
    </div>
</div>
</body>
<script src="${ctx}/static/js/jquery.js"></script>
<script type="text/javascript">
    var path = "${ctx}";
</script>
<script type="text/javascript">

    /**
     * 页面进来初始化页面
     * 1推荐变红
     * 2加载推荐数据
     */
    $(document).ready(function(){
        var btnList = $('.btn');
        btnList[0].style.color = "red";
        loadData(1,1);
    })

    /**
     * 点击分类标签
     */
    function changeSign(btn) {
        //改变标签颜色
        var btnList = $('.btn');
        for(var i = 0; i < btnList.length; i++){
            btnList[i].style.color = "black";
        }
        btn.style.color = "red";

        //加载新数据
        loadData(btn,1);
    }

    function loadData(btn,currentPage) {
        //加载新数据
        $.ajax({
            url: path + "/news/loadData",
            data:{
                "sign" : btn,
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
                        //0无图新闻 1单图 2三图
                        if (news.type == 1){
                            html += '<section class="middle_mode has_action" data-hot-time="1493815884" data-group-id="6415726313801695490" data-item-id="6415732492795380225" data-format="0">';
                            html += '<a href="article.html" data-action-label="click_headline" data-tag="news_society" class="article_link clearfix ">';
                            html += '<div class="item_detail desc">';
                            html += '<h3 class="dotdot line3 image-margin-right">'+news.title+'</h3>';
                            html += '<div class="item_info">';
                            html += '<div>';
                            html += '<span class="src space">中国青年网</span>';
                            html += '<span class="cmt space"></span>';
                            html += '<span data-id="6415726313801695490" class="dislike-news fr mid-space"></span>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '<div class="list_img_holder">';
                            html += '<img src="'+news.url+'">';
                            html += '</div>';
                            html += '</a>';
                            html += '</section>';

                        } else if(news.type == 2){
                            html += '<section class="has_action" data-hot-time="1493815434" data-group-id="6415696164972134658" data-item-id="6415816425910305282" data-format="0">';
                            html += '<a href="article.html" data-action-label="click_headline" data-tag="news_entertainment" class="article_link clearfix ">';
                            html += '<div class="item_detail">';
                            html += '<h3 class="dotdot line3">'+news.title+'</h3>';
                            html += '<div class="list_image">';
                            html += '<ul class="clearfix">';
                            html += '<li class="list_img_holder"><img src="'+news.url+'"></li>';
                            html += '<li class="list_img_holder"><img src="'+news.url+'"></li>';
                            html += '<li class="list_img_holder"><img src="'+news.url+'"></li>';
                            html += '</ul>';
                            html += '</div>';
                            html += '<div class="item_info">';
                            html += '<div>';
                            html += '<span class="src space">果酱音乐</span><span class="cmt space"></span>';
                            html += '<span class="time" title="2017-05-03 20:43">18分钟前</span>';
                            html += '<span data-id="6415696164972134658" class="dislike-news fr"></span>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                            html += '</a>';
                            html += '</section>';

                        }else{

                        }

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

</html>