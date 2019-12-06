<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>个人中心</title>
    <meta name="description" content="3 styles with inline editable feature" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/jquery-ui.custom.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/jquery.gritter.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/select2.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-datepicker3.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap-editable.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/fonts.googleapis.com.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-part2.min.css" class="ace-main-stylesheet" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-skins.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-ie.min.css" />
    <script src="${ctx}/static/common/assets/js/ace-extra.min.js"></script>
    <script src="${ctx}/static/common/assets/js/html5shiv.min.js"></script>
    <script src="${ctx}/static/common/assets/js/respond.min.js"></script>

</head>

<body class="no-skin">

<!-- 页面头部 -->
<div id="navbar" class="navbar navbar-default ace-save-state">
</div>
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
                    <li class="active">个人中心</li>
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
                        <div class="clearfix">
                            <div class="pull-right">
                                <span class="green middle bolder"> &nbsp;</span>
                                <div class="btn-toolbar inline middle no-margin">
                                    <div data-toggle="buttons" class="btn-group no-margin">
                                        <label class="btn btn-sm btn-yellow active">
                                            <span class="bigger-110">基本信息</span>

                                            <input type="radio" value="1" />
                                        </label>

                                        <label class="btn btn-sm btn-yellow">
                                            <span class="bigger-110">修改密码</span>

                                            <input type="radio" value="3" />
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="hr dotted"></div>

                        <!-- 展示个人资料 -->
                        <div>
                            <div id="user-profile-1" class="user-profile row">
                                <div class="col-xs-12 col-sm-3 center">
                                    <div>
                                        <span class="profile-picture">
                                            <img id="avatar" class="editable img-responsive" alt="Alex's Avatar" src="${ctx}/static/common/assets/images/avatars/profile-pic.jpg" />
                                        </span>
                                        <div class="space-4"></div>
                                        <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                            <div class="inline position-relative">
                                                <a href="#" class="user-title-label dropdown-toggle" data-toggle="dropdown">
                                                    <i class="ace-icon fa fa-circle light-green"></i>
                                                    &nbsp;
                                                    <span class="white">WELCOME</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="space-6"></div>
                                    <div class="profile-contact-info">
                                        <div class="space-6"></div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-9">
                                    <div class="space-12"></div>
                                    <div class="profile-user-info profile-user-info-striped">
                                        <div class="profile-info-row">
                                            <div class="profile-info-name">  </div>
                                            <div class="profile-info-value">
                                                <span class="editable">alexdoe</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> Location </div>
                                            <div class="profile-info-value">
                                                <i class="fa fa-map-marker light-orange bigger-110"></i>
                                                <span class="editable" id="country">Netherlands</span>
                                                <span class="editable" id="city">Amsterdam</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> Age </div>
                                            <div class="profile-info-value">
                                                <span class="editable" id="age">38</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> Joined </div>
                                            <div class="profile-info-value">
                                                <span class="editable" id="signup">2010/06/20</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> Last Online </div>
                                            <div class="profile-info-value">
                                                <span class="editable" id="login">3 hours ago</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> About Me </div>
                                            <div class="profile-info-value">
                                                <span class="editable" id="about">Editable as WYSIWYG</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="space-20"></div>
                                </div>
                            </div>
                        </div>

                        <!-- 编辑资料区 -->
                        <div class="hide">
                            <div id="user-profile-3" class="user-profile row">
                                <div class="col-sm-offset-1 col-sm-10">
                                    <div class="space"></div>

                                    <form class="form-horizontal">
                                        <div class="tabbable">
                                            <ul class="nav nav-tabs padding-16">
                                                <li>
                                                    <a data-toggle="tab" href="#edit-password">
                                                        <i class="blue ace-icon fa fa-key bigger-125"></i>
                                                        修改密码
                                                    </a>
                                                </li>
                                                <%--<li class="active">
                                                    <a data-toggle="tab" href="#edit-basic">
                                                        <i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
                                                        Basic Info
                                                    </a>
                                                </li>--%>
                                            </ul>

                                            <div class="tab-content profile-edit-tab-content">
                                                <%--<div id="edit-basic" class="tab-pane in active">

                                                </div>--%>
                                                <div id="edit-password" class="tab-pane in active">
                                                    <div class="space-10"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right" for="oldPassWord">原密码</label>
                                                        <div class="col-sm-9">
                                                            <input type="password" id="oldPassWord" />
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right" for="passWord">新密码</label>
                                                        <div class="col-sm-9">
                                                            <input type="password" id="passWord" />
                                                        </div>
                                                    </div>
                                                    <div class="space-4"></div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label no-padding-right" for="confirmPassWord">确认密码</label>
                                                        <div class="col-sm-9">
                                                            <input type="password" id="confirmPassWord" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="clearfix form-actions">
                                            <div class="col-md-offset-3 col-md-9">
                                                <button class="btn btn-info" type="button" onclick="confirm()">
                                                    <i class="ace-icon fa fa-check bigger-110"></i>
                                                    保存
                                                </button>

                                                &nbsp; &nbsp;
                                                <button class="btn" type="reset">
                                                    <i class="ace-icon fa fa-undo bigger-110"></i>
                                                    重置
                                                </button>
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


