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

<form action="#" method="post">
    <div align="center">
        用户名：<input type="text" id="loginName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        用户昵称：<input type="text" id="nickName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        <span id="userLevelSpan">
        用户权限：
        <select id="userLevel" style="width:100px;height:30px">
            <option value="0">全部</option>
            <option value="2">管理员</option>
            <option value="3">普通用户</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;
        </span>
        用户状态：
        <select id="userStatus" style="width:100px;height:30px">
            <option value="0">全部</option>
            <option value="1">正常</option>
            <option value="2">禁用</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" style="width:50px;height:30px" value="搜索" onclick="selectUserList($('#currentPage').val())">&nbsp;&nbsp;
        <input type="button" style="width:80px;height:30px" value="创建用户" onclick="createUser()">

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
                        <th>用户id</th>
                        <th>登陆账号</th>
                        <th>用户昵称</th>
                        <th id="parentId">上级管理员</th>
                        <th>用户等级</th>
                        <th>创建时间</th>
                        <th>用户状态</th>
                        <th>权限操作</th>
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

<!-- 新增用户-模态框 -->
<div class="modal" id="createUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form class="form-horizontal" role="form" id="index_changePwd_agreeFrom">
            <input type="hidden" id="index_changePwd_userId" name="index_changePwd_userId" value="">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="index_changePwd_myModalLabel">创建新用户</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right " for="newLoginName">
                                登录账号: </label>
                            <div class="col-sm-8">
                                <input type="text" id="newLoginName" placeholder="请输入账号信息"
                                       class="col-xs-10 col-sm-7" name="newLoginName">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right " for="newPassWord">
                                登录密码: </label>
                            <div class="col-sm-8">
                                <input type="password" id="newPassWord" placeholder="请输入密码"
                                       class="col-xs-10 col-sm-7" name="newPassWord">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right "
                                   for="confirmPassWord"> 确认密码: </label>
                            <div class="col-sm-8">
                                <input type="password" id="confirmPassWord" placeholder="请再次输入新密码"
                                       class="col-xs-10 col-sm-7" name="confirmPassWord">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right " for="newNickName">
                                昵称设置: </label>
                            <div class="col-sm-8">
                                <input type="text" id="newNickName" placeholder="起一个好听的名字吧"
                                       class="col-xs-10 col-sm-7" name="newNickName">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="createNewUser()">确定</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>

<script type="text/javascript">

    //新增用户模态框
    function createUser() {
        $("#createUser").modal("show");
    }

    //新增用户信息
    function createNewUser() {
        var newLoginName = $("#newLoginName").val();
        var newPassWord = $("#newPassWord").val();
        var confirmPassWord = $("#confirmPassWord").val();
        var newNickName = $("#newNickName").val();

        if(newLoginName == "" || newPassWord == "" || confirmPassWord == "" || newNickName == ""){
            alert("请完善信息再提交");
        }else{
            var user = {
                loginName  : newLoginName,
                passWord : newPassWord,
                confirmPassWord : confirmPassWord,
                nickName : newNickName
            };
            $.ajax({
                url: path + "/user/createUser",
                type: "post",
                data: user,
                dataType: 'json',
                async: false,
                success: function (obj) {
                    if(obj.code == 200){
                        alert(obj.message);
                        $("#createUser").modal("hide");
                        gotoURL(path + "/userList");
                    }else if(obj.code == 300){
                        alert(obj.message);
                        window.location = path + "/login";
                    }else{
                        alert(obj.message);
                        $("#createUser").modal("hide");
                    }

                },
                error: function () {
                    $.alertModel("网络超时!获取失败!");
                }
            });

        }
    }

    //进入页面直接请求数据
    $(document).ready(function(){
        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel == 2 || currentUserLevel ==3){
            $('#userLevelSpan').hide();
            $('#parentId').hide();
        }
        selectUserList(1);
    });

    //点击搜索数据展示
    function selectUserList(currentPage) {

        var currentUserLevel = $('#currentUserLevel').val();
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/user/userList",
            type: "post",
            data: {
                "currentPage" : currentPage,
                "pageSize" : pageSize,
                "loginName" : $('#loginName').val(),
                "nickName" : $('#nickName').val(),
                "userStatus" :  $('#userStatus option:selected').val(),
                "userLevel" :  $('#userLevel option:selected').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.userList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.userId+'</td>';
                        html+='<td> '+data.loginName+'</td>';
                        html+='<td> '+data.nickName+'</td>';
                        if(currentUserLevel == 1){
                            html+='<td> '+data.parentName+'</td>';
                        }
                        if(data.userLevel == 1){
                            html+='<td>超级管理员</td>';
                        }else if(data.userLevel == 2){
                            html+='<td>管理员</td>';
                        }else{
                            html+='<td>普通用户</td>';
                        }
                        html+='<td> '+data.createTime+'</td>';
                        var userStatus = data.userStatus;
                        if(userStatus == 2){
                            html+='<td id="userStatus'+data.userId+'">禁用</td>';
                            html+='<td id="operating'+data.userId+'"><input type=button style="background:green" value="启用" onclick="startUserStatus('+data.userId+')"/></td>';
                        }else if(userStatus == 1){
                            html+='<td id="userStatus'+data.userId+'">正常</td>';
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
            selectUserList(page);
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
            selectUserList(page);
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

