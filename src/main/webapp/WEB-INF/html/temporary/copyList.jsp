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

    <!-- 百度 -->
    <link rel="icon" href=https://mssp.baidu.com/bqt/favicon.ico>
    <link rel="stylesheet" href="https://mssp.baidu.com/bqt/nprogress/nprogress.css">
    <title>百青藤</title>
    <link href="${ctx}/static/baidu/copy/1.css" rel="preload" as="style">
    <link href="${ctx}/static/baidu/copy/2.css" rel="preload" as="style">
    <link href="${ctx}/static/baidu/copy/3.css" rel="preload" as="style">
    <link href="${ctx}/static/baidu/copy/1.js" rel="preload" as="script">
    <link href="${ctx}/static/baidu/copy/2.js" rel="preload" as="script">
    <link href="${ctx}/static/baidu/copy/3.js" rel="preload" as="script">
    <link href="${ctx}/static/baidu/copy/1.css" rel="stylesheet">
    <link href="${ctx}/static/baidu/copy/2.css" rel="stylesheet">
    <link href="${ctx}/static/baidu/copy/3.css" rel="stylesheet">
    <style type="text/css">  .echarts { width: 600px; height: 400px; } </style>
</head>

<body class="no-skin">

<!-- 这俩也是百度 -->
<script src="https://hm.baidu.com/hm.js?776949f88324f6b5ac7dfac51763a596"></script>
<script src="https://mssp.baidu.com/bqt/nprogress/nprogress.js"></script>

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
                    <li class="active">Dashboard</li>
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
                <div id="app" class="app-view muses-co">
                    <div class="base-view list-view adp-report-view" style="top:80px">
                        <div class="list-header">
                            <div class="list-summary"></div>
                            <form>
                                <div id="12333" class="left">
                                    <%--<select id="userStatus" style="width:100px;height:30px">
                                        <option value="0">代码位</option>
                                        <option value="1">正常</option>
                                        <option value="2">禁用</option>
                                    </select>--%>
                                    <input type="text" id="adId" placeholder="广告位ID" style="height: 34.2px">&nbsp;&nbsp;&nbsp;
                                    <input type="date" id="startTime">&nbsp;&nbsp;&nbsp;-<input type="date" id="endTime">
                                    <a class="btn btn-primary btn-xs" onclick="selectReportList($('#currentPage').val())">
                                        <i class="ace-icon glyphicon glyphicon-search bigger-110"><font size="3">查询</font></i>
                                    </a>
                                </div>
                            </form>
                        </div>
                        <table ui="slim alt" class="veui-table">

                            <colgroup>
                                <col width="190">
                                <col width="150">
                                <col width="160">
                                <col width="120">
                                <col width="120">
                                <col width="120">
                                <col width="130">
                                <col width="120">
                                <col width="120">
                            </colgroup>

                            <thead>
                            <tr>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">应用</div>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">广告展现量</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">预计收入</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">到访PV</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">详情页PV</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">点击量</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">eCPM</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">点击率</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th scope="col" role="columnheader">
                                    <div class="veui-table-cell">CPC</div>
                                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                                        </svg>
                                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                                        </svg>
                                    </svg>
                                </th>
                                <th width="100px">
                                    <div>日期</div>
                                </th>
                            </tr>
                            </thead>
                            <tbody id="coll_list_begin_body">
                            </tbody>

                        </table>
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
            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->
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
    loading("copyList", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        selectReportList(1);
    });

    //点击搜索数据展示
    function selectReportList(currentPage) {
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        var startTime = $('#startTime').val();
        var endTime = $('#endTime').val();
        var adId = $('#adId').val();
        $.ajax({
            url: path + "/temporary/copyList",
            type: "post",
            data: {
                "currentPage" : currentPage,
                "pageSize" : pageSize,
                "adId" : adId,
                "startTime" : startTime,
                "endTime" : endTime
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.list;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr class>';
                        html+='<td role="cell"><div class="veui-table-cell"><div class="adposition"><div><a class="app-name-text">'+data.adName+'</a></div><div><a class="app-name-text">ID: '+data.adId+'</a></div></div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+parseFloat(data.lookPv).toLocaleString()+'</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+data.income+'</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+parseFloat(data.accessPv).toLocaleString()+'</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+parseFloat(data.detailPv).toLocaleString()+'</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+parseFloat(data.clickNum).toLocaleString()+'</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+data.ecpm2+'</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+data.clickProbability2+'%</div></div></td>';
                        html+='<td role="cell"><div class="veui-table-cell"><div>'+data.cpc2+'</div></div></td>';
                        html+='<td role="cell" width="100px"><div>'+data.createTime2+'</div></td>';
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
            selectReportList(page);
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
            selectReportList(page);
        }
    }

</script>

</html>
