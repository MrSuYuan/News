<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理</title>
</head>
<body>
<input type="hidden" id="userId">
<font size="4"><strong>用户管理</strong></font>
<hr>
<form action="#" method="post">
    <div>
        <table>
            <tr height = "40">
                <td><b>用户类型&nbsp;:</b>&nbsp;&nbsp;</td>
                <td width="250"><input type="text" id="roleName" size="35" disabled="disabled"/></td>
            </tr>
            <tr height = "40">
                <td align = "right"><b>姓名&nbsp;:</b>&nbsp;&nbsp;</td>
                <td width="250"><input type="text" id="userName" size="35" disabled="disabled"/></td>
            </tr>
            <tr height = "40">
                <td align = "right"><b>邮箱&nbsp;:</b>&nbsp;&nbsp;</td>
                <td width="250"><input type="text" id="loginEmail" size="35" disabled="disabled"/></td>
            </tr>
            <tr height = "40">
                <td align = "right"><b>电话&nbsp;:</b>&nbsp;&nbsp;</td>
                <td width="250"><input type="text" id="userPhone" size="35" disabled="disabled"/></td>
            </tr>
            <tr height = "40">
                <td align = "right"><b>注册时间&nbsp;:</b>&nbsp;&nbsp;</td>
                <td width="250"><input type="text" id="formatTime" size="35" disabled="disabled"/></td>
            </tr>
            <tr height = "40">
                <td align = "right"><b>权限操作&nbsp;:</b>&nbsp;&nbsp;</td>
                <td width="500">
                    <input type="radio" name="radio" value="1">管理员&nbsp;&nbsp;
                    <input type="radio" name="radio" value="2">应用审核员&nbsp;&nbsp;
                    <input type="radio" name="radio" value="3">异常审核员&nbsp;&nbsp;
                    <input type="radio" name="radio" value="4">普通用户
                </td>
            </tr>
            <tr height = "40">
                <td><input type="button" id="send" value="确定" onclick="submit_button()"></td>
                <td><input type="button" id="back" value="返回" onclick="back_button()"></td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>

<script type="text/javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        var userId =  sessionStorage.getItem("userId");
        $('#userId').val(userId);
        sessionStorage.removeItem("userId");
        //查询个人信息
        userMessage(userId);
    });

    //查询个人数据
    function userMessage(userId){
        $.ajax({
            type: "post",
            url: path + "/user/userMessage",
            data: {
                "userId":  userId
            },
            dataType: "json",
            success: function(data){
                if(data.errorCode == 200){
                    var user = data.item.user;
                    $('#roleName').val(user.roleName);
                    $('#userName').val(user.userName);
                    $('#loginEmail').val(user.loginEmail);
                    $('#userPhone').val(user.userPhone);
                    $('#formatTime').val(user.formatTime);
                    $('input:radio').each(function (){
                        if($(this).val() == user.roleId){
                            $(this).attr("checked",'checked');
                        }
                    });
                }else{
                    alert("数据加载错误");
                }
            }
        });
    }

    //确定
    function submit_button(){
        var roleId = $('input:radio:checked').val();
        var userId = $('#userId').val();
        if(roleId != undefined){
            $.ajax({
                type: "post",
                url: path + "/user/userPermission",
                data: {
                    "userId": userId,
                    "roleId": roleId
                },
                dataType: "json",
                success: function(data){
                    if(data.errorCode == 200){
                        alert(data.message);
                        gotoURL(path+"/userManagementList");
                    }else{
                        alert("修改权限出错");
                    }
                }
            });
        }else{
            alert("请选择审核操作");
        }
    }

    //返回
    function back_button(){
        gotoURL(path+"/userManagementList")
    }


</script>
