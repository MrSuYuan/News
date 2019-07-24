<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
    <title>用户列表</title>
</head>

<body>
<font size="4"><STRONG>用户列表</STRONG></font>
<hr>
<%--<form action="${ctx}/user/createUser" method="post">--%>
<form action="#" method="post">
    <div align="center">
        用户名：<input type="text" id="loginName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        用户昵称：<input type="text" id="nickName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        创建时间：<input type="date" id="startTime" style="width:150px;height:30px">&nbsp;&nbsp;--&nbsp;&nbsp;
        <input type="date" id="endTime" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        用户权限：
        <select id="userLevel" style="width:100px;height:30px">
            <option value="0">全部</option>
            <option value="2">管理员</option>
            <option value="3">普通用户</option>
        </select>
        用户状态：
        <select id="userStatus" style="width:100px;height:30px">
            <option value="2">全部</option>
            <option value="1">正常</option>
            <option value="0">禁用</option>
        </select>
        <input type="button" style="width:50px;height:30px" value="搜索" onclick="selectWaitList($('#currentPage').val())">
    </div>
    <br><span></span><br>
    <div class="row">
        <div class="col-xs-12">
            <div class="table-header"></div>
            <div>
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>用户id</th>
                        <th>登陆账号</th>
                        <th>用户昵称</th>
                        <th>性别</th>
                        <th id="userName">上级管理员</th>
                        <th>用户等级</th>
                        <th>创建时间</th>
                        <th>用户状态</th>
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

    //进入页面直接请求数据
    $(document).ready(function(){
        selectWaitList(1);
    });

    //点击搜索数据展示
    function selectWaitList(currentPage) {
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/review/appAuditList",
            type: "post",
            data: {
                "pageType" : 1,
                "pageSize" : pageSize,
                "appName" : $('#appName').val(),
                "channelId" :  $('#options option:selected').val(),
                "MD5" : $('#MD5').val(),
                "startTime" : $('#startTime').val(),
                "endTime" : $('#endTime').val(),
                "auditStatus" : $('#auditStatus').val(),
                "currentPage" : currentPage
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.errorCode == 200){
                    var roleId = obj.item.roleId;
                    if(roleId != 1){
                        $('#userName').hide();
                    }
                    var list = obj.item.auditList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr>';
                        html+='<td> '+data.appName+'</td>';
                        html+='<td> '+data.mD5+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        html+='<td> '+data.name+'</td>';
                        if(roleId == 1){
                            html+='<td> '+data.userName+'</td>';
                        }
                        html+='<td> <a href="http://124.206.188.50:5000/CertPortal/appScan/fs/report/'+data.uuid+'" target="_blank">查看</a></td>';
                        html+='<td> <a id="a" onclick="a(\''+data.appUuid+'\','+data.auditStatus+','+data.userId+')" style="cursor:pointer">'+data.userAuditRemark+'</a><input type="hidden" value="'+data.appUuid+'"></td>';
                        html+='<td> '+data.auditTime+'</td>';
                        html+='<td> <a href="'+data.applocalpath+'">'+'点击下载'+'</a></td>';
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                    //更新页码
                    $('#currentPage').val(obj.item.currentPage);
                    $('#pageSize').val(obj.item.pageSize);
                    $('#sumPage').html(obj.item.sumPage);
                    $('#sumData').html(obj.item.sumData);
                }else if(obj.errorCode == "100"){
                    alert(obj.message);
                    window.open(path+"/index");
                }else if(obj.errorCode == "000"){
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

    //上一页
    function lastPageData() {
        var page = parseInt($('#currentPage').val());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            selectWaitList(page);
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
            selectWaitList(page);
        }
    }

    //查看审核详情
    function a(appUuid,auditStatus,userId) {
        if(auditStatus == 0){
            sessionStorage.setItem("appUuid",appUuid);
            gotoURL(path+"/reviewNormalDetails");
        }else{
            var obj = appUuid+','+userId;
            sessionStorage.setItem("obj",obj);
            gotoURL(path+"/reviewNormalHistory");
        }
    }

</script>

</html>

