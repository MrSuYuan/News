<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>创建广告位</title>
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
                    <li class="active">创建广告位</li>
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
                    <input type="hidden" id="appId">
                    <div>
                        <table style="font-size: 14px">
                            <tr height = "50" id="spaceIdT">
                                <td align = "right">广告位ID:&nbsp;&nbsp;</td>
                                <td width="300"><input type="text" size="35" id="spaceId" name="spaceId" placeholder="请输入广告位ID"><font color="red">&nbsp;&nbsp;*</font></td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">广告位名称:&nbsp;&nbsp;</td>
                                <td width="300"><input type="text" size="35" id="spaceName" name="spaceName" placeholder="广告位名称"><font color="red">&nbsp;&nbsp;*</font></td>
                            </tr>
                            <tr height = "50" id="nickNameT">
                                <td align = "right">广告位宽度:&nbsp;&nbsp;</td>
                                <td width="300"><input type="text" size="35" id="width" name="width" placeholder="请输入广告位宽度"><font color="red">&nbsp;&nbsp;*</font></td>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">广告位高度:&nbsp;&nbsp;</td>
                                <td width="300"><input type="text" size="35" id="height" name="height" placeholder="请输入广告位高度"><font color="red">&nbsp;&nbsp;*</font></td>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">广告位类型:&nbsp;&nbsp;</td>
                                <td width="300">
                                    <select style="width: 276px;height: 34px" id="spaceType">
                                        <option value="0">请选择</option>
                                        <option value="1">横幅</option>
                                        <option value="2">开屏</option>
                                        <option value="3">插屏</option>
                                        <option value="4">信息流</option>
                                        <option value="5">激励视频</option>
                                    </select>
                                    <font color="red">&nbsp;&nbsp;*</font>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td></td>
                                <td>
                                    <input type="button" id="send" value="确定" onclick="createAdspace()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="button" id="back" value="重置" onclick="reset()">
                                </td>
                            </tr>
                        </table>
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
    loading("appAdspaceAdd", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        var appId =  sessionStorage.getItem("appId");
        $('#appId').val(appId);
        sessionStorage.removeItem("appId");
        $('#spaceIdT').hide();
    });


    //创建广告位信息
    function createAdspace(){
        //收集参数
        var appId = $('#appId').val();
        var spaceName = $('#spaceName').val();
        var width = $('#width').val();
        var height = $('#height').val();
        var spaceType = $('#spaceType').val();
        if(""==appId || ""==spaceName || ""==width || ""==height || 0==spaceType){
            alert("请将信息填写完毕再提交");
        }else{
            //保存代码位信息
            $.ajax({
                url: path + "/app/createAdspace",
                data:{
                    "appId" : appId,
                    "spaceName" : spaceName,
                    "width" : width,
                    "height" : height,
                    "spaceType" : spaceType
                },
                type: "post",
                dataType: 'json',
                async: false,
                success: function (data) {
                    if(data.code == 200){
                        alert(data.message);
                        window.location = path + "/appAdspaceList";
                    }else if(data.code == 300){
                        alert(data.message);
                        window.location = path + "/login";
                    }else{
                        alert(data.message);
                    }

                },
                error: function () {
                    alert("Error");
                }
            });
        }
    }

</script>

</html>
