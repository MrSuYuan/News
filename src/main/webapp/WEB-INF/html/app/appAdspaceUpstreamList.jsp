<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>上游列表</title>
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
                    <li class="active">上游列表</li>
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
                <input type="hidden" id="spaceId">
                <form action="#" method="post">
                    <div>
                        <table width="100%" style="font-size: 14px">
                            <tr width="100%" height = "50">
                                <td width="25%">APP名称:&nbsp;&nbsp;<span id="appName"></span></td>
                                <td width="25%">广告位名称:&nbsp;&nbsp;<span id="spaceName"></span></td>
                                <td width="50%" align="right"><input type="button" id="submitZ" value="确定" onclick="updateAssign()"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="table-header"></div>
                            <div>
                                <table id="dynamic-table"
                                       class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr style="height: 50px">
                                        <th>广告位ID</th>
                                        <th>上游广告位ID</th>
                                        <th>上游APPID</th>
                                        <th>上游平台</th>
                                        <th>分流比例</th>
                                        <th>创建时间</th>
                                        <th id="statistics">收益统计</th>
                                        <th id="operating">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="coll_list_begin_body">
                                    </tbody>
                                </table>
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
    loading("appAdspaceUpstreamList", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();

        var spaceId =  sessionStorage.getItem("spaceId");
        $('#spaceId').val(spaceId);
        //sessionStorage.removeItem("spaceId");

        if(currentUserLevel == 3){
            alert("权限不足");
        }else if(currentUserLevel == 1) {
            // $('#statistics').hide();
            // $('#operating').hide();
            appUpstreamList();
            adspace(spaceId);
        }else{
            appUpstreamList();
            adspace(spaceId);
        }

    });

    //广告位基础信息
    function adspace(spaceId){
        $.ajax({
            url: path + "/app/adspaceDetail",
            data:{
                "spaceId" : spaceId
            },
            type: "post",
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.code == 200){
                    var result = data.result;
                    $('#appName').html(result.appName);
                    $('#spaceName').html(result.spaceName);
                }else{
                    alert(data.message);
                }
            },
            error: function () {
                alert("Error");
            }
        });
    }

    //页面数据展示
    function appUpstreamList() {

        var currentUserLevel = $('#currentUserLevel').val();
        $.ajax({
            url: path + "/app/appUpstreamList",
            type: "post",
            data: {
                "spaceId" : $('#spaceId').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr  id="tr'+data.upstreamId+'" style="height: 40px" class = "uTr">';
                        html+='<td> '+data.spaceId+'</td>';
                        html+='<td> '+data.upstreamId+'</td>';
                        html+='<td> '+data.upstreamAppId+'</td>';
                        html+='<td> '+data.name+'<input type="hidden" size="5" name="upstreamType" value="'+data.upstreamType+'"></td>';
                        html+='<td align="center"><input type="text" size="5" name="probability" value="'+data.probability+'"></td>';
                        html+='<td> '+data.create_Time+'</td>';
                        //if(currentUserLevel == 2){
                        html+='<td><button type="button" onclick="addAppStatistice(\''+data.upstreamId+'\')">添加收益统计</button></td>';
                        html+='<td><button type="button" onclick="appUpstreamIdEdit(\''+data.upstreamId+'\')">更换上游ID</button>&nbsp;';
                        html+='<input type="button" value="解除绑定关系" onclick="deleteUpstreamId(\''+data.upstreamId+'\')"></td>';
                        //}
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
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

    //删除id
    function deleteUpstreamId(upstreamId){

        $.ajax({
            url: path + "/app/deleteUpstreamId",
            type: "post",
            data: {
                "upstreamId" : upstreamId
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    //将这一行隐藏
                    $('#tr'+upstreamId).hide();

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

    //正式服确认提交
    function updateAssign(){

        var objs = [];
        $('.uTr').each(function(index,val){
            var obj = {
                upstreamType : $(val).find('input[name=upstreamType]').val(),
                probability : $(val).find('input[name=probability]').val(),
            }
            objs.push(obj)
        })
        $.ajax({
            url: path + "/app/assignSubmit",
            type: "post",
            data : {
                "spaceId" : $('#spaceId').val(),
                "list" : JSON.stringify(objs)
            },
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.code == 200){
                    alert(data.message);

                }else if(data.code == "300"){
                    alert(data.message);
                    window.location = path + "/login";
                }else{
                    alert(data.message);
                }

            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    function addAppStatistice(upstreamId) {
        sessionStorage.setItem("upstreamId",upstreamId);
        window.location = path + "/appStatisticsAdd";
    }

    function appUpstreamIdEdit(upstreamId) {
        sessionStorage.setItem("upstreamId",upstreamId);
        window.location = path + "/appUpstreamIdEdit";
    }

</script>

</html>
