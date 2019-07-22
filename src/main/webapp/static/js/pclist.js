var pageCount = 1,cate='index',nid='';
var finish=true;//控制只加载一次

$(document).ready(function(){
    $('.more-li').removeClass('active');
    $('#typespan').text("推荐");
    cate="1";
    getTypeNews();
});

//导航栏的点击按钮
$('.nav-ul-li').click(function(){
    $('#page').val("1")
    if(!$(this).hasClass('nav-ul-li-more')){
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
        $('.nav-ul-li-more .lispan').text('更多');
        $('.more-li').removeClass('active');
        $('#typespan').text($(this).text());
        cate=$(this).attr("cate");
        getTypeNews();
    }
});
//更多
$('.nav-ul').on('click','.more-li',function(){
    $('.nav-ul-li').removeClass('active');
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
    var temp='更多·'+$(this).text();
    $('.nav-ul-li-more .lispan').text(temp);
    cate=$(this).attr("cate");
    getTypeNews();
    $('#typespan').text($(this).text());
    if(!$('.nav-ul-li-more').hasClass('active')){
        $('.nav-ul-li-more').addClass('active');
    }
});
$('.nav-ul-li-more').hover(function (){
    $(".more-wrap").show();
},function (){
    $(".more-wrap").hide();
});

/*$(function() {
    //获取热门新闻
    getHotNewsList();
    nid=$('body').attr('nid');
    if(nid){
        getNewsList2();
        getServer();
        cate=$('body').attr('cate');
    }else{
        if(request('cate')){
            cate=request('cate');

        }
        getNewsList();
    }
    if(cate) {
        $('.nav-ul-li').removeClass('active');
        $('.nav-ul-li').each(function () {
            if ($(this).attr('cate') == cate) {
                $(this).addClass('active');
                $('.more-li').removeClass('active');
                $('#typespan').text($(this).text());
                return false;
            }
        });
        $('.more-li').each(function () {
            if ($(this).attr('cate') == cate) {
                $(this).addClass('active');
                var temp = '更多·' + $(this).text();
                $('.nav-ul-li-more .lispan').text(temp);
                $('.nav-ul-li-more').addClass('active');
                return false;
            }
        });
    }
});*/

function getTypeNews(){
    if(nid){
        var temp='/?cate='+cate;
        window.open(temp);
    }else{
        $(document).scrollTop(0);
        $('.content-main-ul').empty();
        getNewsList();

    }
}
function getNewsList(){
    var page = parseInt($('#page').val());
    $('.beforeload').hide();
    $('.loading').show();
    $.ajax({
        url: path + "/indexMore",
        type: "post",
        data: {
            "page" : page,
            "cate" : cate
        },
        dataType: 'json',
        async: false,
        success: function(result){
			// var result=JSON.parse(data);
            if(result.code == 200){
                setNewsList(result);
                $('#page').val(page + 1);
            }else{
                alert(result.msg);
                $('.loading').hide();
            }
        },
        error:function(){
            alert('网络错误,请您稍后重试');
            $('.loading').hide();
        }
    });
}
/*function getNewsList2(){
    $('.beforeload').hide();
    $('.loading').show();
    $.ajax({
        type: "get",
        // url : '/index/api/more',
        url : '../static/phonelist.json',
        data:{"page":page,"limit":10,"nid":nid},
        success: function(result){
			// var result=JSON.parse(data);

            if(result.res == 1){
                setNewsList(result);
            }else{

                $('.loading').hide();
            }
        },
        error:function(){
            alert('网络错误,请您稍后重试');
            $('.loading').hide();
        }
    });
}*/
function setNewsList(temp){
    finish=true;
    $('.loading').hide();
    var newsList=temp.result;
    if(newsList.length == 0){
        alert("没有更多数据了")
    }

    var str='',imgstr='',imgArr=[],catestr='',sourcestr='';
    for(i=0;i<newsList.length;i++){
        sourcestr = newsList[i].source;
        if(sourcestr == '头条'){
            sourcestr='新闻网';
        }

        var news = newsList[i];
        //三图
        if(news.type == 2){
            imgstr='';
            for(j=0;j<news.pictureUrl.length;j++){
                imgstr+='<div class="imgdiv"><img class="img list-li-img" src="'+news.pictureUrl[j]+'"/></div>';
            }
            str+='<li class="content-li content-li01">\n' +
                '                        <a class="" href='+path+'/detail?newsId='+news.newsId+' target="_blank">\n' +
                '                            <p class="title">'+news.title+'</p>\n' +
                '                            <div class="img-wrap clearfix">'+imgstr+'</div>\n' +
                '                            <div class="footer-source">'+news.author+'</span></div>\n' +
                '                        </a>\n' +
                '                    </li>'

        //单图
        }else if(news.type == 1){
            str+='<li class="content-li content-li02">\n' +
                '            <a class="" href='+path+'/detail?newsId='+news.newsId+' target="_blank">\n' +
                '                <div class="img-wrap clearfix"><div class="imgdiv">\n' +
                '                    <img class="img list-li-img" src="'+news.pictureUrl[0]+'"/>\n' +
                '                </div></div>\n' +
                '                <div class="content-li02-right">\n' +
                '                    <p class="title">'+news.title+'</p>\n' +
                '                    <div class="footer-source">'+news.author+'</span></div>\n' +
                '                </div>\n' +
                '            </a>\n' +
                '        </li>'

        //无图
        }else{

        }


    }
    $('.content-main-ul').append(str);
    $('.content-main-ul .list-li-img').scrollLoading();

}

