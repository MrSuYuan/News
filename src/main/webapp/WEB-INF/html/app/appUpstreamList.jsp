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
                    <li class="active">上游信息</li>
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
                            <div align="center">
                                备用搜索区：<input type="text" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                                备用搜索区状态：
                                <select id="appStatus" style="width:100px;height:30px">
                                    <option value="2">全部</option>
                                    <option value="1">正常</option>
                                    <option value="0">禁用</option>
                                </select>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a class="btn btn-primary btn-xs" onclick="selectAppList($('#currentPage').val())">
                                    <i class="ace-icon glyphicon glyphicon-search bigger-110"><font size="3">搜索</font></i>
                                </a>
                                <a href="${ctx}/appUpstreamAdd" class="btn btn-primary btn-xs" onclick="selectUpstreamIdList(1)">
                                    <i class="ace-icon glyphicon bigger-110"><font size="3">添加新上游</font></i>
                                </a>
                                <a class="btn btn-primary btn-xs" onclick="upstreamIdList('')">
                                    <i class="ace-icon glyphicon bigger-110"><font size="3">全部广告位</font></i>
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
                                                <th>编号</th>
                                                <th>名称</th>
                                                <th>简称</th>
                                                <th>创建时间</th>
                                                <th>上游状态</th>
                                                <th>操作</th>
                                                <th>广告位</th>
                                            </tr>
                                            </thead>
                                            <tbody id="coll_list_begin_body">
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- 页面设置 -->
                                    <div class="modal-footer no-margin-top">
                                        <div class="dataTables_paginate paging_simple_numbers">
                                            <ul class="pagination">
                                                <li>
                                                    <a onclick="lastPageData()" title="上一页">
                                                        <i class="ace-icon fa fa-angle-double-left"></i>
                                                    </a>
                                                </li>
                                                <li class="active">
                                                    <a title="当前页">
                                                        <span id="currentPage"></span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a onclick="nextPageData()" title="下一页">
                                                        <i class="ace-icon fa fa-angle-double-right"></i>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a>
                                                        共&nbsp;<span id="sumPage"></span>&nbsp;页&nbsp;|&nbsp;
                                                        共&nbsp;<span id="sumData"></span>&nbsp;条数据
                                                    </a>
                                                </li>
                                                <li>
                                                    <a>
                                                        <span>页面容量</span>
                                                    </a>
                                                    <input type="text" id="pageSize" style="width: 33.44px;height: 32.4px">
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
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
    loading("appUpstreamList", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        selectAppList(1);
    });

    //点击搜索数据展示
    function selectAppList(currentPage) {
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/app/appUpstreamTypeList",
            type: "post",
            data: {
                //"appStatus" :  $('#appStatus option:selected').val(),
                "currentPage" : currentPage,
                "pageSize" : pageSize
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.list;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.type+'</td>';
                        html+='<td> '+data.name+'</td>';
                        html+='<td> '+data.shortName+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        var status = data.status;
                        if(status == 0){
                            html+='<td id="status'+data.id+'"><span class="label label-danger label-white middle">禁用</span></td>';
                            html+='<td id="operating'+data.id+'"><button type="button" class="btn btn-minier btn-success" onclick="upstreamStatus('+data.id+',1)">启用</button></td>';
                        }else if(status == 1){
                            html+='<td id="status'+data.id+'"><span class="label label-success label-white middle">正常</span></td>';
                            html+='<td id="operating'+data.id+'"><button type="button" class="btn btn-minier btn-danger" onclick="upstreamStatus('+data.id+',0)">禁用</button></td>';
                        }else{
                            html+='<td><font color="red">状态错误</font></td>';
                            html+='<td><font color="red">状态错误</font></td>';
                        }
                        html+='<td>' +
                            '<div class="hidden-sm hidden-xs btn-group">' +
                            '<button type="button" class="btn btn-xs btn-primary" onclick="upstreamIdList(\''+data.type+'\')">' +
                            '<i class="ace-icon glyphicon bigger-110">查看广告位</i>' +
                            '</button>' +
                            '</div>' +
                            '</td>';
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                    //更新页码
                    $('#currentPage').html(obj.result.currentPage);
                    $('#pageSize').val(obj.result.pageSize);
                    $('#sumPage').html(obj.result.sumPage);
                    $('#sumData').html(obj.result.sumData);
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

    //上一页
    function lastPageData() {
        var page = parseInt($('#currentPage').text());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            selectAppList(page);
        }
    }

    //下一页
    function nextPageData() {
        var page = parseInt($('#currentPage').text());
        var sumPage = parseInt($('#sumPage').text());
        if(page == sumPage){
            alert("当前是最后一页");
        }else{
            var page = page + 1;
            selectAppList(page);
        }
    }

    //status 1正常 0禁用
    function upstreamStatus(id, status){
        $.ajax({
            url: path + "/app/updateUpstreamStatus",
            type: "post",
            data: {
                "id" : id,
                "status" : status
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.code == 200){
                    $('#status'+id).empty();
                    $('#status'+id).empty();
                    if(status == 0){
                        $('#status'+id).html('<span class="label label-danger label-white middle">禁用</span>');
                        var html='<td id="operating'+id+'">'+
                            '<button type="button" class="btn btn-minier btn-success" onclick="upstreamStatus(\''+id+'\','+1+')">启用</button>'+
                            '</td>';
                        $('#operating'+id).html(html);

                    }else if(status == 1){
                        $('#status'+id).html('<span class="label label-success label-white middle">正常</span>');
                        var html='<td id="operating'+id+'">'+
                            '<button type="button" class="btn btn-minier btn-danger" onclick="upstreamStatus(\''+id+'\','+0+')">禁用</button>'+
                            '</td>';
                        $('#operating'+id).html(html);
                    }

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

    function upstreamIdList(type){
        sessionStorage.setItem("type",type);
        window.location = path+"/appUpstreamIdList";
    }

</script>

</html>
