<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title id="titleText"></title>
    <meta name="description" content="overview &amp; stats"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-datepicker3.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-timepicker.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/daterangepicker.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-datetimepicker.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-colorpicker.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/font-awesome/4.5.0/css/font-awesome.min.css"/>
    <!--icon 图标-->
    <link id="ICon_index" rel="Shortcut Icon" href="" type="image/x-icon"/>
    <!-- page specific plugin styles -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-duallistbox.min.css"/>
    <!-- text fonts -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/fonts.googleapis.com.css"/>
    <!-- ace styles -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style"/>
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="../../static/common/assets/css/ace-part2.min.css" class="ace-main-stylesheet"/>
    <![endif]-->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-rtl.min.css"/>
    <%-- <link rel="stylesheet" href="${ctx}/statics/common/css/bootstrap-datetimepicker.css" /> --%>
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/chosen.min.css"/>
    <script src="${ctx}/static/common/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/static/common/assets/js/moment.min.js"></script>
    <script src="${ctx}/static/common/assets/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${ctx}/static/common/assets/js/bootstrap-datepicker.min.js"></script>
    <script src="${ctx}/static/common/assets/js/bootstrap-timepicker.min.js"></script>
    <script src="${ctx}/static/common/assets/js/daterangepicker.min.js"></script>
    <script src="${ctx}/static/common/assets/js/bootstrap-colorpicker.min.js"></script>
    <link rel="stylesheet" href="${ctx}/static/common/css/jquery.treegrid.css"/>
    <link rel="stylesheet" href="${ctx}/static/common/css/dtx_style.css"/>

    <script src="${ctx}/static/common/js/jquery.validate.min.js"></script>
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="../../static/common/assets/css/ace-ie.min.css"/>
    <![endif]-->
    <!-- ace settings handler -->
    <script src="${ctx}/static/common/assets/js/ace-extra.min.js"></script>
    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
    <!--[if lte IE 8]>
    <script src="../../static/common/assets/js/html5shiv.min.js"></script>
    <script src="../../static/common/assets/js/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .logo {
            width: 38px;
            height: 38px;
            float: left;
            margin-top: 3.5px;
            margin-bottom: 3.5px;
        }

        .imgSrc {
            width: 100%;
        }
    </style>
    <script type="text/javascript">
        var path = "${ctx}";
    </script>
</head>

<body class="no-skin">
<div id="navbar" class="navbar navbar-default ace-save-state">
    <div class="navbar-container ace-save-state" id="navbar-container">
        <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
            <span class="sr-only">Toggle sidebar</span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>

            <span class="icon-bar"></span>
        </button>

        <div class="navbar-header pull-left">

            <%--<img  src="${ctx }/picture/CNAACLogo.png" class="logo">--%>

            <a href="/index" class="navbar-brand">
                <small id="headline">
                    中关互动后台管理系统
                </small>
            </a>
        </div>
        <div style="position: absolute;top: 10%;left: 50%;width:25%;">
            <form class="form-search">
                <div class="row">
                    <div>
                    </div>
                </div>
            </form>

        </div>

        <div class="navbar-buttons navbar-header pull-right" role="navigation">

            <ul class="nav ace-nav">
                <li class="light-blue dropdown-modal">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <img class="nav-user-photo" src="${ctx}/static/common/assets/images/avatars/user.jpg"
                             alt="Jason's Photo"/>
                        <span class="user-info">
									<small>WELCOME</small>
									${sessionScope.nickName}
                            <input type="hidden" id="currentUserLevel" value="${sessionScope.userLevel}"/>
						</span>

                        <i class="ace-icon fa fa-caret-down"></i>
                    </a>

                    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">

                        <li>
                        <a href="javascrip:void(0)" onclick="index_changePwd_updatePwd();">
                        <i class="ace-icon fa fa-key"></i>
                            修改密码
                        </a>
                        </li>

                        <li>
                            <a href="${ctx }/logout">
                                <i class="ace-icon fa fa-power-off"></i>
                                退出
                            </a>
                        </li>

                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="main-container ace-save-state" id="main-container">

    <div id="sidebar" class="sidebar responsive ace-save-state">
        <ul class="nav nav-list" id="menu_ul">
            <li class="" id="userList">
                <a href="#" url="${ctx}/userList">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> 用户管理 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="" id="reviewNormalList">
                <a href="#" url="${ctx}/appList">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> APP管理 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="" id="reviewErrorList">
                <a href="#" url="${ctx}/reviewErrorList">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> 未完待续 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="" id="userAuditList">
                <a href="#" url="${ctx}/userAuditList">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> 未完待续 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="" id="userManagementList">
                <a href="#" url="${ctx}/userManagementList">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> 未完待续 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="" id="upload">
                <a href="#" url="${ctx}/upload">
                    <i class="menu-icon fa fa-list-alt"></i>
                    <span class="menu-text"> 未完待续 </span>
                </a>

                <b class="arrow"></b>
            </li>
            <li class="" name="level1" id="test">
                <a href="###" class="dropdown-toggle">
                    <i class="menu-icon fa fa-bars"></i>
                    <span class="menu-text"> 折叠菜单 </span>
                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>
                <ul class="submenu">
                    <li class="">
                        <a href="#" class="dropdown-toggle" url="${ctx}/exampleList">
                            <i class="menu-icon fa fa-caret-right"></i>
                            自定义一
                            <%--<b class="arrow fa fa-angle-down"></b>--%>
                            <b class="active"></b>
                        </a>
                        <b class="arrow"></b>
                    </li>
                    <li class="">
                        <a href="#" class="dropdown-toggle" url="${ctx}/exampleList">
                            <i class="menu-icon fa fa-caret-right"></i>
                            自定义二
                            <%--<b class="arrow fa fa-angle-down"></b>--%>
                        </a>
                        <b class="arrow"></b>
                    </li>
                </ul>
            </li>
        </ul><!-- /.nav-list -->

        <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
            <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state"
               data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
        </div>
    </div>

    <div class="main-content">
        <div class="main-content-inner">

            <div class="col-sm-12 no-padding ">

                <div class="tab-content no-border" id="index_mybody">

                </div>
            </div>
        </div>
    </div><!-- /.main-content -->

    <div class="footer">
        <div class="footer-inner">
            <div class="footer-content">
						<span class="bigger-120">
							<span class="blue bolder" id="bottom"></span>
							后台管理系统 &copy; 2019
						</span>

                &nbsp; &nbsp;
            </div>
        </div>
    </div>

    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->
