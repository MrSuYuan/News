<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>收益统计</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <meta name="description" content="overview &amp; stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/fonts.googleapis.com.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-skins.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-rtl.min.css" />
    <script src="${ctx}/static/common/assets/js/ace-extra.min.js"></script>
</head>

<body class="no-skin">

<!-- 页面头部 -->
<div id="navbar" class="navbar navbar-default ace-save-state"></div>
<input type="hidden" id="userName" value="${sessionScope.nickName}"/>
<input type="hidden" id="currentUserLevel" value="${sessionScope.userLevel}"/>
<input type="hidden" id="currentUserId" value="${sessionScope.userId}"/>
<input type="hidden" id="ctx" value="${ctx}"/>
<div class="main-container ace-save-state" id="main-container">
    <script type="text/javascript">
        try{ace.settings.loadState('main-container')}catch(e){}
    </script>

    <!-- 左侧导航栏 -->
    <div id="sidebar" class="sidebar responsive ace-save-state"></div>

    <!-- 次头部 -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}/index">Home</a>
                    </li>
                    <li class="active">收益统计</li>
                </ul><!-- /.breadcrumb -->
                <div class="nav-search" id="nav-search">
                    <form class="form-search">
                            <span class="input-icon">
                                <input type="text" placeholder="敬请期待" class="nav-search-input" id="nav-search-input" autocomplete="off" />
                                <i class="ace-icon fa fa-search nav-search-icon"></i>
                            </span>
                    </form>
                </div><!-- /.nav-search -->
            </div>

            <!-- 页面主体部分 -->
            <div class="page-content">
                <form action="#" method="post">
                    <br>
                    <div align="center">
                        广告位名称：<input type="text" id="spaceName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        网站名称：<input type="text" id="webName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        日期：<input type="date" id="startTime" style="width:150px;height:30px">
                        - <input type="date" id="endTime" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn btn-primary btn-xs" onclick="webStatisticsManage($('#currentPage').val())">
                            <i class="ace-icon glyphicon glyphicon-search bigger-110"><font size="3">搜索</font></i>
                        </a>

                    </div>
                    <br>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="table-header"></div>
                            <div>
                                <table id="dynamic-table"
                                       class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr style="height: 50px">
                                        <th>广告位ID</th>
                                        <th>广告位名称</th>
                                        <th>网站名称</th>
                                        <th>日期</th>
                                        <th>展现(上)</th>
                                        <th>点击(上)</th>
                                        <th>收益(上)</th>
                                        <th>展现</th>
                                        <th>点击</th>
                                        <th>收益</th>
                                        <th>点击率</th>
                                        <th>ecpm</th>
                                        <th style="width: 80px">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="coll_list_begin_body">
                                    </tbody>
                                </table>
                            </div>
                            <!-- 页面设置 -->
                            <div class="modal-footer no-margin-top">
                                <div class="dataTables_paginate paging_simple_numbers">
                                    <ul class="pagination">
                                        <li>
                                            <a onclick="lastPageData()" title="上一页">
                                                <i class="ace-icon fa fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li class="active">
                                            <a title="当前页">
                                                <span id="currentPage"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a onclick="nextPageData()" title="下一页">
                                                <i class="ace-icon fa fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                        <li>
                                            <a>
                                                共&nbsp;<span id="sumPage"></span>&nbsp;页&nbsp;|&nbsp;
                                                共&nbsp;<span id="sumData"></span>&nbsp;条数据
                                            </a>
                                        </li>
                                        <li>
                                            <a>
                                                <span>页面容量</span>
                                            </a>
                                            <input type="text" id="pageSize" style="width: 33.44px;height: 32.4px">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                </form>

                <!-- 设置模态框 -->
                <div class="modal" id="web_divided_set" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <form class="form-horizontal" role="form">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">修改统计数据<input type="hidden" id="spaceId"><input type="hidden" id="statisticsId"></h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right "> 上游曝光 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="beforeLookPV" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> 上游点击 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="beforeClickNum" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> 上游收入 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="beforeIncome" disabled>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right "> X : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="upstreamDivided" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> Y : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="dividedY">
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> Z : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="dividedZ">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right "> 下游曝光 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="lookPV" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> 下游点击 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="clickNum" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> 下游收入 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="income" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> 下游点击率 : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="clickProbability" disabled>
                                            </div>
                                            <label class="col-sm-3 control-label no-padding-right "> 下游ecpm : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="ecmp" disabled>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    <button type="button" class="btn btn-primary" onclick="updateStatistics()">修改</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->

    <!-- 页面尾部 -->
    <div class="footer" id ="footer"></div>
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->

