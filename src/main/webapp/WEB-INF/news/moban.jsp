<%--
  Created by IntelliJ IDEA.
  User: 机械革命
  Date: 2019/7/30
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<ul class="news">
    <li class="list list-right-img">
        <div class="left">
            <div class="new">
                <p class="title list-ellipsis-1">这是风水堪舆这是风水堪舆这是风水堪舆这是风水堪舆这是风水堪舆这是风水堪舆</p>
                <p class="content">堪舆术，即相地术，俗称风水术，它是一门历史悠久的玄术。属于占相阳宅（生人住宅）和阴宅（死者墓葬）的地形、环境、结构、坐向以测断吉凶休咎的方术。 堪舆术是对宅地或墓地的地脉、山形、水流及坐向的统称。术家认为，不论阳宅阴宅，风水的好坏，均关乎生人的吉凶休咎。现存最早出现“风水”一词的文献为旧题晋郭璞撰的《葬书》：“《经》云：‘气乘风则散，界水则止。’古人聚之使不散，行之使有止，故谓之‘风水’。</p>
            </div>
            <span class="time">2018-10-22</span>
        </div>
        <div class="right">
            <img src="image/frame0/11.jpg" alt="">
        </div>
    </li>
    <li class="list list-right-img">
        <div class="left">
            <div class="new">
                <p class="title list-ellipsis-1">这是风水堪舆</p>
                <p class="content">风水之法，得水为上，藏风次之。”后世术家兼作“堪舆”的代称，相宅、相墓之法，辨证研究风水，去其糟粕，取其精华，用科学合理的方法来解释风水现象，只可用于趋吉避凶，不可痴迷其中。</p>
            </div>
            <span class="time">2018-10-22</span>
        </div>
        <div class="right">
            <img src="image/frame0/12.jpg" alt="">
        </div>
    </li>
    <li class="list list-bottom-tri">
        <div class="top">
            <div class="title list-ellipsis-2">文章标题文章标题文章标题</div>
            <div class="img-wrap">
                <div class="list-col-xs-4"><img src="image/frame0/12.jpg" alt=""></div>
                <div class="list-col-xs-4"><img src="image/frame0/12.jpg" alt=""></div>
                <div class="list-col-xs-4"><img src="image/frame0/12.jpg" alt=""></div>
            </div>
        </div>
        <div class="info">
            <!-- <span class="info-r-5 list-ellipsis-1">崇道新闻崇道新闻崇道新闻崇道新闻崇道新闻崇道新闻</span>
            <span class="info-r-5">99评价</span> -->
            <span class="">2018-10-25 10:35</span>
        </div>
    </li>
    <li class="list list-no-img">
        <div class="top">
            <div class="title list-ellipsis-2">道教认为人死之后会发生什么？</div>
            <p class="content">
                崇道人：“早期的道其形骸，考其魂神。善者有赏， 可上升受天之衣食，恶者受罚，谪作河梁山海之鬼。崇道人：“早期的道其形骸，考其魂神。善者有赏， 可上升受天之衣食，恶者受罚，谪作河梁山海之鬼。
            </p>
        </div>
        <div class="info">
            <span class="">2018-10-25 10:35</span>
        </div>
    </li>
</ul>
</body>

<style>
    /* 新闻 */

    .news {
        background: #fff;
    }

    .news .list {
        display: flex;
        display: -webkit-flex;
        padding: 10px 5px 5px;
        margin: 0 15px;
        border-bottom: 1px solid #ddd;
    }

    .news .list:last-child {
        border: 0;
    }

    /* 无图纯文字模式 */
    .list-no-img {
        flex-direction: column;
    }
    .list-no-img .top .title {
        font-weight: bold;
        height: 30%;
        font-size: 14px;
    }
    .list-no-img .top .content {
        display: -webkit-box;
        overflow: hidden;
        text-overflow: ellipsis;
        -webkit-line-clamp: 4;
        -webkit-box-orient: vertical;
        line-height: 20px;
        font-size: 14px;
        margin-bottom: 5px;
        color: #666;
        margin: 5px 0;
    }

    .list-no-img .info {
        font-size: 10px;
        color: #bbb;
        display: flex;
    }
    .list-no-img .info .info-r-5 {
        margin-right: 5px;
    }
    .list-no-img .info .list-ellipsis-1 {
        max-width: 40%;
    }

    /* 无图纯文字模式结束 */


    /* 右图模式 */

    .list-right-img .left {
        width: 60%;
        display: flex;
        display: -webkit-flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .list-right-img .left .title {
        font-weight: bold;
        height: 30%;
        font-size: 14px;
    }

    .list-right-img .left .content {
        font-size: 12px;
        color: #888;
        margin: 5px 0;
        display: -webkit-box;
        overflow: hidden;
        text-overflow: ellipsis;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        line-height: 16px;
    }

    .list-right-img .left .time {
        font-size: 10px;
        color: #bbb;
    }

    .list-right-img .right {
        width: 40%;
        margin-left: 10px;
    }

    .list-right-img .right img {
        width: 100%;
        height: 80px;
    }

    /* 右图模式结束 */


    /* 下三图模式 */
    .list-bottom-tri {
        flex-direction: column;
    }
    .list-bottom-tri .title {
        font-weight: bold;
        height: 30%;
        font-size: 14px;
    }
    .list-bottom-tri .img-wrap {
        display: flex;
        margin: 5px 0;
    }
    .list-bottom-tri .img-wrap img{
        width: 100%;
        height: 80px;
    }
    .list-bottom-tri .info {
        font-size: 10px;
        color: #bbb;
        display: flex;
    }
    .list-bottom-tri .info .info-r-5 {
        margin-right: 5px;
    }
    .list-bottom-tri .info .list-ellipsis-1 {
        max-width: 40%;
    }
    /* 下三图模式结束 */

    /* 其他 */

    /* 单行省略 */
    .list-ellipsis-1 {
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

    /* 两行省略 */
    .list-ellipsis-2{
        display: -webkit-box;
        overflow: hidden;
        text-overflow: ellipsis;
        word-wrap: break-word;
        word-break: break-all;
        white-space: normal !important;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    /* 平分3个 */
    .list-col-xs-4 {
        width: 33.333%;
        padding: 0 2px;
    }

</style>

</html>
