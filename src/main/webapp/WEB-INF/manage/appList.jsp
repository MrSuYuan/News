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
        APPID：<input type="text" id="nickName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        APP名称：<input type="text" id="loginName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        审核状态：
        <select id="userLevel" style="width:100px;height:30px">
            <option value="0">全部</option>
            <option value="1">未审核</option>
            <option value="2">审核通过</option>
            <option value="3">审核驳回</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;
        APP状态：
        <select id="userStatus" style="width:100px;height:30px">
            <option value="0">全部</option>
            <option value="1">正常</option>
            <option value="2">禁用</option>
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
                        <th id="parentId">所属用户</th>
                        <th>接入方式</th>
                        <th>适用平台</th>
                        <th>创建时间</th>
                        <th>审核状态</th>
                        <th>APP状态</th>
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
                        html+='<td> '+data.userId+'</td>';
                        html+='<td> '+data.accessMethod+'</td>';
                        html+='<td> '+data.terminal+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        var appStatus = data.appStatus;
                        if(appStatus == 2){
                            html+='<td id="appStatus'+data.userId+'">禁用</td>';
                            html+='<td id="operating'+data.userId+'"><input type=button style="background:green" value="启用" onclick="startUserStatus('+data.userId+')"/></td>';
                        }else if(appStatus == 1){
                            html+='<td id="appStatus'+data.userId+'">正常</td>';
                            html+='<td id="operating'+data.userId+'"><input type=button style="background:red" value="禁用" onclick="stopUserStatus('+data.userId+')"/></td>';
                        }else{
                            html+='<td><font color="red">状态错误</font></td>';
                            html+='<td><font color="red">状态错误</font></td>';
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

    //启用
    function startUserStatus(userId){

        $.ajax({
            url: path + "/user/userStatus",
            type: "post",
            data: {
                "userId" : userId,
                "userStatus" : 1
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.code == 200){
                    $('#userStatus'+userId).empty();
                    $('#operating'+userId).empty();
                    $('#userStatus'+userId).html("正常");
                    var html='<td id="operating'+userId+'"><input type=button style="background:red" value="禁用" onclick="stopUserStatus('+userId+')"/></td>';
                    $('#operating'+userId).html(html);
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.open(path+"/login");
                }else{
                    alert("数据加载错误");
                }
            },
            error: function () {
                alert("请求异常");
            }
        });


    }

    //禁用
    function stopUserStatus(userId){

        $.ajax({
            url: path + "/user/userStatus",
            type: "post",
            data: {
                "userId" : userId,
                "userStatus" : 2
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.code == 200){
                    $('#userStatus'+userId).empty();
                    $('#operating'+userId).empty();
                    $('#userStatus'+userId).html("禁用");
                    var html='<td id="operating'+userId+'"><input type=button style="background:green" value="启用" onclick="startUserStatus('+userId+')"/></td>';
                    $('#operating'+userId).html(html);
                }else if(obj.code == "300"){
                    alert(obj.message);
                    window.open(path+"/login");
                }else{
                    alert("数据加载错误");
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }



</script>

</html>