<!-- 修改密码-模态框 -->
<div class="modal" id="index_changePwd_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form class="form-horizontal" role="form" id="index_changePwd_agreeFrom">
            <input type="hidden" id="index_changePwd_userId" name="index_changePwd_userId" value="">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="index_changePwd_myModalLabel">修改密码</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right " for="oldPassWord">
                                原密码: </label>
                            <div class="col-sm-8">
                                <input type="password" id="oldPassWord" placeholder="请输入原密码"
                                       class="col-xs-10 col-sm-7" name="oldPassWord">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right " for="passWord">
                                新密码: </label>
                            <div class="col-sm-8">
                                <input type="password" id="passWord" placeholder="请输入新密码"
                                       class="col-xs-10 col-sm-7" name="passWord">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right "
                                   for="confirmPassWord"> 确认新密码: </label>
                            <div class="col-sm-8">
                                <input type="password" id="confirmPassWord" placeholder="请再次输入新密码"
                                       class="col-xs-10 col-sm-7" name="confirmPassWord">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="confirm()">确定</button>
                </div>
            </div>
        </form>
    </div>
</div>


<!--[if !IE]> -->

<script src="${ctx}/static/common/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.bootstrap-duallistbox.min.js"></script>
<script src="${ctx}/static/common/assets/js/bootstrap-datepicker.min.js"></script>


<script src="${ctx}/static/common/assets/js/jquery-ui.custom.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.easypiechart.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.sparkline.index.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.pie.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.resize.min.js"></script>

<script src="${ctx}/static/common/assets/js/jquery.maskedinput.min.js"></script>
<script src="${ctx}/static/common/assets/js/bootstrap-editable.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-editable.min.js"></script>


<script src="${ctx}/static/common/js/jquery.treegrid.js"></script>
<script src="${ctx}/static/common/js/jquery.treegrid.extension.js"></script>
<%-- 		<script src="${ctx}/statics/common/js/bootstrap-datetimepicker.js"></script>
		<script src="${ctx}/statics/common/js/locales/bootstrap-datetimepicker.zh-CN.js"></script> --%>
<script src="${ctx}/static/common/js/jquery.pagination-beta.js"></script>

