<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>上报统计</title>
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
                    <li class="active">上报统计</li>
                </ul><!-- /.breadcrumb -->
                <div class="nav-search" id="nav-search">
                    <span class="input-icon">
                        <input type="date" class="nav-search-input" onchange="checkForDate()" id="date"/>
                    </span>
                </div><!-- /.nav-search -->
            </div>

            <!-- 页面主体部分 -->
            <div class="page-content">

                <!-- app基本信息 -->
                <div>
                    <div id="user-profile-1" class="user-profile row">
                        <div class="col-xs-12 col-sm-9">
                            <div class="profile-user-info profile-user-info-striped">
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> APP信息 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="appId">appId</span>
                                        <span class="editable" id="appName">appName</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 广告位信息 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="slotId">slotId</span>
                                        <span class="editable" id="slotName">slotName</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 广告位宽高 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="width">width</span>
                                        <span class="editable" id="height">height</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 公司信息 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="company">北京中关互动科技有限公司</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 创建时间 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="createTime">2020-08-05</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--<div class="col-xs-12 col-sm-3 center">
                            <div class="profile-user-info profile-user-info-striped">
                                <div class="profile-info-row">
                                    <div class="profile-info-name">  </div>
                                    <div class="profile-info-value">
                                        <span class="editable"><strong>广告位操作</strong></span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 放量 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="country">按钮</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 抓入参 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="age">按钮</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 抓出参 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="signup">按钮</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 其他 </div>
                                    <div class="profile-info-value">
                                        <span class="editable" id="login">按钮</span>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                    </div>
                </div>
                <br>

                <!-- 两个表格 -->
                <div class="row">
                    <div class="col-xs-12">

                        <!-- 第一个表格 -->
                        <div class="clearfix">
                            <div class="pull-right tableTools-container"></div>
                        </div>
                        <div class="table-header">
                            平台分时统计
                        </div>
                        <div>
                            <table id="dynamic-table" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>时间(时)</th>
                                    <th>请求</th>
                                    <th>返回</th>
                                    <th>曝光</th>
                                    <th>点击</th>
                                    <th>DP</th>
                                    <th>200</th>
                                    <th>250</th>
                                    <th>300</th>
                                    <th>400</th>
                                    <th>500</th>
                                    <th>500+</th>
                                </tr>
                                <tr>
                                    <th>总计</th>
                                    <th id="sumRequest">0</th>
                                    <th id="sumResponse">0</th>
                                    <th id="sumLook">0</th>
                                    <th id="sumClick">0</th>
                                    <th id="sumDeeplink">0</th>
                                    <th id="t200">0</th>
                                    <th id="t250">0</th>
                                    <th id="t300">0</th>
                                    <th id="t400">0</th>
                                    <th id="t500">0</th>
                                    <th id="t1000">0</th>
                                </tr>
                                </thead>

                                <tbody id="platformTbody">

                                </tbody>
                            </table>
                        </div>


                        <!-- 第二个表格 -->
                        <div class="clearfix">
                            <div class="pull-right tableTools-container"></div>
                        </div>
                        <div class="table-header">
                            渠道分时统计
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <table id="simple-table" class="table  table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>渠道</th>
                                        <th width="300px">ID</th>
                                        <th width="100">详情</th>
                                        <th>请求</th>
                                        <th>返回</th>
                                        <th>曝光</th>
                                        <th>点击</th>
                                        <th>DP</th>
                                    </tr>
                                    </thead>

                                    <tbody id="channelTbody">
                                    </tbody>
                                </table>
                            </div><!-- /.span -->
                        </div><!-- /.row -->

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
    loading("appSlotReport", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        var slotId = sessionStorage.getItem("slotId");
        slotMsg(slotId);
        platformStatistics(slotId);
        channelStatistics(slotId);
    });

    function checkForDate(){
        var slotId = sessionStorage.getItem("slotId");
        platformStatistics(slotId);
        channelStatistics(slotId);
    }

    //广告位基本信息
    function slotMsg(slotId){
        $.ajax({
            url: path + "/slot/slotMsg",
            type: "post",
            data: {
                "slotId" : slotId
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var data = obj.result;
                    //$('#pageSize').val(obj.result.pageSize);
                    $('#appId').html(data.appId);
                    $('#appName').html(data.appName);
                    $('#slotId').html(data.slotId);
                    $('#slotName').html(data.slotName);
                    $('#company').html(data.nickName);
                    $('#createTime').html(data.createTime);
                    $('#width').html(data.width);
                    $('#height').html(data.height);
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //平台分时统计
    function platformStatistics(slotId){
        $.ajax({
            url: path + "/slot/platformStatistics",
            type: "post",
            data: {
                "slotId" : slotId,
                "date" : $('#date').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var data = obj.result;
                    //$('#pageSize').val(obj.result.pageSize);
                    $('#sumRequest').html(data.sumRequest);
                    $('#sumResponse').html(data.sumResponse);
                    $('#sumLook').html(data.sumLook);
                    $('#sumClick').html(data.sumClick);
                    $('#sumDeeplink').html(data.sumDeeplink);
                    $('#t200').html(data.t200);
                    $('#t250').html(data.t250);
                    $('#t300').html(data.t300);
                    $('#t400').html(data.t400);
                    $('#t500').html(data.t500);
                    $('#t1000').html(data.t1000);
                    var list = obj.result.list;
                    var html="";
                    for(var i = 0; i < list.length; i++){
                        var l = list[i];
                        html += '<tr>';
                        html += '<td>'+l.hour+'</td>';
                        html += '<td>'+l.downstreamRequest+'</td>';
                        html += '<td>'+l.response+'</td>';
                        html += '<td>'+l.look+'</td>';
                        html += '<td>'+l.click+'</td>';
                        html += '<td>'+l.deeplink+'</td>';
                        html += '<td>'+l.t200+'</td>';
                        html += '<td>'+l.t250+'</td>';
                        html += '<td>'+l.t300+'</td>';
                        html += '<td>'+l.t400+'</td>';
                        html += '<td>'+l.t500+'</td>';
                        html += '<td>'+l.t1000+'</td>';
                        html += '</tr>';
                    }
                    $("#platformTbody").html(html);
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //渠道分时统计
    function channelStatistics(slotId){
        $.ajax({
            url: path + "/slot/channelStatistics",
            type: "post",
            data: {
                "slotId" : slotId,
                "date" : $('#date').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result;
                    var html="";
                    for(var i = 0; i < list.length; i++){
                        var l = list[i];
                        html += '<tr>';
                        html += '<td>'+l.name+'</td>';
                        html += '<td>'+l.upstreamId+'</td>';
                        html += '<td class="center">';
                        html += '    <div class="action-buttons">';
                        html += '    <a href="#" class="green bigger-140 show-details-btn" title="Show Details">';
                        html += '    <i class="ace-icon fa fa-angle-double-down"></i>';
                        html += '    <span class="sr-only">Details</span>';
                        html += '    </a>';
                        html += '    </div>';
                        html += '</td>';
                        html += '<td>'+l.request+'</td>';
                        html += '<td>'+l.response+'</td>';
                        html += '<td>'+l.look+'</td>';
                        html += '<td>'+l.click+'</td>';
                        html += '<td>'+l.deeplink+'</td>';
                        html += '</tr>';
                        //二级表格
                        html += '<tr class="detail-row">';
                        html += '    <td colspan="12">';
                        html += '    <div class="table-detail">';
                        html += '    <div class="row">';
                        html += '    <div class="space visible-xs"></div>';

                        html += '    <div class="profile-user-info profile-user-info-striped">';
                        html += '    <table class="table  table-bordered table-hover">';
                        html += '    <tr>';
                        html += '    <th>时间(时)</th>';
                        html += '    <th>请求</th>';
                        html += '    <th>返回</th>';
                        html += '    <th>曝光</th>';
                        html += '    <th>点击</th>';
                        html += '    <th>DeepLink</th>';
                        html += '</tr>';
                        var dl = l.list;
                        for(var j = 0; j < dl.length; j++){
                            var d = dl[j];
                            html += '    <tr>';
                            html += '    <td>'+d.hour+'</td>';
                            html += '    <td>'+d.request+'</td>';
                            html += '    <td>'+d.response+'</td>';
                            html += '    <td>'+d.look+'</td>';
                            html += '    <td>'+d.click+'</td>';
                            html += '    <td>'+d.deeplink+'</td>';
                            html += '    </tr>';
                        }
                        html += '    </table>';
                        html += '    </div>';
                        html += '    </div>';
                        html += '    </div>';
                        html += '    </td>';
                        html += '    </tr>';

                    }
                    $("#channelTbody").html(html);

                    //展开隐藏栏-必须写到这
                    $('.show-details-btn').on('click', function(e) {
                        e.preventDefault();
                        $(this).closest('tr').next().toggleClass('open');
                        $(this).find(ace.vars['.icon']).toggleClass('fa-angle-double-down').toggleClass('fa-angle-double-up');
                    });

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
