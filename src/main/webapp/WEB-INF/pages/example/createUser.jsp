<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>新增用户</title>
</head>

<script src="${ctx}/statics/common/assets/js/jquery-2.1.4.min.js"></script>

<body>
    <font size="4"><STRONG>新增用户</STRONG></font>
    <hr>
    <%--<form action="${ctx}/user/createUser" method="post">--%>
    <form action="#" method="post">
        <div>
            <table>
                <tr height = "40">
                    <td>用户类型:&nbsp;&nbsp;</td>
                    <td width="250">个人用户</td>
                </tr>
                <tr height = "40">
                    <td align = "right">姓名:&nbsp;&nbsp;</td>
                    <td width="250"><input type="text" size="35" id="userName" name="userName" placeholder="请输入用户名"></td>
                </tr>
                <tr height = "40">
                    <td align = "right">邮箱:&nbsp;&nbsp;</td>
                    <td width="250"><input type="text" size="35" id="loginEmail" name="loginEmail" placeholder="请输入正确的邮箱"></td>
                </tr>
                <tr height = "40">
                    <td align = "right">密码:&nbsp;&nbsp;</td>
                    <td width="250"><input type="text" size="35" id="passWord" name="passWord" placeholder="密码6-12位字母和数字组合"></td>
                </tr>
                <tr height = "40">
                    <td align = "right">确认密码:&nbsp;&nbsp;</td>
                    <td width="250"><input type="text" size="35" id="confirmPassword" name="confirmPassword" placeholder="确认密码"></td>
                </tr>
                <tr height = "40">
                    <td align = "right">电话:&nbsp;&nbsp;</td>
                    <td width="250"><input type="text" size="35" id="userPhone" name="userPhone" placeholder="请输入手机号"></td>
                </tr>
                <tr height = "40">
                    <td><input type="button" id="send" value="确定" onclick="createUser()"></td>
                    <td><input type="button" id="back" value="返回" onclick="reset()"></td>
                </tr>
            </table>
        </div>
    </form>
</body>

<script type="text/javascript">

    //创建用户
    function createUser() {

        $.ajax({
            type: "post",
            url: path + "/user/createUser",
            data: {
                "userName":  $('#userName').val(),
                "loginEmail": $('#loginEmail').val(),
                "passWord": $('#passWord').val(),
                "confirmPassword": $('#confirmPassword').val(),
                "userPhone": $('#userPhone').val()
            },
            dataType: "json",
            success: function(data){
                if(data.errorCode == 200){
                    alert("用户添加成功");
                    gotoURL(path+"/createUser");
                }else if(data.errorCode == 100){
                    alert(data.message);
                }else if(data.errorCode == "000"){
                    alert(data.message);
                    window.open(path+"/login");
                }else{
                    alert(data.message);
                }
            }
        });
    }

    //返回重置输入框内容
    $("#back").on("click",function(){
        $('#userName').val("");
        $('#loginEmail').val("");
        $('#passWord').val("");
        $('#confirmPassword').val("");
        $('#userPhone').val("");
    });
    function reset(){
        alert(123);
    }

</script>

</html>
