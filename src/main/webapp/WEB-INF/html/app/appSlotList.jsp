<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>广告位</title>
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
                    <li class="active">广告位列表</li>
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
                        <span id="nickNameSpan">
                            登录账号：<input type="text" id="loginName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                            公司名称：<input type="text" id="nickName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        </span>
                        APPID：<input type="text" id="appId" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        广告位ID：<input type="text" id="slotId" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        广告位类型：
                        <select id="slotType" style="width:100px;height:30px">
                            <option value="0">请选择</option>
                            <option value="1">横幅</option>
                            <option value="2">开屏</option>
                            <option value="3">插屏</option>
                            <option value="4">信息流</option>
                            <option value="5">激励视频</option>
                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn btn-primary btn-xs" onclick="appSlotList($('#currentPage').val())">
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
                                        <th>APPID</th>
                                        <th>广告位名称</th>
                                        <th>APP名称</th>
                                        <th id="nickNameTh">所属用户</th>
                                        <th>广告类型</th>
                                        <%--<th>宽度</th>
                                        <th>高度</th>--%>
                                        <th>创建时间</th>
                                        <%--<th id="divided">分成</th>--%>
                                        <th id="fl">今日量级</th>
                                        <th id="operate">添加&nbsp;&nbsp;/&nbsp;&nbsp;查看&nbsp;&nbsp;/&nbsp;&nbsp;分成&nbsp;&nbsp;/&nbsp;&nbsp;统计&nbsp;&nbsp;/&nbsp;&nbsp;放量</th>
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

                        <!-- 设置模态框 -->
                        <div class="modal" id="app_divided_set" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <form class="form-horizontal" role="form">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                                    aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">设置YZ<input type="hidden" id="dividedSlotId"></h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right "> Y : </label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="col-xs-10 col-sm-7" id="dividedY">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right "> Z : </label>
                                                    <div class="col-sm-8">
                                                        <input type="text" class="col-xs-10 col-sm-7" id="dividedZ">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                            <button type="button" class="btn btn-primary" onclick="updateProportion()">确定</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>

                </form>

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
    loading("appSlotList", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        var selectUserId = sessionStorage.getItem("selectUserId");
        if(selectUserId != null){
            $('#loginName').val(sessionStorage.getItem("selectLoginName"));
            $('#nickName').val(sessionStorage.getItem("selectNickName"));
            sessionStorage.removeItem("selectLoginName");
            sessionStorage.removeItem("selectNickName");
        }
        var appId = sessionStorage.getItem("appId");
        if(appId != null){
            $('#appId').val(appId);
            sessionStorage.removeItem("appId");
        }

        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel == 2 || currentUserLevel == 1){
            $('#operate').show();
            $('#divided').show();
        }else{
            $('#operate').hide();
            $('#divided').hide();
        }
        if(currentUserLevel == 3){
            $('#nickNameSpan').hide();
            $('#nickNameTh').hide();
            $('#fl').hide();
        }
        appSlotList(1);
    });

    //点击搜索数据展示
    function appSlotList(currentPage) {
        var currentUserLevel = $('#currentUserLevel').val();
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/app/appSlotList",
            type: "post",
            data: {
                "loginName" : $('#loginName').val(),
                "nickName" : $('#nickName').val(),
                "appId" : $('#appId').val(),
                "slotId" : $('#slotId').val(),
                "currentPage" : currentPage,
                "pageSize" : pageSize,
                "slotType" :  $('#slotType option:selected').val(),
                "upstreamType" : $('#upstreamType option:selected').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.slotList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.slotId+'</td>';
                        html+='<td> '+data.appId+'</td>';
                        html+='<td> '+data.slotName+'</td>';
                        html+='<td> '+data.appName+'</td>';
                        if (currentUserLevel != 3){
                            html+='<td> '+data.nickName+'</td>';
                        }
                        var slotType = data.slotType;
                        if(slotType == 1){
                            html+='<td> 横幅 </td>';
                        }else if(slotType == 2){
                            html+='<td> 开屏 </td>';
                        }else if(slotType == 3){
                            html+='<td> 插屏 </td>';
                        }else if(slotType == 4){
                            html+='<td> 信息流 </td>';
                        }else if(slotType == 5){
                            html+='<td> 激励视频 </td>';
                        }else{
                            html+='<td> <font color="red">信息错误</font> </td>';
                        }
                        // html+='<td> '+data.width+'</td>';
                        // html+='<td> '+data.height+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        if(currentUserLevel == 2 || currentUserLevel == 1){

                            //html+='<td> Y : '+data.dividedY+' , Z : '+data.dividedZ+'</td>';
                            var request = data.request;
                            if (request == 0){
                                html+='<td> <font color="red">'+data.request+'</font></td>';
                            }else{
                                html+='<td> '+data.request+'</td>';
                            }

                            html+='<td>';
                            //放量
                            var flowStatus = data.flowStatus;
                            html+='<div class="widget-toolbar no-border">';
                            if (flowStatus == 1) {
                                html+='<input type="checkbox" class="ace ace-switch ace-switch-3" id="input'+data.slotId+'" onclick="flowStatus(\''+data.slotId+'\')" checked/>';
                            }else{
                                html+='<input type="checkbox" class="ace ace-switch ace-switch-3" id="input'+data.slotId+'" onclick="flowStatus(\''+data.slotId+'\')"/>';
                            }
                            html+='    <span class="lbl middle"></span>';
                            html+='</div>';
                            html+='<div class="hidden-sm hidden-xs btn-group">' +
                                '<button type="button" class="btn btn-xs btn-success" title="添加" onclick="addUpstream(\''+data.slotId+'\')">' +
                                '<i class="ace-icon glyphicon glyphicon-plus bigger-110"></i>' +
                                '</button>' +
                                '<button type="button" class="btn btn-xs btn-info" title="查看" onclick="checkUpstream(\''+data.slotId+'\')">' +
                                '<i class="ace-icon glyphicon glyphicon-align-justify bigger-110"></i>' +
                                '</button>' +
                                '<button type="button" class="btn btn-xs btn-default" title="分成 X:'+data.dividedY+' , Y:'+data.dividedZ+'" onclick="divided(\''+data.slotId+'!'+data.dividedY+'!'+data.dividedZ+'\')">' +
                                '<i class="ace-icon glyphicon glyphicon-edit bigger-110"></i>' +
                                '</button>' +
                                '<button type="button" class="btn btn-xs btn-warning" title="统计" onclick="report(\''+data.slotId+'\')">' +
                                '<i class="ace-icon glyphicon glyphicon-indent-right bigger-110"></i>' +
                                '</button>' +
                                // '<button type="button" class="btn btn-xs btn-warning" title="分流" onclick="assign(\''+data.slotId+'\')">' +
                                // '<i class="ace-icon glyphicon glyphicon-pencil bigger-110"></i>' +
                                // '</button>' +
                                // '<button type="button" class="btn btn-xs btn-danger" title="删除">' +
                                // '<i class="ace-icon glyphicon glyphicon-trash bigger-110"></i>' +
                                '</button>' +
                                '</div>'+
                            '</td>';
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
        var page = parseInt($('#currentPage').text());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            appSlotList(page);
        }
    }

    //下一页
    function nextPageData() {
        var page = parseInt($('#currentPage').text());
        var sumPage = parseInt($('#sumPage').text());
        if(page == sumPage){
            alert("当前是最后一页");
        }else{
            var page = page + 1;
            appSlotList(page);
        }
    }

    //放量
    function flowStatus(slotId) {
        var status = $('#input'+slotId).is(":checked");
        var flowStatus;
        if (status == true){
            flowStatus = 1;
        } else {
            flowStatus = 0;
        }
        $.ajax({
            url: path + "/app/flowStatus",
            type: "post",
            data: {
                "slotId" : slotId,
                "flowStatus" : flowStatus
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    alert(obj.message);
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.location = path+"/login";
                }else{
                    alert(obj.message);
                    if (status == true){
                        $('#input'+slotId).prop("checked", false);
                    } else {
                        $('#input'+slotId).prop("checked", true);
                    }
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //添加
    function addUpstream(slotId) {
        sessionStorage.setItem("slotId",slotId);
        window.location = path + "/appSlotAddUpstream";
    }

    //查看
    function checkUpstream(slotId) {
        sessionStorage.setItem("slotId",slotId);
        window.location = path + "/appSlotUpstreamList";
    }

    //查看
    function report(slotId) {
        sessionStorage.setItem("slotId",slotId);
        window.location = path + "/appSlotReport";
    }

    //分流
    // function assign(slotId) {
    //     sessionStorage.setItem("slotId",slotId);
    //     window.location = path + "/appAssign";
    // }

    //set
    function divided(data){
        var str = data.split('!');
        $('#dividedSlotId').val(str[0]);
        $('#dividedY').val(str[1]);
        $('#dividedZ').val(str[2]);
        $("#app_divided_set").modal("show");
    }

    //update
    function updateProportion() {
        var slotId = $('#dividedSlotId').val();
        var dividedY = $('#dividedY').val();
        var dividedZ = $('#dividedZ').val();
        if (dividedY > 1 || dividedZ > 1) {
            alert("参数错误");
        }else{
            $.ajax({
                url: path + "/app/updateSlotDivided",
                type: "post",
                data: {
                    "slotId" : slotId,
                    "dividedY" : dividedY,
                    "dividedZ" : dividedZ
                },
                dataType: 'json',
                async: false,
                success: function (obj) {
                    if(obj.code == 200){
                        $("#app_divided_set").modal("hide");
                        var page = parseInt($('#currentPage').text());
                        appSlotList(page);
                    }else if(obj.code == "300"){
                        alert(obj.message);
                        window.location = path+"/login";
                    }else{
                        alert(obj.message);
                    }
                },
                error: function () {
                    alert("请求异常");
                }
            });
        }
    }
</script>

</html>
