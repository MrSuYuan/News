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


function getTypeNews(){
    if(nid){
        var temp='/?cate='+cate;
        window.open(temp);
    }else{
        $(document).scrollTop(0);
        $('.content').empty();
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
            for(j=0;j<3;j++){
                imgstr+='<img class="img list-li-img" style="width: 33%;height: 220px" src="'+news.pictureUrl[j]+'">';
            }

            str+='<a href='+path+'/mobileDetail?newsId='+news.newsId+' target="_blank" style="color:black">'
                +'<div style="width: 100%;height: 400px;margin-bottom:10px;">'
                +'<div style="width: 100%;height: 70px;margin-bottom:10px;"><font size="8"><strong>'+news.title+'</strong></font></div>'
                +'<div style="width: 100%;height: 260px;margin-bottom:10px;">'
                +imgstr
                +'</div>'
                +'<div style="width: 100%;height: 50px"><font size="5">'+news.author+'</font></div>'
                +'</div>'
                +'<hr style="height:1px;border:none;border-top:1px solid #555555;" >'
                +'</a>'
            //单图

        }else if(news.type == 1){
            imgstr='<img class="img list-li-img" style="width: 100%;height: 350px;margin-top: 20px" src="'+news.pictureUrl[0]+'">';
            str+='<a href='+path+'/mobileDetail?newsId='+news.newsId+' target="_blank" style="color:black">'
                +'<div style="width: 100%;height: 400px;margin-bottom:10px;">'
                +'<div style="width: 33%;height: 400px;display:inline;float:left">'
                +imgstr
                +'</div>'
                +'<div style="width: 65%;height: 400px;display:inline;float:right;margin-left: 1%">'
                +'<div style="width: 100%;height: 350px;margin-top: 10px"><font size="8"><strong>'+news.title+'</strong></font></div>'
                +'<div style="width: 100%;height: 50px;margin-bottom: 30px"><font size="5">'+news.author+'</font></div>'
                +'</div>'
                +'</div>'
                +'<hr style="height:1px;border:none;border-top:1px solid #555555;" >'
                +'</a>'

            //无图
        }else{

        }


    }
    $('.content').append(str);
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