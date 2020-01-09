<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>广告位列表</title>
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
                    <li class="active">广告位列表</li>
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
                        WEB名称：<input type="text" id="webName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        广告位名称：<input type="text" id="spaceName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
                        终端：
                        <select id="terminal" style="width:100px;height:30px">
                            <option value="0">请选择</option>
                            <option value="1">PC</option>
                            <option value="2">WAP</option>
                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                        广告位类型：
                        <select id="spaceType" style="width:100px;height:30px">
                            <option value="0">请选择</option>
                            <option value="1">固定块</option>
                            <option value="2">右下浮</option>
                            <option value="3">对联</option>
                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn btn-primary btn-xs" onclick="webAdspaceList($('#currentPage').val())">
                            <i class="ace-icon glyphicon glyphicon-search bigger-110"><font size="3">搜索</font></i>
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
                                        <th>广告位ID</th>
                                        <th>广告位名称</th>
                                        <th>WEB名称</th>
                                        <th>终端</th>
                                        <th>类型</th>
                                        <th>宽度</th>
                                        <th>高度</th>
                                        <th>创建时间</th>
                                        <th id="updateTime">更新时间</th>
                                        <th>ID状态</th>
                                        <th id="operating">操作</th>
                                        <th id="statistics" style="width: 140px">数据统计</th>
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

                <!-- 设置模态框 -->
                <div class="modal" id="web_divided_set" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <form class="form-horizontal" role="form">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">设置YZ<input type="hidden" id="spaceId"></h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right "> Y : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="dividedY">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label no-padding-right "> Z : </label>
                                            <div class="col-sm-8">
                                                <input type="text" class="col-xs-10 col-sm-7" id="dividedZ">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    <button type="button" class="btn btn-primary" onclick="updateProportion()">确定</button>
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
    loading("webAdspaceList", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){

        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel != 3){
            $('#statistics').show();
            $('#operating').show();
            $('#updateTime').show();
        }else{
            $('#statistics').hide();
            $('#operating').hide();
            $('#updateTime').hide();
        }
        webAdspaceList(1);
    });

    //点击搜索数据展示
    function webAdspaceList(currentPage) {
        var currentUserLevel = $('#currentUserLevel').val();
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/web/webAdspaceList",
            type: "post",
            data: {
                "currentPage" : currentPage,
                "pageSize" : pageSize,
                "webName" : $('#webName').val(),
                "spaceName" : $('#spaceName').val(),
                "terminal" : $('#terminal').val(),
                "spaceType" :  $('#spaceType option:selected').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.adspaceList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.upstreamId+'</td>';
                        html+='<td> '+data.spaceName+'</td>';
                        html+='<td> '+data.webName+'</td>';
                        var terminal = data.terminal;
                        if(terminal == 1){
                            html+='<td> PC </td>';
                        }else if(terminal == 2){
                            html+='<td> WAP </td>';
                        }else{
                            html+='<td> <font color="red">信息错误</font> </td>';
                        }
                        var spaceType = data.spaceType;
                        if(spaceType == 1){
                            html+='<td> 固定块 </td>';
                        }else if(spaceType == 2){
                            html+='<td> 右下浮 </td>';
                        }else if(spaceType == 3){
                            html+='<td> 对联 </td>';
                        }else{
                            html+='<td> <font color="red">信息错误</font> </td>';
                        }
                        html+='<td> '+data.width+'</td>';
                        html+='<td> '+data.height+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        if (currentUserLevel != 3) {
                            html+='<td> '+data.updateTime+'</td>';
                        }
                        var status = data.status;
                        if(status == 0){
                            html+='<td id="status'+data.spaceId+'"><span class="label label-purple label-white middle">停用</span></td>';
                        }else if(status == 1){
                            html+='<td id="status'+data.spaceId+'"><span class="label label-success label-white middle">正常</span></td>';
                        }else if(status == 2){
                            html+='<td id="status'+data.spaceId+'"><span class="label label-danger label-white middle">封禁</span></td>';
                        }else{
                            html+='<td><font color="red">状态错误</font></td>';
                        }
                        if(currentUserLevel != 3){
                            //停用
                            if(status == 0){
                                html+='<td id="operating'+data.spaceId+'">' +
                                    '<button type=button class="btn btn-minier btn-success" onclick="idStatus('+data.spaceId+',1)">启用</button>&nbsp;' +
                                    '<button type=button class="btn btn-minier btn-danger" onclick="idStatus('+data.spaceId+',2)">封禁</button>' +
                                    '</td>';
                            //正常
                            }else if(status == 1){
                                html+='<td id="operating'+data.spaceId+'">' +
                                    '<button type=button class="btn btn-minier btn-purple" onclick="idStatus('+data.spaceId+',0)">停用</button>&nbsp;' +
                                    '<button type=button class="btn btn-minier btn-danger" onclick="idStatus('+data.spaceId+',2)">封禁</button>' +
                                    '</td>';
                            //封禁
                            }else if(status == 2){
                                html+='<td id="operating'+data.spaceId+'">' +
                                    '<font color="red">此ID已被封禁</font>' +
                                    '</td>';
                            }
                        }
                        if(currentUserLevel != 3){
                            html+='<td><button type=button class="btn btn-minier" onclick="divided(\''+data.spaceId+'!'+data.dividedY+'!'+data.dividedZ+'\')">分成</button>&nbsp;' +
                                '<button type=button class="btn btn-minier" onclick="addWebStatistice(\''+data.spaceId+'!'+data.spaceName+'!'+data.webName+'!'+data.upstreamId+'\')">添加数据统计</button></td>';
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
            webAdspaceList(page);
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
            webAdspaceList(page);
        }
    }

    //idStatus
    function idStatus(spaceId, status){
        $.ajax({
            url: path + "/web/idStatus",
            type: "post",
            data: {
                "spaceId" : spaceId,
                "status" : status
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    $('#status'+spaceId).empty();
                    $('#operating'+spaceId).empty();
                    var htm = '';
                    var html = '';
                    if (status == 0){
                        htm +='<td id="status'+spaceId+'"><span class="label label-purple label-white middle">停用</span></td>';
                        html +='<td id="operating'+spaceId+'">' +
                            '<button type="button" class="btn btn-minier btn-success" onclick="idStatus('+spaceId+',1)">启用</button>&nbsp;' +
                            '<button type="button" class="btn btn-minier btn-danger" onclick="idStatus('+spaceId+',2)">封禁</button>' +
                            '</td>';
                    } else if (status == 1) {
                        htm +='<td id="status'+spaceId+'"><span class="label label-success label-white middle">正常</span></td>';
                        html +='<td id="operating'+spaceId+'">' +
                            '<button type="button" class="btn btn-minier btn-purple" onclick="idStatus('+spaceId+',0)">停用</button>&nbsp;' +
                            '<button type="button" class="btn btn-minier btn-danger" onclick="idStatus('+spaceId+',2)">封禁</button>' +
                            '</td>';
                    } else if (status == 2) {
                        htm +='<td id="status'+spaceId+'"><span class="label label-danger label-white middle">封禁</span></td>';
                        html +='<td id="operating'+spaceId+'"><font color="red">此ID已被封禁</font></td>';
                    }
                    $('#status'+spaceId).html(htm);
                    $('#operating'+spaceId).html(html);
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

    //tongji
    function addWebStatistice(sign) {
        sessionStorage.setItem("sign",sign);
        window.location = path + "/webStatisticsAdd";
    }

    //set
    function divided(data){
        var str = data.split('!');
        $('#spaceId').val(str[0]);
        $('#dividedY').val(str[1]);
        $('#dividedZ').val(str[2]);
        $("#web_divided_set").modal("show");
    }
    
    //update
    function updateProportion() {
        var spaceId = $('#spaceId').val();
        var dividedY = $('#dividedY').val();
        var dividedZ = $('#dividedZ').val();
        if (dividedY > 1 || dividedZ > 1) {
            alert("参数错误");
        }else{
            $.ajax({
                url: path + "/web/spaceDivided",
                type: "post",
                data: {
                    "spaceId" : spaceId,
                    "dividedY" : dividedY,
                    "dividedZ" : dividedZ
                },
                dataType: 'json',
                async: false,
                success: function (obj) {
                    if(obj.code == 200){
                        $("#web_divided_set").modal("hide");
                        var page = parseInt($('#currentPage').text());
                        webAdspaceList(page);
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
    }

</script>

</html>
