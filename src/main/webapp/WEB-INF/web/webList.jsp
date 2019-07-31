<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
    <title>APP列表</title>
</head>

<body>
<font size="4"><STRONG>APP列表</STRONG></font>
<hr>

<form action="#" method="post">
    <div align="center">
        APPID：<input type="text" id="appId" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        APP名称：<input type="text" id="appName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        APP状态：
        <select id="appStatus" style="width:100px;height:30px">
            <option value="0">全部</option>
            <option value="1">未审核</option>
            <option value="2">驳回</option>
            <option value="3">正常</option>
            <option value="4">禁用</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" style="width:50px;height:30px" value="搜索" onclick="selectAppList($('#currentPage').val())">&nbsp;&nbsp;
        <input id="addApp" type="button" style="width:80px;height:30px" value="添加APP" onclick="appDetail()">

    </div>
    <br><span></span><br>
    <div class="row">
        <div class="col-xs-12">
            <div class="table-header"></div>
            <div>
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr style="height: 50px">
                        <th>APPID</th>
                        <th>名称</th>
                        <th>所属用户</th>
                        <th>适用系统</th>
                        <th>适用终端</th>
                        <th>创建时间</th>
                        <th>下载地址</th>
                        <th>APP状态</th>
                        <th>操作</th>
                        <th id="adspace">代码位</th>
                    </tr>
                    </thead>
                    <tbody id="coll_list_begin_body">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer no-margin-top">
                页数<a onclick="lastPageData()"><</a>
                &nbsp;<input type="text" id="currentPage" style="width:35px;height:20px">
                <a onclick="nextPageData()">></a>&nbsp;
                共&nbsp;<span id="sumPage"></span>&nbsp;页&nbsp;|&nbsp;
                页面容量
                &nbsp;<input type="text" id="pageSize" style="width:35px;height:20px">&nbsp;|&nbsp;
                共&nbsp;<span id="sumData"></span>&nbsp;条数据
                <ul class="pagination pull-right no-margin" id="coll_begin_page"></ul>
            </div>
        </div>
    </div>

</form>

</body>

<script type="text/javascript">

    //新增用户
    function appDetail() {
        gotoURL(path+"/appDetail")
    }

    //进入页面直接请求数据
    $(document).ready(function(){
        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel == 1){
            $('#addApp').hide();
        }
        if(currentUserLevel == 2){
            $('#adspace').show();
        }else{
            $('#adspace').hide();
        }
        selectAppList(1);
    });

    //点击搜索数据展示
    function selectAppList(currentPage) {
        var currentUserLevel = $('#currentUserLevel').val();

        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/app/appList",
            type: "post",
            data: {
                "appId" : $('#appId').val(),
                "appName" : $('#appName').val(),
                "appStatus" :  $('#appStatus option:selected').val(),
                "currentPage" : currentPage,
                "pageSize" : pageSize
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.appList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.appId+'</td>';
                        html+='<td> '+data.appName+'</td>';
                        html+='<td> '+data.nickName+'</td>';
                        var platform = data.platform;
                        if (platform == 1) {
                            html+='<td> Android </td>';
                        }else if(platform == 2){
                            html+='<td> IOS </td>';
                        }else if(platform == 3){
                            html+='<td> Windows </td>';
                        }
                        var terminal = data.terminal;
                        if (terminal == 1) {
                            html+='<td> 手机 </td>';
                        }else if(terminal == 2){
                            html+='<td> 平板 </td>';
                        }else if(terminal == 3){
                            html+='<td> 电脑 </td>';
                        }
                        html+='<td> '+data.createTime+'</td>';
                        html+='<td> '+data.downloadlink+'</td>';
                        var appStatus = data.appStatus;
                        if(appStatus == 1){
                            html+='<td id="appStatus'+data.appId+'">未审核</td>';
                            html+='<td id="operating'+data.appId+'">' +
                                '<input type=button style="background:green" value="通过" onclick="changeAppStatus('+data.appId+','+4+')"/>' +
                                '<input type=button style="background:red" value="驳回" onclick="changeAppStatus('+data.appId+','+2+')"/>' +
                                '</td>';
                        }else if(appStatus == 2){
                            html+='<td id="appStatus'+data.appId+'">驳回</td>';
                            html+='<td id="operating'+data.appId+'">' +
                                'APP未通过审核' +
                                '</td>';
                        }else if(appStatus == 3){
                            html+='<td id="appStatus'+data.appId+'">正常</td>';
                            html+='<td id="operating'+data.appId+'">' +
                                '<input type=button style="background:red" value="禁用" onclick="changeAppStatus('+data.appId+','+4+')"/>' +
                                '</td>';
                        }else if(appStatus == 4){
                            html+='<td id="appStatus'+data.appId+'">禁用</td>';
                            html+='<td id="operating'+data.appId+'">' +
                                '<input type=button style="background:green" value="启用" onclick="changeAppStatus('+data.appId+','+3+')"/>' +
                                '</td>';
                        }else{
                            html+='<td><font color="red">状态错误</font></td>';
                            html+='<td><font color="red">状态错误</font></td>';
                        }
                        if(currentUserLevel == 2){
                            html+='<td><button type="button" onclick="addAdspace('+data.appId+')">添加广告位</button></td>';
                        }
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                    //更新页码
                    $('#currentPage').val(obj.result.currentPage);
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
        var page = parseInt($('#currentPage').val());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            selectAppList(page);
        }
    }

    //下一页
    function nextPageData() {
        var page = parseInt($('#currentPage').val());
        var sumPage = parseInt($('#sumPage').text());
        if(page == sumPage){
            alert("当前是最后一页");
        }else{
            var page = page + 1;
            selectAppList(page);
        }
    }

    //appStatus 1未审核 2驳回 3正常 4禁用
    function changeAppStatus(appId, appStatus){
        $.ajax({
            url: path + "/app/appStatus",
            type: "post",
            data: {
                "appId" : appId,
                "appStatus" : appStatus
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.code == 200){
                    $('#appStatus'+appId).empty();
                    $('#operating'+appId).empty();

                    if(appStatus == 2){
                        $('#appStatus'+appId).html("驳回");
                        var html='<td id="operating'+appId+'">APP未通过审核</td>';
                        $('#operating'+appId).html(html);

                    }else if(appStatus == 3){
                        $('#appStatus'+appId).html("正常");
                        var html='<td id="operating'+appId+'">'+
                            '<input type=button style="background:red" value="禁用" onclick="changeAppStatus('+appId+','+4+')"/>'+
                            '</td>';
                        $('#operating'+appId).html(html);

                    }else if(appStatus == 4){
                        $('#appStatus'+appId).html("禁用");
                        var html='<td id="operating'+appId+'">'+
                            '<input type=button style="background:green" value="启用" onclick="changeAppStatus('+appId+','+3+')"/>'+
                            '</td>';
                        $('#operating'+appId).html(html);

                    }else{
                        $('#appStatus'+appId).html("状态错误");
                        $('#operating'+appId).html("状态错误");
                    }

                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.open(path+"/login");
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    function addAdspace(appId){
        sessionStorage.setItem("appId",appId);
        gotoURL(path + "/addAppAdspace");
    }

</script>

</html>

