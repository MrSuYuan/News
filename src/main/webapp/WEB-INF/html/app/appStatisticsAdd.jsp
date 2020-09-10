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
                <input type = "hidden" id="upstreamId">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="alert alert-info">
                            <tr height = "50">
                                <td align = "right">APP名称&nbsp;:&nbsp;</td>
                                <td width="300"><span id="appName"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align = "right">广告位名称&nbsp;:&nbsp;</td>
                                <td width="300"><span id="spaceName"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align = "right">上游类型&nbsp;:&nbsp;</td>
                                <td width="300"><span id="upstreamName"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align = "right">上游ID&nbsp;:&nbsp;</td>
                                <td width="300"><span id="upstreamIdSpan"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align = "right">上游分成X&nbsp;:&nbsp;</td>
                                <td width="300"><span id="dividedX"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align = "right">下游分成Y&nbsp;:&nbsp;</td>
                                <td width="300"><span id="dividedY"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <td align = "right">展现点击扣量Z&nbsp;:&nbsp;</td>
                                <td width="300"><span id="dividedZ"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </div>
                    </div><!-- /.col -->
                </div><!-- /.row -->

                <div class="row">
                    <div class="col-xs-12">
                        <div class="table-header"></div>
                        <div>
                            <table  width="50%" cellpadding="0" cellspacing="0" id="dynamic-table"
                                    class="table table-striped table-bordered table-hover">
                                <thead>

                                <tr style="height: 50px">
                                    <th>选择</th>
                                    <th>日期</th>
                                    <th>展现pv</th>
                                    <th>点击数</th>
                                    <th>收益</th>
                                </tr>

                                </thead>
                                <tbody id="tbody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <style type="text/css">
                    table,th,td{
                        border:1px solid #328AA4;
                    }
                    td input{
                        border:none;
                        width:100%;
                    }
                </style>

                <input class="btn btn-sm btn-info no-radius" type="button" value="新增" onclick="createRow()">
                <input class="btn btn-sm btn-info no-radius" type="button" value="保存" onclick="submit()">
                <input class="btn btn-sm btn-info no-radius" type="button" value="删除" onclick="delRow()">

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
    loading("appStatisticsAdd", $('#userName').val());

    /**
     * 页面加载完毕,取出session的spaceId
     */
    $(document).ready(function(){
        var upstreamId =  sessionStorage.getItem("upstreamId");
        $('#upstreamId').val(upstreamId);
        upstreamIdMsg(upstreamId);
        sessionStorage.removeItem("upstreamId");
    })

    //展示
    function upstreamIdMsg(upstreamId) {
        $.ajax({
            url: path + "/app/appUpstreamIdMsg",
            type: "post",
            data: {
                "upstreamId" : upstreamId
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var msg = obj.result.msg;
                    $('#appName').html(msg.appName);
                    $('#spaceName').html(msg.spaceName);
                    $('#upstreamName').html(msg.name);
                    $('#upstreamIdSpan').html(msg.upstreamId);
                    var divided = obj.result.divided;
                    $('#dividedX').html(divided.dividedX);
                    $('#dividedY').html(divided.dividedY);
                    $('#dividedZ').html(divided.dividedZ);
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

    /**
     * 动态添加行
     */
    function createRow(){
        var editTable=document.getElementById("tbody");
        var tr=document.createElement("tr");
        tr.className="trClass";
        var td0=document.createElement("td");
        var checkbox=document.createElement("input");
        checkbox.type="checkbox";
        checkbox.name="checkRow";
        td0.appendChild(checkbox);
        var td1=document.createElement("td");
        var date=document.createElement("input");
        date.type="date";
        date.name="createTime";
        td1.appendChild(date);
        var td2=document.createElement("td");
        td2.innerHTML="<input type='text' name='beforeLookPV'/>";
        var td3=document.createElement("td");
        td3.innerHTML="<input type='text' name='beforeClickNum'/>";
        var td5=document.createElement("td");
        td5.innerHTML="<input type='text' name='beforeIncome'/>";
        tr.appendChild(td0);
        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);
        tr.appendChild(td5);
        editTable.appendChild(tr);
    }

    /**
     * 动态删除行
     */
    function delRow(){
        var editTable=document.getElementById("tbody");
        var checkboxs=document.getElementsByName("checkRow");
        for(var i=0;i<checkboxs.length;i++){
            if(checkboxs[i].checked){
                var n=checkboxs[i].parentNode.parentNode;
                editTable.removeChild(n);
                i--;
            }
        }
    }

    /**
     * 提交
     */
    function submit() {
        var upstreamId = $('#upstreamId').val();
        var objs = [];
        $('.trClass').each(function(index,val){
            var obj = {
                upstreamId : upstreamId,
                createTime : $(val).find('input[name=createTime]').eq(0).val(),
                beforeLookPV : $(val).find('input[name=beforeLookPV]').eq(0).val(),
                beforeClickNum : $(val).find('input[name=beforeClickNum]').eq(0).val(),
                beforeIncome : $(val).find('input[name=beforeIncome]').eq(0).val(),
                lookPV : 0,
                clickNum : 0,
                income : 0,
                clickProbability : 0,
                ecpm : 0,
            }
            objs.push(obj)
        })
        console.log(objs);

        //提交数据
        $.ajax({
            url: path + "/app/addAppStatistics",
            type: "post",
            data: {
                "currentUserLevel" : $('#currentUserLevel').val(),
                "statisticsList" : JSON.stringify(objs)
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    alert(obj.message);
                    window.location = path + "/appAdspaceList";
                }else if(obj.code == 300){
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

</script>

</html>
