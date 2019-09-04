<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>登录</title>
    <title id="loginTitle"></title>

    <meta name="description" content="User login page" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
    <!-- text fonts -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/fonts.googleapis.com.css" />
    <!-- ace styles -->
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/js/main.js" />
    <link id="ICon" rel="Shortcut Icon" href="" type="image/x-icon" />
    <script type="text/javascript" src="${ctx }/static/common/js/manage/login.js"></script>
    <script type="text/javascript" src="${ctx }/static/common/js/validator/validator.js"></script>
    <script type="text/javascript" src="${ctx }/static/common/js/validator/utils.js"></script>
    <script type="text/javascript" src="${ctx }/static/common/js/manage/common.js"></script>
</head>

<body class="login-layout blur-login">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="space-30"></div>
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container">
                    <div class="center">
                        <h2 class="light-blue" id="id-company-text">
                            点星后台管理系统
                        </h2>
                    </div>
                    <div class="space-30"></div>
                    <div class="space-6"></div>

                    <div class="logindiv" id="logindiv">
                        <div id="login-box"
                             class="login-box visible widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h5 class="header blue lighter bigger"
                                        style="text-align: center;">
                                        <i class="ace-icon fa  green"></i> 尊 敬 的 用 户 您 好
                                    </h5>
                                    <span id="span"></span>
                                    <div class="space-6"></div>
                                    <form id="loginForm">
                                        <fieldset>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right">
                                                    <input required email loginvalidation type="text" class="form-control" id="loginName" name="loginName" placeholder="用户账号" />
                                                    <i class="ace-icon fa fa-user"></i>
												</span>
                                            </label>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right" style="display: none">
												</span>
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" class="form-control" id="passWord" name="passWord" autocomplete="off" placeholder="用户密码" />
														<i class="ace-icon fa fa-lock"></i>
												</span>
                                            </label>
                                            <li style="list-style-type: none;">
                                                <span> <input required loginvalidation type="text" id="captcha"
                                                              name="captcha" placeholder="验证码" class="text-style" style="width: 50%;" maxlength="4" />
                                                <img id="captchaImg" src="${ctx}/image" title="点击刷新" align="absmiddle" onclick="this.src='${ctx}/image?'+(new Date()).getTime()" style="width:100px;height:35px;float:right;" />
												</span>
                                            </li>
                                            <div class="space"></div>
                                            <div class="clearfix">
                                                <label class="inline">
                                                    <input id="dtx_manger_saveMima" type="checkbox" />
                                                    <span class="lbl">记住密码</span>
                                                </label>
                                                <button type="button" class="width-35 pull-right btn btn-sm btn-primary" id="loginbtn" name="loginbtn" onclick="submitLogin();">
                                                    <i class="ace-icon fa fa-key"></i>
                                                    <span class="bigger-110">登录</span>
                                                </button>
                                            </div>
                                            <div class="space-4"></div>
                                        </fieldset>
                                    </form>

                                    <div class="space-6"></div>
                                </div>
                                <!-- /.widget-main -->

                                <div class="toolbar clearfix">
                                    <div></div>
                                    <div></div>
                                </div>
                            </div>
                            <!-- /.widget-body -->
                        </div>

                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.main-content -->
    </div>
    <!-- /.main-container -->
</div>


<script src="${ctx}/static/common/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/static/common/js/jquery.cookie.js"></script>

</body>
</html>