<!-- 这个和模态框冲突了 -->
<%--<link rel="stylesheet" href="${ctx}/static/common/css/button.css"/>--%>
<script src="${ctx}/static/common/js/main.js"></script>
<script type="text/javascript">
    $(function ($) {
        // ajaxCon();//返回当前项目名称
        // getMenuList();
        $("#sidebar").find("a").click(function () {
            var tagId = $(this).attr("id");
            var uri = $(this).attr("url");
            if (uri != "" && uri != null && uri != undefined) {

                if ($("#myTab").find("li").length < 12) {
                    var tagName = $(this).attr("name");
                    var tagHTML = '';
                    tagHTML += '<li class="active" id="dtx_index_tag_' + tagId + '">';
                    tagHTML += '<a class="dtx_tag" data-toggle="tab" href="#dtx_index_body_' + tagId + '">';
                    tagHTML += tagName;
                    tagHTML += '<button class="bootbox-close-button close" style="margin-left:5px;" type="button" onclick="dtx_index_close(' + tagId + ')">×</button>';
                    tagHTML += '</a>';
                    tagHTML += '</li>';
                    var bodyHTML = '';
                    bodyHTML += '<div id="dtx_index_body_' + tagId + '" class="tab-pane fade active in ">';
                    bodyHTML += '';
                    bodyHTML += '</div>';
                    if ($("#dtx_index_tag_" + tagId).length > 0) {
                        $("#dtx_index_tag_" + tagId).find("a").click();
                    } else {
                        $("#myTab").find("li").removeClass("active");
                        $("#index_mybody").find("div").removeClass("active");
                        $("#index_mybody").find("div").removeClass("in");
                        $("#myTab").append(tagHTML);
                        $("#dtx_index_body_"+tagId).remove();
                        $("#index_mybody").append($(bodyHTML));
                        gotoURL(uri)
                    }

                } else {
                    $.alertModel("对不起!无法开启更多窗口.");
                }

            }

        });
    });

    //进入页面直接请求数据,根据身份展示标签
    $(document).ready(function(){
        var userLevel = $('#userLevel').val();
        if(userLevel == 1){
            $('#reviewNormalList').show();
            $('#reviewErrorList').show();
            $('#userList').show();
            $('#userAuditList').show();
            $('#userManagementList').show();
            $('#upload').show();
            $('#test').show();
        }else if(userLevel == 2){
            $('#reviewNormalList').show();
            $('#reviewErrorList').hide();
            $('#userList').hide();
            $('#userAuditList').hide();
            $('#userManagementList').hide();
            $('#upload').hide();
            $('#test').hide();
        }else if(userLevel == 3){
            $('#reviewNormalList').hide();
            $('#reviewErrorList').show();
            $('#userList').hide();
            $('#userAuditList').hide();
            $('#userManagementList').hide();
            $('#upload').hide();
            $('#test').hide();
        }else{

        }


    });

    $.validator.addMethod("checkPwd", function (value, element, params) {//登陆密码自定义验证
        var checkPwd = /^\w{6,16}$/g;
        return this.optional(element) || (checkPwd.test(value));
    }, "*只允许6-16位英文字母、数字或者下划线！");

    function index_changePwd_updatePwd() {//弹出重置密码模态框
        $("#index_changePwd_Modal").modal("show");
    }


    function confirm() {//点击确认保存重置密码
        var oldPassWord = $('#oldPassWord').val();
        var passWord = $('#passWord').val();
        var confirmPassWord = $('#confirmPassWord').val();
        if(oldPassWord == "" || passWord == "" || confirmPassWord == ""){
            alert("请完善信息后再提交");
            $("#index_changePwd_Modal").modal("show");
        }else{
            $.ajax({
                url: path + "/user/updatePassWord",
                type: "post",
                data: {
                    "oldPassWord" : oldPassWord,
                    "passWord" : passWord,
                    "confirmPassWord" : confirmPassWord
                },
                dataType: 'json',
                async: false,
                success: function (obj) {
                    if(obj.code == 200){
                        alert(obj.message);
                        $("#index_changePwd_Modal").modal("hide");
                    }else{
                        alert(obj.message);
                        $("#index_changePwd_Modal").modal("show");
                    }

                },
                error: function () {
                    $.alertModel("网络超时!获取失败!");
                }
            });
        }
    }


    function gotoURL(uri) {
        if (uri != "" && uri != null && uri != undefined) {
            var thisBody = $("#index_mybody").find("div.active.in");
            $.ajax({
                url: uri,
                //list.html 根据ID、跳转不同的页面
                cache: false,
                success: function (html) {
                    $(thisBody).html(html);
                }
            });

        }
    }


    function dtx_index_close(id) {
        var thisObj = $("#dtx_index_tag_" + id);
        if ($(thisObj).hasClass("active")) {
            var thisObj2 = $(thisObj).next();
            if (thisObj2.length < 1) {
                thisObj2 = $(thisObj).prev();
            }
            $("#myTab").find("li").removeClass("active");
            $("#index_mybody").find("div").removeClass("active");
            $("#index_mybody").find("div").removeClass("in");
            $(thisObj2).find("a").click();
        }
        $("#dtx_index_tag_" + id).remove();
        $("#dtx_index_body_" + id).remove();
    }


</script>
</body>
</html>
