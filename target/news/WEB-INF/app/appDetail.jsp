<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<font size="4"><STRONG>编辑应用</STRONG></font>
<hr>

<form action="#" method="post">
    <div>
        <table style="font-size: 14px">
            <tr height = "50" id="appIdT">
                <td align = "right">应用ID:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="appId" name="userName" placeholder="应用ID"></td>
            </tr>
            <tr height = "50">
                <td align = "right">应用名称:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="appName" name="loginEmail" placeholder="请输入应用名称"></td>
            </tr>
            <tr height = "50" id="nickNameT">
                <td align = "right">归属用户:&nbsp;&nbsp;</td>
                <td width="250">
                    <span id="beLongUser"></span>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">所属行业:&nbsp;&nbsp;</td>
                <td width="250">
                    <span id="industy"></span>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">适用系统:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 276px;height: 34px" id="platform">
                        <option value="0">请选择</option>
                        <option value="1">Android</option>
                        <option value="2">IOS</option>
                        <option value="3">Windows</option>
                    </select>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">适应终端:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 276px;height: 34px" id="terminal">
                        <option value="0">请选择</option>
                        <option value="1">手机</option>
                        <option value="2">平板</option>
                        <option value="3">电脑</option>
                    </select>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">下载地址:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="downloadlink" placeholder="请输下载地址"></td>
            </tr>
            <tr height = "50">
                <td align = "right">程序主包名:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="packageName" placeholder="请输入程序主包名"></td>
            </tr>
            <tr height = "50">
                <td align = "right">应用版本:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="version" placeholder="请输入应用版本"></td>
            </tr>
            <tr height = "50">
                <td align = "right">关键词:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="keyWords" placeholder="请输入关键词"></td>
            </tr>
            <tr height = "50">
                <td align = "right">应用简介:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="description" placeholder="请输入应用简介"></td>
            </tr>
            <tr height = "50">
                <td></td>
                <td>
                    <input type="button" id="send" value="确定" onclick="createApp()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" id="back" value="重置" onclick="reset()">
                </td>
            </tr>
        </table>
    </div>
</form>


<script language="javascript">

    //session放值
    //sessionStorage.setItem("appUuid",appUuid);

    //进入页面直接请求数据
    $(document).ready(function(){

        //展示分类信息
        industy();

        //普通用户登录状态下,不选择所属用户
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel == 3){
            $('#nickNameT').hide();
        }else{
            //归属用户信息
            beLongUser();
        }

        var appId =  sessionStorage.getItem("appId");
        //session里没有appId的时候是添加app信息
        if(null == appId){
            //隐藏id
            $('#appIdT').hide();
        //session里有appId时,是修改app信息
        }else{
            $('#appUuid').val(appUuid);
            sessionStorage.removeItem("appUuid");
            appName(appUuid);
        }
    });

    //查看app分类
    function industy(){
        $.ajax({
            url: path + "/app/industy",
            type: "Post",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if(data.code == 200){
                    var html = "";
                    //大类部分
                    html += '<select id="rootType" style="width: 134px;height: 34px" onchange="changeType(this)">';
                    html += '<option value="0">全部</option>';
                    var rootList = data.result.rootType;
                    for (var i=0;i<rootList.length;i++){
                        html += '<option value="'+rootList[i].id+'">'+rootList[i].name+'</option>';
                    }
                    html += '</select>&nbsp;&nbsp;';

                    var subList = data.result.subType;
                    //小类部分
                    html += '<select id="subType" style="width: 134px;height: 34px" id="subType">';
                    html += '<option>全部</option>';
                    for (var i=0;i<subList.length;i++){
                        html += '<option value="'+subList[i].id+'?'+subList[i].parentId+'">'+subList[i].name+'</option>';
                    }
                    html += '</select>';

                    $('#industy').html(html);
                }

            },
            error: function () {
                alert("Error");
            }
        });
    }

    //级联菜单根据大类变小类
    function changeType(obj){
        //获取id
        var parentId = obj.value;
        var subTypeList = $("#subType option");
        for(var i = 0; i<subTypeList.length;i++){
            var subType = subTypeList[i].value.split("?")[1];
            if(parentId != subType){
                var v = subTypeList[i].value;
                $("select option[value= '"+v+"']").hide();
            }else{
                var v = subTypeList[i].value;
                $("select option[value= '"+v+"']").show();
            }
        }
    }

    //查看归属用户
    function beLongUser(){
        $.ajax({
            url: path + "/app/beLongUser",
            type: "Post",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                if(data.code == 200){
                    var html = "";
                    html += '<select id="beLongUserId" style="width: 276px;height: 34px">';
                    html += '<option value="0">请选择</option>';
                    var userList = data.result;
                    for(var i=0;i<userList.length;i++){
                        html += '<option value="'+userList[i].userId+'">'+userList[i].nickName+'</option>';
                    }
                    html += '</select>';
                    $('#beLongUser').html(html);
                }

            },
            error: function () {
                alert("Error");
            }
        });
    }

    //创建app信息
    function createApp(){
        //收集参数
        var currentUserLevel = $('#currentUserLevel').val();
        var currentUserId = $('#currentUserId').val();
        var appName = $('#appName').val();
        var downloadlink = $('#downloadlink').val();
        var rootType = $('#rootType').val();
        var subType = $('#subType').val().split("?")[0];
        var platform = $('#platform').val();
        var terminal = $('#terminal').val();
        var packageName = $('#packageName').val();
        var version = $('#version').val();
        var description = $('#description').val();
        var keyWords = $('#keyWords').val();
        var userId;
        if(currentUserLevel == 3){
            userId = currentUserId;
        }else{
            userId = $('#beLongUserId').val();
        }
        if(null==appName || null==downloadlink || 0==rootType || 0==subType || 0==platform || 0==terminal ||
            ""==packageName || ""==version || ""==description || ""==keyWords || null==userId){
            alert("请将信息填写完毕再提交");
        }else{
            //保存app信息
            $.ajax({
                url: path + "/app/createApp",
                data:{
                    "appName" : appName,
                    "downloadlink" : downloadlink,
                    "rootType" : rootType,
                    "subType" : subType,
                    "platform" : platform,
                    "terminal" : terminal,
                    "packageName" : packageName,
                    "version" : version,
                    "description" : description,
                    "keyWords" : keyWords,
                    "userId" : userId,
                    "currentUserLevel" : currentUserLevel
                },
                type: "post",
                dataType: 'json',
                async: false,
                success: function (data) {
                    if(data.code == 200){
                        alert(data.message);
                        gotoURL(path + "/appList");
                    }else if(data.code == 300){
                        alert(data.message);
                        window.location = path + "/login";
                    }else{
                        alert(data.message);
                    }

                },
                error: function () {
                    alert("Error");
                }
            });
        }
    }

</script>

