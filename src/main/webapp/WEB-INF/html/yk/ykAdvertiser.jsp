<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>广告主</title>
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
                    <li class="active">广告主列表</li>
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
                        <form action="#" method="post">
                            <br>
                            <div align="right">
                                <a class="btn btn-primary btn-xs" onclick="addYKAdEr_model()">
                                    <i class="ace-icon glyphicon bigger-110"><font size="3">添加广告主信息</font></i>
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
                                                <th>名称</th>
                                                <th>品牌</th>
                                                <th>地址</th>
                                                <th>联系人</th>
                                                <th>电话</th>
                                                <th>证书名称</th>
                                                <th>证书图片</th>
                                                <th>证书链接</th>
                                                <th>当前状态</th>
                                            </tr>
                                            </thead>
                                            <tbody id="coll_list_begin_body">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- 设置模态框 -->
                            <div class="modal" id="addYKAdEr_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <form class="form-horizontal" role="form">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                                        aria-hidden="true">&times;</span></button>
                                                <h2 class="modal-title">添加广告主信息<input type="hidden"></h2>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 名称 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="name">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 品牌 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="brand">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 地址 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="address">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 联系人 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="user">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 电话 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="tel">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 证书名称 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="certificate">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 证书链接 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="certificateUrl">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right "> 证书图片 </label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="col-xs-10 col-sm-10" id="certificateImage">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                <button type="button" class="btn btn-primary" onclick="addAdvertiser()">确定</button>
                                            </div>
                                        </div>
                                    </form>
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
    loading("ykAdvertiser", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        var selectUserId = sessionStorage.getItem("selectUserId");
        if(selectUserId != null){
            $('#loginName').val(sessionStorage.getItem("selectLoginName"));
            $('#nickName').val(sessionStorage.getItem("selectNickName"));
            sessionStorage.removeItem("selectLoginName");
            sessionStorage.removeItem("selectNickName");
        }
        selectList();
    });

    //点击搜索数据展示
    function selectList() {
        $.ajax({
            url: path + "/yk/checkAdvertiser",
            type: "post",
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.name+'</td>';
                        html+='<td> '+data.brand+'</td>';
                        html+='<td> '+data.address+'</td>';
                        html+='<td> '+data.user+'</td>';
                        html+='<td> '+data.tel+'</td>';
                        html+='<td> '+data.certificate+'</td>';
                        html+='<td> '+data.certificateImage+'</td>';
                        html+='<td> '+data.certificateUrl+'</td>';
                        var status = data.status;
                        if(status == 0){
                            html+='<td><font color="red">' +'已删除' + '</font></td>';
                        }else if(status == 1){
                            html+='<td id="yk'+data.id+'">' +
                                '<button type="button" class="btn btn-minier btn-success" onclick="changeAppStatus(\''+data.id+'\')">删除</button>' +
                                '</td>';
                        }else{
                            html+='<td><font color="red">状态错误</font></td>';
                        }

                        html+='</tr>';
                        $("#coll_list_begin_body").html(html);
                    }
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


    //添加新的广告主
    function addAdvertiser() {
        var advertiser = {
            "name" : $('#name').val(),
            "brand" : $('#brand').val(),
            "address" : $('#address').val(),
            "user" : $('#user').val(),
            "tel" : $('#tel').val(),
            "certificate" : $('#certificate').val(),
            "certificateUrl" : $('#certificateUrl').val()
        }

        $.ajax({
            url: path + "/yk/addAdvertiser",
            type: "post",
            data: advertiser,
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    $("#addYKAdEr_model").modal("hide");
                    selectList();
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


    //appStatus 1未审核 2驳回 3正常 4禁用
    function changeAppStatus(id){
        $.ajax({
            url: path + "/yk/deleteAdvertiser",
            type: "post",
            data: {
                "id" : id
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.code == 200){
                    $('#yk'+id).empty();
                    $('#yk'+id).html('<font color="red">已删除</font>');

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


    function addYKAdEr_model(){
        $("#addYKAdEr_model").modal("show");
    }

</script>

</html>
