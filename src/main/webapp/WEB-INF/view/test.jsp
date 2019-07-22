<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no" name="viewport">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="format-detection" content="email=no">
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <meta name="author" content="jeams">
    <title></title>
    <link rel="shortcut icon" href="//img.cashslide.cn/hip-h5/images/32x32-2.png">
    <link rel="stylesheet" href="//img.cashslide.cn/hip-h5/css/common.min.css?v=19.4.4">
    <link rel="stylesheet" href="//img.cashslide.cn/hip-h5/t12/css/page.min.css?v=19.1.31">
    <link rel="stylesheet" href="//img.cashslide.cn/hip-h5/t12/css/index.css?v=19.6.19">
    <link rel="stylesheet" href="//img.cashslide.cn/hip-h5/css/page_subscribe.min.css">
    <link rel="stylesheet" href="//img.cashslide.cn/hip-h5/t12/css/free.css?v=19.1.11.2">
    <script src="//img.cashslide.cn/hip-h5/js/jquery.min.js"></script>
    <script src="//img.cashslide.cn/hip-h5/js/jquery-ui.min.js"></script>
    <script src="//img.cashslide.cn/hip-h5/js/jquery.ui.touch-punch.js"></script>
    <style>nav .swiper-slide.active,
.menu-more .add {
/*-----------频道栏字体高亮颜色1------------*/
color: #d43d3d;
opacity: 0.7;
}
header .top-title ,
.top-search{
background-color: #d43d3d;
/*-----------模板颜色2------------*/
}
.top-search .search-input .btn-search{
color: #ffffff;
}
.search-wrap .search-input .btn-search,
.search-wrap p span{
color: #d43d3d;
}
.svg {
position: absolute;
top: 1.4rem;
left: 50%;
z-index: 99;
display: block;
width: 40px;
height: 40px;
margin-left: -20px;
opacity: 0;
opacity: 0;
border-radius: 50%;
background-color: #fff
}

.svg.active {
animation: myrotate 1s infinite ease-in-out;
}

