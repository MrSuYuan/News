<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>HTTP请求模拟工具</title>
    <meta name="description" content="Drag &amp; drop hierarchical list" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/fonts.googleapis.com.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-skins.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/jquery-ui.custom.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/jquery.gritter.min.css" />
    <style>
        /* some elements used in demo only */
        .spinner-preview {
            width: 100px;
            height: 100px;
            text-align: center;
            margin-top: 60px;
        }

        .dropdown-preview {
            margin: 0 5px;
            display: inline-block;
        }
        .dropdown-preview  > .dropdown-menu {
            display: block;
            position: static;
            margin-bottom: 5px;
        }

        pre {outline: 1px solid #ccc; padding: 5px; margin: 5px; }
        .string { color: green; }
        .number { color: darkorange; }
        .boolean { color: blue; }
        .null { color: magenta; }
        .key { color: red; }
    </style>
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

    <div class="main-content">
        <div class="main-content-inner">

            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}/index">Home</a>
                    </li>
                    <li class="active">HTTP请求模拟工具</li>
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

            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="row">

                            <!-- 参数区 -->
                            <div class="col-sm-6">
                                <div class="tabbable">
                                    <ul class="nav nav-tabs" id="myTab">
                                        <li id="tabLi1" class="active">
                                            <a data-toggle="tab" href="#home">
                                                详细参数
                                            </a>
                                        </li>

                                        <li id="tabLi2">
                                            <a data-toggle="tab" href="#messages">
                                                组合参数
                                            </a>
                                        </li>

                                    </ul>

                                    <div class="tab-content">
                                        <div id="home" class="tab-pane fade in active">

                                            <form class="form-horizontal" role="form">

                                                <div id="accordion" class="accordion-style1 panel-group">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">
                                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                                                    <i class="ace-icon fa fa-angle-down bigger-110" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
                                                                    &nbsp; IDS
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-collapse collapse in" id="collapseOne">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> appId </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="appId" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> slotId </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="slotId"  class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> requestId </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="requestId" value="1119092016594257588754" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">
                                                                <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                                                    <i class="ace-icon fa fa-angle-right bigger-110" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
                                                                    &nbsp; APP
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-collapse collapse" id="collapseTwo">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> appPackage </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="appPackage" value="com.tencent.tmgp.zy.ddzjdb" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> appVersion </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="appVersion" value="1.1.3" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> appName </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="appName" value="斗地主经典版" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">
                                                                <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
                                                                    <i class="ace-icon fa fa-angle-right bigger-110" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
                                                                    &nbsp; 广告位
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-collapse collapse" id="collapseThree">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> slotwidth </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="slotwidth" value="320" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> slotheight </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="slotheight" value="480" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> adtype </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="adtype" value="5" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">
                                                                <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
                                                                    <i class="ace-icon fa fa-angle-right bigger-110" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
                                                                    &nbsp; 设备信息
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-collapse collapse" id="collapseFour">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> idfa </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="idfa" value="" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> imei </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="imei" value="866333026939494" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> mac </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="mac" value="18:59:36:16:47:59" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> androidId </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="androidId" value="4fd86c81fc8e2daa" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> osType </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="osType" value="1" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> osVersion </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="osVersion" value="6.0.1" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> deviceType </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="deviceType" value="1" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> vendor </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="vendor" value="Xiaomi" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> brand </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="brand" value="Xiaomi" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> model </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="model" value="MI 4LTE" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> screenWidth </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="screenWidth" value="1080" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> screenHeight </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="screenHeight" value="1920" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> ua </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="ua" value="Mozilla/5.0 (Linux; Android 6.0.1; MI 4LTE Build/MMB29M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/57.0.2987.132 Mobile Safari/537.36" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> ppi </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="ppi" value="480" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> screenOrientation </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="screenOrientation" placeholder="1" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> imsi </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="imsi" value="460021317195750" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">
                                                                <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
                                                                    <i class="ace-icon fa fa-angle-right bigger-110" data-icon-hide="ace-icon fa fa-angle-down" data-icon-show="ace-icon fa fa-angle-right"></i>
                                                                    &nbsp; 网络信息
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-collapse collapse" id="collapseFive">
                                                            <div class="panel-body">
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> ip </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="ip" value="117.150.189.133" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> operatorType </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="operatorType" value="1" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> connectionType </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="connectionType" value="100" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> lat </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="lat" value="0.0" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> lon </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="lon" value="0.0" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-3 control-label no-padding-right"> cellular_id </label>
                                                                    <div class="col-sm-9">
                                                                        <input type="text" id="cellular_id" value="" class="col-xs-10 col-sm-8" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>

                                        <div id="messages" class="tab-pane fade">
                                            <p>JSON格式长字符串参数组</p>
                                            <textarea name="json" id="jsonStr" cols="82" rows="10"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="vspace-16-sm"></div>

                            <!-- 展示区 -->
                            <div class="col-sm-6">
                                <button class="btn btn-info" type="button" onclick="submit()">
                                    <i class="ace-icon fa fa-check bigger-110"></i>
                                    获取广告
                                </button>
                                <button class="btn btn-info" type="button" onclick="clearDown()">
                                    清空展示区
                                </button>
                                <div class="dd dd-draghandle">
                                    <div class="clearfix form-actions">
                                        <p>广告返回参数展示区</p>
                                        <pre id="ads" value="广告展示" style="height: 50px"></pre>
                                        <%--<span id="ads"></span>--%>
                                    </div>
                                </div>
                            </div>


                        </div><!-- PAGE CONTENT ENDS -->
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.page-content -->
        </div>

        <!-- 页面尾部 -->
        <div class="footer" id ="footer"></div>
        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
            <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
        </a>

    </div><!-- /.main-content -->

</div><!-- /.main-container -->

<script src="${ctx}/static/manage/index/template.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-2.1.4.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='${ctx}/static/common/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctx}/static/common/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace.min.js"></script>
<script type="text/javascript">
    var path = "${ctx}";
</script>
<script type="text/javascript">
    loading("httpRequest", $('#userName').val());

    function clearDown() {
        $('#ads').html("");
    }

    //请求
    function submit() {

        var data = "";
        if($('#tabLi1').hasClass("active")){
            var requestId = $('#requestId').val();
            var app = {
                "appId": $('#appId').val(),
                "appName": $('#appName').val(),
                "appVersion": $('#appVersion').val(),
                "appPackage": $('#appPackage').val()
            };
            var slot = {
                "slotId": $('#slotId').val(),
                "slotheight": $('#slotheight').val(),
                "slotwidth": $('#slotwidth').val(),
                "adtype": $('#adtype').val()
            };
            var device = {
                "androidId": $('#androidId').val(),
                "deviceType": $('#deviceType').val(),
                "idfa": $('#idfa').val(),
                "imei": $('#imei').val(),
                "mac": $('#mac').val(),
                "vendor": $('#vendor').val(),
                "model": $('#model').val(),
                "osType": $('#osType').val(),
                "osVersion": $('#osVersion').val(),
                "screenHeight": $('#screenHeight').val(),
                "screenWidth": $('#screenWidth').val(),
                "ua": $('#ua').val(),
                "ppi": $('#ppi').val(),
                "screenOrientation": $('#screenOrientation').val(),
                "imsi": $('#imsi').val(),
                "brand": $('#brand').val()
            };
            var network =  {
                "connectionType": $('#connectionType').val(),
                "ip": $('#ip').val(),
                "operatorType": $('#operatorType').val(),
                "lat": $('#lat').val(),
                "lon": $('#lon').val()
            };
            var jsonStr = {
                "requestId" : requestId,
                "app" : app,
                "slot" : slot,
                "device" : device,
                "network" : network
            };

            data = JSON.stringify(jsonStr);
        }
        if($('#tabLi2').hasClass("active")){
            data = $('#jsonStr').val();
        }
        $.ajax({
            url: path + "app/httpRequest",
            type: "post",
            data:data,
            contentType:"json/application",
            dataType: 'json',
            async: false,
            success: function(data){
                if(data.code == 200){
                    var json = data.result;
                    $('#ads').html(JsonFormat(json));
                }else{
                    alert("错误");
                }

            },
            error:function(){
                alert("失败");
            }
        });
    }

    function JsonFormat(json) {
        if (typeof json != 'string') {
            json = JSON.stringify(json, undefined, 2);
        }
        json = json.replace(/&/g, '&').replace(/</g, '<').replace(/>/g, '>');
        return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
            var cls = 'number';
            if (/^"/.test(match)) {
                if (/:$/.test(match)) {
                    cls = 'key';
                } else {
                    cls = 'string';
                }
            } else if (/true|false/.test(match)) {
                cls = 'boolean';
            } else if (/null/.test(match)) {
                cls = 'null';
            }
            return '<span class="' + cls + '">' + match + '</span>';
        });
    }

</script>
</body>
</html>