$(window).scroll(function() {
    var tempHeight=$(document).height()-$(document).scrollTop()-$(window).height();

    if(parseInt(pageCount) < page){
        finish=false;
        $('.allclose').show();
    }
    if( tempHeight <= 150){ //小于150px时加载
        if(finish){
            finish=false;
            if(nid){
                getNewsList2();
            }else{
                getNewsList();
            }

        }
    }
});
//获取热门新闻
/*function getHotNewsList(){
    $.ajax({
        type: "get",
        url : '../static/phonelist.json',
        data:{"page":1,"limit":10,"cate":"hot"},
        success: function(data){
            //  var result=JSON.parse(data);

            if (data.res == 1){
                console.log(data);
                setHotNewsList(data);
            }else{
                alert(dta.msg);
                $('.loading').hide();
            }
        },
        error:function(){
            alert('网络错误,请您稍后重试');
            $('.loading').hide();
        }
    });
}*/
/*function setHotNewsList(temp){
    var tempdata=temp.data;
    var str='',imgstr='',imgArr=[];
    for(i=0;i<tempdata.length;i++){
        imgArr=tempdata[i].imgs;
        if(imgArr.length >= 1){
            str+='<li class="clearfix">\n' +
                '                        <a href="'+tempdata[i].href+'" target="_blank">\n' +
                '                            <div class="img-div">\n' +
                '                                <img src="'+tempdata[i].imgs[0]+'"/>\n' +
                '                            </div>\n' +
                '                            <div class="title-div">'+tempdata[i].title+'</div>\n' +
                '                        </a>\n' +
                '                    </li>'
        }
    }
    $('.hot-news-ul').html(str);
}*/

function request(paras) {
    var url = location.href;
    var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
    var paraObj = {};
    for (i = 0;i<paraString.length; i++) {
        j = paraString[i];
        paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
    }
    var returnValue = paraObj[paras.toLowerCase()];

    if (typeof(returnValue) == "undefined") {
        return '';
    } else {
        return decodeURIComponent(returnValue);
    }
}

function getServer() {
    var cid=$('body').attr('cid');
    $.ajax({
        type: "get",
        url : '/index/Pvuv/setV',
        data:{'nid':nid,"cid":cid},
        success: function(result){}
    });
}