@keyframes myrotate {
0% {
transform: rotate(0)
}

100% {
transform: rotate(360deg)
}
}</style><script type="text/javascript" src="https://s5.cnzz.com/z_stat.php?id=1275901886&web_id=1275901886"></script></head><script>var isMade=(""=="true")?true:false; //定制化模板显示加载更多
var isFirst=false; //false第一次加载
var flag = false; //为true则展示js广告;
var list_ad_1 = "http://m.jingjingtoutiao.com/ad/list?id=1&media=237&submedia=346"; //百度js广告1
var list_ad_2 = "http://m.jingjingtoutiao.com/ad/list?id=2&media=237&submedia=346"; //百度js广告2
var welfare_src = "//m.cudaojia.com?appKey=7f796390933e44718e308897c4904814&appType=h5&appEntrance=36&business=money";//福利地址
var video_mark = "//img.cashslide.cn/hip-h5/images/video.png"; //视频标识图片
var ads_img = "//img.cashslide.cn/hip-h5/images/wap_ads.png"; //广告图标
var bgimg = "//img.cashslide.cn/hip-h5/images/bgimg.png"; //懒加载之前图片
var playimg = "//img.cashslide.cn/hip-h5/images/play.png"; //懒加载之前图片
var loading_img = "//img.cashslide.cn/hip-h5/images/loading6.png"; //正在加载转圈的图片
var history_back_url = "http://m.jingjingtoutiao.com/bd/backm?u="; //百度详情页返回监测
//var list_path="/bd/news/list?page=";//列表信息流
//var cat_path="/bd/news/cat?";//频道栏
//var cat_list_path="/bd/news/cat_list?";//频道页
var offsetDown=""; //下滑offset参数
var offsetUp=""; //下拉offset参数
var list_path = "/bd/news/list?"; //列表信息流
var cat_path = "/bd/news/cat?"; //频道栏
var cat_list_path = "/bd/news/cat_list?"; //频道页
var cat_list_save_path="/bd/news/cat_list_save?";
var cat_list_del_path="/bd/news/cat_list_del?";
var category = "时尚";//当前频道
var host = "http://m.jingjingtoutiao.com";
// host="//test.yuexinwen.cn";
var arr_cat=[];
var rd = Math.random();
var dt_flag=true;//全局flag,数据加载完成flag才能回置到ture;
var pageNum=1;
var pages = 1; //当头部的频道的分类栏不存在时pages;
if(window.location.href.indexOf('isFirst')>=0){
pageNum=2;
pages=2;
}
var repage=-1;//当头部的频道的分类栏不存在时刷新repage;
var onoff = true; //是否进入处理请求返回的数据的状态;
var is_refresh = true; //是否开始刷新
var bonus_url="";//红包跳转地址
var bonus_cnzz='';
var bonus_material ='';
var bonus_source_of_ad ='';
var bigfont="";
var media="237";
var submedia="346",
t=("12").replace(/&|;|\$|\(|\)|#/g,''),
os=("").replace(/&|;|\$|\(|\)|#/g,''),
osv= ("").replace(/&|;|\$|\(|\)|#/g,''),
idfa= ("").replace(/&|;|\$|\(|\)|#/g,''),
imei= ("").replace(/&|;|\$|\(|\)|#/g,''),
anid= ("").replace(/&|;|\$|\(|\)|#/g,''),
mac= ("").replace(/&|;|\$|\(|\)|#/g,''),
make= ("").replace(/&|;|\$|\(|\)|#/g,''),
model= ("").replace(/&|;|\$|\(|\)|#/g,''),
sw= ("").replace(/&|;|\$|\(|\)|#/g,''),
sh= ("").replace(/&|;|\$|\(|\)|#/g,''),
devicetype= ("").replace(/&|;|\$|\(|\)|#/g,''),
ip= ("221.216.139.64").replace(/&|;|\$|\(|\)|#/g,''),
conn= ("").replace(/&|;|\$|\(|\)|#/g,''),
carrier= ("").replace(/&|;|\$|\(|\)|#/g,''),
cat_type=("").replace(/&|;|\$|\(|\)|#/g,''),
cat_custom=("").replace(/&|;|\$|\(|\)|#/g,''),
voffset="";
var home_path="/bd/news/home?";
var home_args={
media: media,
submedia: submedia,
category: category,
t: t,
os: os,
osv: osv,
idfa: idfa,
imei: imei,
anid: anid,
mac: mac,
make: make,
model: model,
sw: sw,
sh: sh,
devicetype: devicetype,
ip: ip,
conn: conn,
carrier: carrier,
r: rd,
};
var news_list_args = { //内容参数(有频道栏)
media: media,
submedia: submedia,
category: category,
t: t,
os: os,
osv: osv,
idfa: idfa,
imei: imei,
anid: anid,
mac: mac,
make: make,
model: model,
sw: sw,
sh: sh,
devicetype: devicetype,
ip: ip,
conn: conn,
carrier: carrier,
// callback: "initContent", /////
offset:"",
page:pageNum,
r: rd,
voffset:voffset,
};
var cat_list_save_args = { //保存频道(有频道栏)
media: media,
submedia: submedia,
category: category,
t: t,
os: os,
osv: osv,
idfa: idfa,
imei: imei,
anid: anid,
mac: mac,
make: make,
model: model,
sw: sw,
sh: sh,
devicetype: devicetype,
ip: ip,
conn: conn,
carrier: carrier,
cat_type: cat_type,
cat_custom: cat_custom,
r: rd,
};
var news_list_args2 = { //无分类栏,不同字段callback(无频道栏)
media: media,
submedia: submedia,
category: category,
t: t,
os: os,
osv: osv,
idfa: idfa,
imei: imei,
anid: anid,
mac: mac,
make: make,
model: model,
sw: sw,
sh: sh,
devicetype: devicetype,
ip: ip,
conn: conn,
carrier: carrier,
// callback: "initContent2", ////////
r: rd,
offset:"",
page:pageNum,
voffset:voffset,
};
var cat_list_args = { //分类列表参数
media: media,
submedia: submedia,
category: category,
t: t,
os: os,
osv: osv,
idfa: idfa,
imei: imei,
anid: anid,
mac: mac,
make: make,
model: model,
sw: sw,
sh: sh,
devicetype: devicetype,
ip: ip,
conn: conn,
carrier: carrier,
cat_type: cat_type,
cat_custom: cat_custom,
callback: "initMune1",
r: rd,
};
var onoff_channel = true; //控制频道页是否为初次点击
var top_bar_fixed="1";
//互动广告位置 info:详情页 list:列表页 all:全部</script><script src="//img.cashslide.cn/hip-h5/t12/js/data.js?v=19.6.26"></script><script>var isNeedChannel=true; //true有频道栏，false无频道栏
if(GetQueryString('isFirst')||!isMade){
isFirst=true
}
if(!isFirst&&isMade){
location.href='http://m.jingjingtoutiao.com/bd/views/t12/custom.html?media=237&submedia=346&category=时尚&host=http://m.jingjingtoutiao.com';
}
$(function() {

isNeedChannel=true;
$('#J_news_list').refresh({ //下拉刷新
pullFunction: function(ms, callback) {
setTimeout(function() {
dt_flag=false;
$("#J_news_list .cats").each(function(i, e) {
if($(e).css("display") == "block") {
var n = $(this).attr("repage");
news_list_args.page=n;
news_list_args.category=$(".swiper-slide.active").html();
news_list_args.offset=offsetUp;
news_list_args.voffset=voffset;
getNewsListData(host + list_path,news_list_args,false,"initContent")
n--;
$(e).attr({"repage": n,"page":(n+1),"scroll":0});

}
})
callback();

}, ms)
},
})
toptitle();


$('title').html('新闻列表');


//频道(分类)加载
var cat_list_api = host + cat_list_path + wrap_args(cat_list_args);

addscript(cat_list_api);
$("#J_content").scroll(scrollList);


backtop() //回到顶部
set_height();
// if(bigfont=="true"){
// $('.news-item h3').css('font-size','20px');
// }
var bannerAd=null;
if(bannerAd!=null){
loadAdhomeBannerGg(bannerAd);
}
var img_bottom_banner_js=null;//美图底部悬浮
if(bannerAd==null&&img_bottom_banner_js!=""){
loadAdhomeBannerGg(img_bottom_banner_js);
}
if(top_bar_fixed=="0"){
$("#J_content").scroll(function(){
var scrollTop=$(this).scrollTop();
$('header').css({'top':'-'+scrollTop+'px'});
});
}

})</script><body><header><nav><section class="clearfix"><div class="top-menu nav-tab swiper-wrapper"></div></section><div class="menu-more" onclick="into_channel_click()"><div class="list-shadow"></div><a class="add">+</a></div></nav></header><div id="channel"><a id="href_true" style="display: none;"></a><div class="content"><p class="type-title type-title-1 clearfix"><span class="goback" onclick="goback()"><i class="goback_icon">&laquo;</i> 返回</span></p><a href="" class="back" target="_self"></a><div class="self-channel-wrap clearfix"><div class="self-channel-line clearfix"><span class="self-channel" style="float:left;line-height:0.6rem;font-size:0.26rem;padding:0 10px;">我的频道</span>
<span class="self-drag" style="float:left;line-height:0.6rem;font-size:0.2rem; color:#949090;">点击删除 拖动排序</span>
<button style="float:right;line-height:0.35rem;padding:0 5px;font-size:0.26rem;border:1px solid #e45e5e;border-radius:5px;color:#e45e5e;margin:0.15rem 0.2rem 0 0.2rem"
        onclick="save_my_channel()">保存
</button>
<button style="float:right;line-height:0.35rem;padding:0 5px;font-size:0.26rem;border:1px solid #e45e5e;border-radius:5px;color:#e45e5e;margin:0.15rem 0.2rem 0 0.2rem"
        onclick="reset_channel()">重置
</button>
</div><ul id="J_up_list" class="up-list clearfix gridly"></ul></div></div></div><div id="J_content" class="news-list"><div class="frsh-info">已为你更新<span class="count"></span>条新闻</div><div id="J_news_list" class="news-list-wrap"></div></div><div id="bannerAd"></div> </body></html>