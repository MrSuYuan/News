<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>修改密码</title>
    <title id="loginTitle"></title>

    <meta name="description" content="User login page" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${ctx}/statics/common/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/statics/common/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
    <!-- text fonts -->
    <link rel="stylesheet" href="${ctx}/statics/common/assets/css/fonts.googleapis.com.css" />
    <!-- ace styles -->
    <link rel="stylesheet" href="${ctx}/statics/common/assets/css/ace.min.css" />
    <link rel="stylesheet" href="${ctx}/statics/common/assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="${ctx}/statics/common/js/main.js" />
    <link id="ICon" rel="Shortcut Icon" href="" type="image/x-icon" />
    <script type="text/javascript" src="${ctx }/statics/common/js/validator/validator.js"></script>
    <script type="text/javascript" src="${ctx }/statics/common/js/validator/utils.js"></script>
    <script type="text/javascript" src="${ctx }/statics/common/js/cnaac/common.js"></script>
    <script src="${ctx}/statics/common/assets/js/jquery-2.1.4.min.js"></script>
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
                            人工审核后台管理系统
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
                                        <i class="ace-icon fa  green"></i> 修 改 密 码
                                    </h5>
                                    <span id="span"></span>
                                    <div class="space-6"></div>
                                    <form action="#" method="post">
                                        <fieldset>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right" style="display: none">
												</span>
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" class="form-control" id="oldPass" autocomplete="off" placeholder="原密码"/>
														<i class="ace-icon fa fa-lock"></i>
												</span>
                                            </label>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right" style="display: none">
												</span>
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" class="form-control" id="newPass" autocomplete="off" placeholder="新密码" />
														<i class="ace-icon fa fa-lock"></i>
												</span>
                                            </label>
                                            <label class="block clearfix">
                                                <span class="block input-icon input-icon-right" style="display: none">
												</span>
                                                <span class="block input-icon input-icon-right">
                                                    <input type="password" class="form-control" id="confirmPass" autocomplete="off" placeholder="确认密码" />
														<i class="ace-icon fa fa-lock"></i>
												</span>
                                            </label>
                                            <div class="space"></div>
                                            <div class="clearfix">
                                                <label class="inline">
                                                </label>
                                                <button type="button" class="width-35 pull-right btn btn-sm btn-primary" onclick="updatePass();">
                                                    <i class="ace-icon fa fa-key"></i>
                                                    <span class="bigger-110">确定</span>
                                                </button>
                                            </div>
                                            <div class="space-4"></div>
                                        </fieldset>
                                    </form>
                                    <div class="space-6"></div>
                                </div>
                                <div class="toolbar clearfix">
                                    <div></div>
                                    <div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="${ctx}/statics/common/js/jquery-3.3.1.min.js"></script>
<script src="${ctx}/statics/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
    var path = "${ctx}";

    function updatePass() {
        var oldPass = $('#oldPass').val();
        var newPass = $('#newPass').val();
        var confirmPass = $('#confirmPass').val();

        if(oldPass == ""){
            alert("原密码不能为空");
            return false;
        }
        if(newPass == ""){
            alert("新密码不能为空");
            return false;
        }
        if(confirmPass == ""){
            alert("确认密码不能为空");
            return false;
        }
        if(newPass != confirmPass){
            alert("两次输入的密码不相同");
            return false;
        }
        $.ajax({
            url: path + "/user/updatePassWord",
            type: "post",
            data: {
                "oldPassWord" : oldPass,
                "passWord" : newPass,
                "confirmPassWord" : confirmPass
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    alert(obj.message);
                    window.location.href = path + "/login";
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                $.alertModel("网络超时!获取失败!");
            }
        });
    }

</script>

</body>
</html>