<script src="${ctx}/static/manage/index/template.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-2.1.4.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
    if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="${ctx}/static/common/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/static/common/assets/js/excanvas.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-ui.custom.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.gritter.min.js"></script>
<script src="${ctx}/static/common/assets/js/bootbox.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.easypiechart.min.js"></script>
<script src="${ctx}/static/common/assets/js/bootstrap-datepicker.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.hotkeys.index.min.js"></script>
<script src="${ctx}/static/common/assets/js/bootstrap-wysiwyg.min.js"></script>
<script src="${ctx}/static/common/assets/js/select2.min.js"></script>
<script src="${ctx}/static/common/assets/js/spinbox.min.js"></script>
<script src="${ctx}/static/common/assets/js/bootstrap-editable.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-editable.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.maskedinput.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace.min.js"></script>
<script type="text/javascript">
    var path = "${ctx}";
</script>
<!-- 加载预加载部分,头部和左导航栏 -->
<script type="text/javascript">
    loading("userCenter",$('#userName').val());

    jQuery(function($) {
        $.fn.editable.defaults.mode = 'inline';
        $.fn.editableform.loading = "<div class='editableform-loading'><i class='ace-icon fa fa-spinner fa-spin fa-2x light-blue'></i></div>";
        $.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="ace-icon fa fa-check"></i></button>'+
            '<button type="button" class="btn editable-cancel"><i class="ace-icon fa fa-times"></i></button>';

        //show the user info on right or left depending on its position
        $('#user-profile-2 .memberdiv').on('mouseenter touchstart', function(){
            var $this = $(this);
            var $parent = $this.closest('.tab-pane');
            var off1 = $parent.offset();
            var w1 = $parent.width();
            var off2 = $this.offset();
            var w2 = $this.width();
            var place = 'left';
            if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) place = 'right';
            $this.find('.popover').removeClass('right left').addClass(place);
        }).on('click', function(e) {
            e.preventDefault();
        });

        //change profile
        $('[data-toggle="buttons"] .btn').on('click', function(e){
            var target = $(this).find('input[type=radio]');
            var which = parseInt(target.val());
            $('.user-profile').parent().addClass('hide');
            $('#user-profile-'+which).parent().removeClass('hide');
        });
    });

    function confirm() {//点击确认保存重置密码
        var oldPassWord = $('#oldPassWord').val();
        var passWord = $('#passWord').val();
        var confirmPassWord = $('#confirmPassWord').val();
        if(oldPassWord == "" || passWord == "" || confirmPassWord == ""){
            alert("请完善信息后再提交");
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
                    }else{
                        alert(obj.message);
                    }
                },
                error: function () {
                    $.alertModel("网络超时!获取失败!");
                }
            });
        }
    }

</script>

</body>

</html>
