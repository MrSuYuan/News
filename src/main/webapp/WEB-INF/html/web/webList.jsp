<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard - Ace Admin</title>
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
                    <li class="active">web列表</li>
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
                    <br>
                    <div align="center">
                        <span id="nickNameSpan">
                            登录账号：<input type="text" id="loginName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                            公司名称：<input type="text" id="nickName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                            </span>
                        WEB名称：<input type="text" id="webName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        WEB状态：
                        <select id="webStatus" style="width:100px;height:30px">
                            <option value="0">全部</option>
                            <option value="1">未审核</option>
                            <option value="2">驳回</option>
                            <option value="3">正常</option>
                            <option value="4">禁用</option>
                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn btn-primary btn-xs" onclick="selectWebList($('#currentPage').val())">
                            <i class="ace-icon glyphicon glyphicon-search bigger-110"><font size="3">搜索</font></i>
                        </a>
                        <a id="addWeb" class="btn btn-primary btn-xs" onclick="webDetail()">
                            <i class="ace-icon glyphicon bigger-110"><font size="3">添加WEB网站</font></i>
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
                                        <th>WEBID</th>
                                        <th>网站名称</th>
                                        <th>所属用户</th>
                                        <th>域名</th>
                                        <th>创建时间</th>
                                        <%--<th>APP状态</th>
                                        <th id="operating">操作</th>--%>
                                        <th id="adspace">代码位</th>
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
    loading("webList", $('#userName').val());

    //新增WEB网站
    function webDetail() {
        window.location = path + "/webDetail";
    }

    //进入页面直接请求数据
    $(document).ready(function(){

        var selectUserId = sessionStorage.getItem("selectUserId");
        if(selectUserId != null){
            $('#loginName').val(sessionStorage.getItem("selectLoginName"));
            $('#nickName').val(sessionStorage.getItem("selectNickName"));
            sessionStorage.removeItem("selectLoginName");
            sessionStorage.removeItem("selectNickName");
        }

        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();

        if(currentUserLevel == 1 || currentUserLevel == 2){
            $('#adspace').show();
        }else{
            $('#adspace').hide();
        }
        if(currentUserLevel == 3){
            $('#nickNameSpan').hide();
        }
        selectWebList(1);
    });

    //点击搜索数据展示
    function selectWebList(currentPage) {
        var currentUserLevel = $('#currentUserLevel').val();

        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/web/webList",
            type: "post",
            data: {
                "loginName" : $('#loginName').val(),
                "nickName" : $('#nickName').val(),
                "webName" : $('#webName').val(),
                "webStatus" :  $('#webStatus option:selected').val(),
                "currentPage" : currentPage,
                "pageSize" : pageSize
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.webList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.webId+'</td>';
                        html+='<td> '+data.webName+'</td>';
                        html+='<td> '+data.nickName+'</td>';
                        html+='<td> '+data.webUrl+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        // var webStatus = data.webStatus;
                        // if(webStatus == 1){
                        //     html+='<td id="webStatus'+data.webId+'"><span class="label label-white middle">未审核</span></td>';
                        //     html+='<td id="operating'+data.webId+'">' +
                        //         '<button type="button" class="btn btn-minier btn-success" onclick="changeWebStatus('+data.webId+','+4+')">通过</button>' +
                        //         '<button type="button" class="btn btn-minier btn-danger" onclick="changeWebStatus('+data.webId+','+2+')">驳回</button>' +
                        //         '</td>';
                        // }else if(webStatus == 2){
                        //     html+='<td id="webStatus'+data.webId+'"><span class="label label-purple label-white middle">驳回</span></td>';
                        //     html+='<td id="operating'+data.webId+'"><span class="label label-purple label-white middle">WEB未通过审核</span></td>';
                        // }else if(webStatus == 3){
                        //     html+='<td id="webStatus'+data.webId+'"><span class="label label-success label-white middle">正常</span></td>';
                        //     html+='<td id="operating'+data.webId+'">' +
                        //         '<button type="button" class="btn btn-minier btn-danger" onclick="changeWebStatus('+data.webId+','+4+')">禁用</button>' +
                        //         '</td>';
                        // }else if(webStatus == 4){
                        //     html+='<td id="webStatus'+data.webId+'"><span class="label label-danger label-white middle">禁用</span></td>';
                        //     html+='<td id="operating'+data.webId+'">' +
                        //         '<button type="button" class="btn btn-minier btn-success" onclick="changeWebStatus('+data.webId+','+3+')">启用</button>' +
                        //         '</td>';
                        // }else{
                        //     html+='<td><font color="red">状态错误</font></td>';
                        //     html+='<td><font color="red">状态错误</font></td>';
                        // }
                        if(currentUserLevel == 2 || currentUserLevel == 1){
                            html+='<td>' +
                                '<button type=button class="btn btn-minier btn-success" onclick="addAdspace(\''+data.webId+'\')">添加</button>&nbsp;&nbsp;' +
                                '<button type=button class="btn btn-minier btn-success" onclick="seeAdspace(\''+data.webId+'\')">查看</button>' +
                                '</td>';
                        }
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
            selectWebList(page);
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
            selectWebList(page);
        }
    }

    //appStatus 1未审核 2驳回 3正常 4禁用
    function changeWebStatus(webId, webStatus){
        $.ajax({
            url: path + "/web/webStatus",
            type: "post",
            data: {
                "webId" : webId,
                "webStatus" : webStatus
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.code == 200){
                    $('#webStatus'+webId).empty();
                    $('#operating'+webId).empty();

                    if(webStatus == 2){
                        $('#webStatus'+webId).html('<span class="label label-purple label-white middle">驳回</span>');
                        var html='<td id="operating'+webId+'"><span class="label label-purple label-white middle">WEB未通过审核</span></td>';
                        $('#operating'+webId).html(html);

                    }else if(webStatus == 3){
                        $('#webStatus'+webId).html('<span class="label label-success label-white middle">正常</span>');
                        var html='<td id="operating'+webId+'">'+
                            '<button type="button" class="btn btn-minier btn-danger" onclick="changeWebStatus('+webId+','+4+')">禁用</button>'+
                            '</td>';
                        $('#operating'+webId).html(html);

                    }else if(webStatus == 4){
                        $('#webStatus'+webId).html('<span class="label label-danger label-white middle">禁用</span>');
                        var html='<td id="operating'+webId+'">'+
                            '<button type="button" class="btn btn-minier btn-success" onclick="changeWebStatus('+webId+','+3+')">启用</button>'+
                            '</td>';
                        $('#operating'+webId).html(html);

                    }else{
                        $('#webStatus'+webId).html("状态错误");
                        $('#operating'+webId).html("状态错误");
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

    function addAdspace(webId){
        sessionStorage.setItem("webId",webId);
        window.location = path + "/webAdspaceAdd";
    }

    function seeAdspace(webId){
        sessionStorage.setItem("webId",webId);
        window.location = path+"/webAdspaceList";
    }

</script>

</html>