</body>

<script src="${ctx}/static/common/assets/js/jquery-2.1.4.min.js"></script>
<script src="${ctx}/static/manage/index/template.js"></script>
<script src="${ctx}/static/common/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-ui.custom.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.easypiechart.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.sparkline.index.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.pie.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.resize.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace.min.js"></script>
<script type="text/javascript">
    var path = "${ctx}";
</script>
<!-- 加载预加载部分,头部和左导航栏 -->
<script type="text/javascript">
    loading("webStatisticsManage", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        webStatisticsManage(1);
    });

    //点击搜索数据展示
    function webStatisticsManage(currentPage) {

        //var currentUserLevel = $('#currentUserLevel').val();
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/web/webStatisticsManage",
            type: "post",
            data: {
                "startTime" : $('#startTime').val(),
                "endTime" : $('#endTime').val(),
                "spaceName" : $('#spaceName').val(),
                "webName" : $('#webName').val(),
                "currentPage" : currentPage,
                "pageSize" : pageSize
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.statisticsList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px" id="tr'+data.statisticsId+'">';
                        html+='<td title="Y:'+data.dividedY+'&nbsp;,&nbsp;Z:'+data.dividedZ+'"> '+data.spaceId+'</td>';
                        html+='<td> '+data.spaceName+'</td>';
                        html+='<td> '+data.webName+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        html+='<td> '+format_number(data.beforeLookPV)+'</td>';
                        html+='<td> '+format_number(data.beforeClickNum)+'</td>';
                        html+='<td> '+data.beforeIncome+'</td>';
                        html+='<td> '+format_number(data.lookPV)+'</td>';
                        html+='<td> '+format_number(data.clickNum)+'</td>';
                        html+='<td> '+data.income+'</td>';
                        html+='<td> '+data.clickProbability+'%</td>';
                        html+='<td> '+data.ecmp+'</td>';
                        var status = data.status;
                        if (status == 0){
                            html+='<td id="td'+data.statisticsId+'"><button type="button" class="btn btn-minier btn-success" onclick="changeStatus('+data.statisticsId+')">通过</button>&nbsp;' +
                                '<button type="button" class="btn btn-minier btn-inverse" onclick="showStatistics('+data.statisticsId+')">修改</button></td>';
                        } else if (status == 1) {
                            html+='<td>已通过</td>';
                        }
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                    //更新页码
                    $('#currentPage').html(obj.result.currentPage);
                    $('#pageSize').val(obj.result.pageSize);
                    $('#sumPage').html(obj.result.sumPage);
                    $('#sumData').html(obj.result.sumData);
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.location = path + "/login";
                }else{
                    alert(obj.message);
                }

            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //上一页
    function lastPageData() {
        var page = parseInt($('#currentPage').html());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            webStatisticsManage(page);
        }
    }

    //下一页
    function nextPageData() {
        var page = parseInt($('#currentPage').html());
        var sumPage = parseInt($('#sumPage').text());
        if(page == sumPage){
            alert("当前是最后一页");
        }else{
            var page = page + 1;
            webStatisticsManage(page);
        }
    }

    //格式化数字
    function format_number(n) {
        var b = parseInt(n).toString();
        var len = b.length;
        if (len <= 3) { return b; }
        var r = len % 3;
        return r > 0 ? b.slice(0, r) + "," + b.slice(r, len).match(/\d{3}/g).join(",") : b.slice(r, len).match(/\d{3}/g).join(",");
    }

    //通过
    function changeStatus(statisticsId) {
        $.ajax({
            url: path + "/web/webStatisticsStatus",
            type: "post",
            data: {
                "statisticsId" : statisticsId,
                "status" : 1
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    $('#td'+statisticsId).empty();
                    $('#td'+statisticsId).html("已通过");
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.location = path + "/login";
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //模态框
    function showStatistics(statisticsId) {
        $("#web_divided_set").modal("show");
        //查询此条数据
        $.ajax({
            url: path + "/web/webStatisticsOne",
            type: "post",
            data: {
                "statisticsId" : statisticsId
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var data = obj.result;
                    $('#beforeLookPV').val(data.beforeLookPV);
                    $('#beforeClickNum').val(data.beforeClickNum);
                    $('#beforeIncome').val(data.beforeIncome);
                    $('#upstreamDivided').val(data.upstreamDivided);
                    $('#dividedY').val(data.dividedY);
                    $('#dividedZ').val(data.dividedZ);
                    $('#lookPV').val(data.lookPV);
                    $('#clickNum').val(data.clickNum);
                    $('#income').val(data.income);
                    $('#clickProbability').val(data.clickProbability);
                    $('#ecmp').val(data.ecmp);
                    $('#spaceId').val(data.spaceId);
                    $('#statisticsId').val(data.statisticsId);
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.location = path + "/login";
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //onchange
    $("#dividedY").change(function(){
        var dividedY = $("#dividedY").val();
        var dividedZ = $("#dividedZ").val();
        compute(dividedY,dividedZ);
    });
    $("#dividedZ").change(function(){
        var dividedY = $("#dividedY").val();
        var dividedZ = $("#dividedZ").val();
        compute(dividedY,dividedZ);
    });

    //计算
    function compute(dividedY,dividedZ) {

        var beforeLookPV = $('#beforeLookPV').val();
        var beforeClickNum = $('#beforeClickNum').val();
        var beforeIncome = $('#beforeIncome').val();
        var dividedX = $('#upstreamDivided').val();

        var lookPV = beforeLookPV * dividedZ;
        var clickNum = beforeClickNum * dividedZ;
        var income = beforeIncome * dividedX * dividedY * dividedZ;
        var clickProbability = clickNum * 100 / lookPV;
        var ecmp = income * 1000 / lookPV;

        $('#lookPV').val(lookPV.toFixed(0));
        $('#clickNum').val(clickNum.toFixed(0));
        $('#income').val(income.toFixed(2));
        $('#clickProbability').val(clickProbability.toFixed(2));
        $('#ecmp').val(ecmp.toFixed(2));
    }

    //修改
    function updateStatistics() {
        var dividedY = $("#dividedY").val();
        var dividedZ = $("#dividedZ").val();
        var lookPV = $('#lookPV').val();
        var clickNum = $('#clickNum').val();
        var income = $('#income').val();
        var clickProbability = $('#clickProbability').val();
        var ecmp = $('#ecmp').val();
        var spaceId = $('#spaceId').val();
        var statisticsId = $('#statisticsId').val();
        $.ajax({
            url: path + "/web/updateStatistics",
            type: "post",
            data: {
                "statisticsId" : statisticsId,
                "dividedY" : dividedY,
                "dividedZ" : dividedZ,
                "lookPV" : lookPV,
                "clickNum" : clickNum,
                "income" : income,
                "clickProbability" : clickProbability,
                "ecmp" : ecmp,
                "spaceId" : spaceId
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    $("#web_divided_set").modal("hide");
                    var page = parseInt($('#currentPage').text());
                    webStatisticsManage(page);
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.location = path + "/login";
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

</script>

</html>
