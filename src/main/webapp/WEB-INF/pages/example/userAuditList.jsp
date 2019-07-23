<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户审核列表</title>
</head>
<body>
<font size="4"><STRONG>用户审核列表</STRONG></font>
<hr>

<form action="#" method="post">
    <div align="center">
        姓名：<input type="text" id="userName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        邮箱：<input type="text" id="loginEmail" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        用户类型：<select id="select" style="width:150px;height:30px">
        <option value="0">请选择</option>
        <option value="1">管理员</option>
        <option value="2">应用审核员</option>
        <option value="3">异常审核员</option>
        <option value="4">普通用户</option>
    </select>
        &nbsp;&nbsp;&nbsp;
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
                        <th>姓名</th>
                        <th>用户类型</th>
                        <th>注册时间</th>
                        <th>邮箱</th>
                        <th>电话</th>
                        <th>状态</th>
                        <th>操作</th>
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
            url: path + "/user/userAuditList",
            type: "post",
            data: {
                "userName" : $('#userName').val(),
                "loginEmail" : $('#loginEmail').val(),
                "roleId" :  $('#select option:selected').val(),
                "pageSize" : pageSize,
                "currentPage" : currentPage
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.errorCode == 200){
                    console.log(obj);
                    var list = obj.item.userList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr>';
                        html+='<td> '+data.userName+'</td>';
                        html+='<td> '+data.roleName+'</td>';
                        html+='<td> '+data.formatTime+'</td>';
                        html+='<td> '+data.loginEmail+'</td>';
                        html+='<td> '+data.userPhone+'</td>';
                        var auditStatus = data.auditStatus;
                        if(auditStatus == 0){
                            html+='<td>未审核</td>';
                        }else if(auditStatus == 1){
                            html+='<td><font color="green">审核通过</font></td>';
                        }else if(auditStatus == 2){
                            html+='<td><font color="yellow">未通过</font></td>';
                        }else{
                            html+='<td><font color="red">状态错误</font></td>';
                        }
                        html+='<td><a onclick="a('+data.userId+')">查看</a></td>';
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

    //查看审核详情
    function a(userId) {
        sessionStorage.setItem("userId",userId);
        gotoURL(path+"/userAudit");
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

</script>

</html>



