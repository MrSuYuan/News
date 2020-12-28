<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>上游ID分配</title>
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
<input type="hidden" id="upstreamId"/>
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
                    <li class="active">上游ID分配</li>
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
                <div class="row">
                    <div class="col-xs-12">
                        <div class="hr dotted"></div>
                        <div>
                            <div id="user-profile-3" class="user-profile row">
                                <div class="col-sm-offset-1 col-sm-10">
                                    <div class="space"></div>

                                    <form class="form-horizontal">
                                        <div class="tabbable">
                                            <ul class="nav nav-tabs padding-16">
                                                <li class="active">
                                                    <a data-toggle="tab" href="#edit-basic">
                                                        <i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
                                                        编辑广告位信息
                                                    </a>
                                                </li>
                                            </ul>

                                            <div class="tab-content profile-edit-tab-content">
                                                <div id="edit-basic" class="tab-pane in active">

                                                    <h4 class="header blue bolder smaller">平台基本信息</h4>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">APP名称</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="appName" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">广告位名称</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="slotName" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">APPID</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="appId" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">广告位ID</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="slotId" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">分流比率</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="probability" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space"></div>


                                                    <h4 class="header blue bolder smaller">更换前-上游信息</h4>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">广告位ID</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="oldUpstreamId" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">APPID</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="oldUpstreamAppId" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">包名</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="oldUpstreamPackageName" value="" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">平台</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" id="oldUpstreamType" disabled/>
                                                        </div>
                                                    </div>
                                                    <div class="space"></div>


                                                    <h4 class="header blue bolder smaller">更换后-上游信息</h4>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">广告位ID</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" value="" id="newUpstreamId" />
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">APPID</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" value="" id="newUpstreamAppId" />
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">包名</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" value="" id="newUpstreamPackageName" />
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right">平台</label>
                                                        <div class="col-sm-9">
                                                            <span id="upstreamTypeList"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clearfix form-actions">
                                            <div class="col-md-offset-3 col-md-9">
                                                <button class="btn btn-info" type="button" onclick="newUpstream()">
                                                    <i class="ace-icon fa fa-check bigger-110"></i>
                                                    保存
                                                </button>

                                                &nbsp; &nbsp;
                                                <%--<button class="btn" type="reset">
                                                    <i class="ace-icon fa fa-undo bigger-110"></i>
                                                    重置
                                                </button>--%>
                                            </div>
                                        </div>
                                    </form>
                                </div><!-- /.span -->
                            </div><!-- /.user-profile -->
                        </div>

                        <!-- PAGE CONTENT ENDS -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
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
    loading("appUpstreamIdEdit", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        var upstreamId =  sessionStorage.getItem("upstreamId");
        $('#upstreamId').val(upstreamId);
        upstreamType();
        upstreamIdMsg(upstreamId);
    });

    //查询上游信息
    function upstreamType(){
        var html = "";
        //保存代码位信息
        $.ajax({
            url: path + "/app/allAppUpstreamType",
            data:{
                "sign" : 1
            },
            type: "post",
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.code == 200){
                    html += '<select style="width: 171.6px;height: 33.8px" id="newUpstreamType">';
                    html += '<option value="0">请选择</option>';
                    var list = data.result;
                    for (var i = 0; i < list.length; i++){
                        var d = list[i];
                        html += '<option value="'+d.type+'">'+d.name+'</option>';
                    }
                    html += '</select>';
                    $("#upstreamTypeList").html(html);
                }else{
                    alert(data.message);
                }
            },
            error: function () {
                alert("Error");
            }
        });
    }

    //展示
    function upstreamIdMsg(upstreamId) {
        $.ajax({
            url: path + "/app/appUpstreamIdMsg",
            type: "post",
            data: {
                "upstreamId" : upstreamId
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var msg = obj.result.msg;
                    $('#appName').val(msg.appName);
                    $('#slotName').val(msg.slotName);
                    $('#appId').val(msg.appId);
                    $('#slotId').val(msg.slotId);
                    $('#probability').val(msg.probability);
                    $('#oldUpstreamId').val(msg.upstreamId);
                    $('#oldUpstreamAppId').val(msg.upstreamAppId);
                    $('#oldUpstreamType').val(msg.name);
                    $('#oldUpstreamPackageName').val(msg.upstreamPackageName);
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

    //提交
    function newUpstream() {
        var upstreamId = $('#upstreamId').val();
        var newUpstreamId = $('#newUpstreamId').val();
        var newUpstreamAppId = $('#newUpstreamAppId').val();
        var newUpstreamType = $('#newUpstreamType option:selected').val();
        if(null==upstreamId || null==newUpstreamId || 0==newUpstreamType ||
            ""==upstreamId || ""==newUpstreamId){
            alert("请将信息填写完毕再提交");
        }else{

            $.ajax({
                url: path + "/app/newUpstream",
                type: "post",
                data: {
                    "upstreamId" : upstreamId,
                    "newUpstreamId" : newUpstreamId,
                    "newUpstreamAppId" : newUpstreamAppId,
                    "newUpstreamType" : newUpstreamType,
                    "newUpstreamPackageName" : $('#newUpstreamPackageName').val()
                },
                dataType: 'json',
                async: false,
                success: function (obj) {
                    if(obj.code == 200){
                        alert(obj.message);
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
    }

</script>

</html>
