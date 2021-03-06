<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>APP详情</title>
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
                    <li class="active">app详情</li>
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
                    <div>
                        <table style="font-size: 14px">
                            <tr height = "50" id="appIdT">
                                <td align = "right">应用ID:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="appId" name="userName" placeholder="应用ID"></td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">应用名称:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="appName" name="loginEmail" placeholder="请输入应用名称"></td>
                            </tr>
                            <tr height = "50" id="nickNameT">
                                <td align = "right">归属用户:&nbsp;&nbsp;</td>
                                <td width="250">
                                    <span id="beLongUser"></span>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">所属行业:&nbsp;&nbsp;</td>
                                <td width="250">
                                    <span id="industy"></span>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">适用系统:&nbsp;&nbsp;</td>
                                <td width="250">
                                    <select style="width: 276px;height: 34px" id="platform">
                                        <option value="0">请选择</option>
                                        <option value="1">Android</option>
                                        <option value="2">IOS</option>
                                        <option value="3">Windows</option>
                                    </select>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">适应终端:&nbsp;&nbsp;</td>
                                <td width="250">
                                    <select style="width: 276px;height: 34px" id="terminal">
                                        <option value="0">请选择</option>
                                        <option value="1">手机</option>
                                        <option value="2">平板</option>
                                        <option value="3">电脑</option>
                                    </select>
                                </td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">下载地址:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="downloadlink" placeholder="请输下载地址"></td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">程序主包名:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="packageName" placeholder="请输入程序主包名"></td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">应用版本:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="version" placeholder="请输入应用版本"></td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">关键词:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="keyWords" placeholder="请输入关键词"></td>
                            </tr>
                            <tr height = "50">
                                <td align = "right">应用简介:&nbsp;&nbsp;</td>
                                <td width="250"><input type="text" size="35" id="description" placeholder="请输入应用简介"></td>
                            </tr>
                            <tr height = "50">
                                <td></td>
                                <td>
                                    <input type="button" id="send" value="确定" onclick="createApp()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
    loading("appDetail", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){

        //展示分类信息
        industy();

        //普通用户登录状态下,不选择所属用户
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel == 3){
            $('#nickNameT').hide();
        }else{
            //归属用户信息
            beLongUser();
        }

        var appId =  sessionStorage.getItem("appId");
        //session里没有appId的时候是添加app信息
        if(null == appId){
            //隐藏id
            $('#appIdT').hide();
            //session里有appId时,是修改app信息
        }else{
            $('#appUuid').val(appUuid);
            sessionStorage.removeItem("appUuid");
            appName(appUuid);
        }
    });

    //查看app分类
    function industy(){
        $.ajax({
            url: path + "/app/industy",
            type: "Post",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if(data.code == 200){
                    var html = "";
                    //大类部分
                    html += '<select id="rootType" style="width: 134px;height: 34px" onchange="changeType(this)">';
                    html += '<option value="0">全部</option>';
                    var rootList = data.result.rootType;
                    for (var i=0;i<rootList.length;i++){
                        html += '<option value="'+rootList[i].id+'">'+rootList[i].name+'</option>';
                    }
                    html += '</select>&nbsp;&nbsp;';

                    var subList = data.result.subType;
                    //小类部分
                    html += '<select id="subType" style="width: 134px;height: 34px" id="subType">';
                    html += '<option>全部</option>';
                    for (var i=0;i<subList.length;i++){
                        html += '<option value="'+subList[i].id+'?'+subList[i].parentId+'">'+subList[i].name+'</option>';
                    }
                    html += '</select>';

                    $('#industy').html(html);
                }

            },
            error: function () {
                alert("Error");
            }
        });
    }

    //级联菜单根据大类变小类
    function changeType(obj){
        //获取id
        var parentId = obj.value;
        var subTypeList = $("#subType option");
        for(var i = 0; i<subTypeList.length;i++){
            var subType = subTypeList[i].value.split("?")[1];
            if(parentId != subType){
                var v = subTypeList[i].value;
                $("select option[value= '"+v+"']").hide();
            }else{
                var v = subTypeList[i].value;
                $("select option[value= '"+v+"']").show();
            }
        }
    }

    //查看归属用户
    function beLongUser(){
        $.ajax({
            url: path + "/app/beLongUser",
            type: "Post",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if(data.code == 200){
                    var html = "";
                    html += '<select id="beLongUserId" style="width: 276px;height: 34px">';
                    html += '<option value="0">请选择</option>';
                    var userList = data.result;
                    for(var i=0;i<userList.length;i++){
                        html += '<option value="'+userList[i].userId+'">'+userList[i].nickName+'</option>';
                    }
                    html += '</select>';
                    $('#beLongUser').html(html);
                }

            },
            error: function () {
                alert("Error");
            }
        });
    }

    //创建app信息
    function createApp(){
        //收集参数
        var currentUserLevel = $('#currentUserLevel').val();
        var currentUserId = $('#currentUserId').val();
        var appName = $('#appName').val();
        var downloadlink = $('#downloadlink').val();
        var rootType = $('#rootType').val();
        var subType = $('#subType').val().split("?")[0];
        var platform = $('#platform').val();
        var terminal = $('#terminal').val();
        var packageName = $('#packageName').val();
        var version = $('#version').val();
        var description = $('#description').val();
        var keyWords = $('#keyWords').val();
        var userId;
        if(currentUserLevel == 3){
            userId = currentUserId;
        }else{
            userId = $('#beLongUserId').val();
        }
        if(null==appName || null==downloadlink || 0==rootType || 0==subType || 0==platform || 0==terminal ||
            ""==packageName || ""==version || ""==description || ""==keyWords || null==userId){
            alert("请将信息填写完毕再提交");
        }else{
            //保存app信息
            $.ajax({
                url: path + "/app/createApp",
                data:{
                    "appName" : appName,
                    "downloadlink" : downloadlink,
                    "rootType" : rootType,
                    "subType" : subType,
                    "platform" : platform,
                    "terminal" : terminal,
                    "packageName" : packageName,
                    "version" : version,
                    "description" : description,
                    "keyWords" : keyWords,
                    "userId" : userId,
                    "currentUserLevel" : currentUserLevel
                },
                type: "post",
                dataType: 'json',
                async: false,
                success: function (data) {
                    if(data.code == 200){
                        alert(data.message);
                        window.location = path + "/appList";
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
