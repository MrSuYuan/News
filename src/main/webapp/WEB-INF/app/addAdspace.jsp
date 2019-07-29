<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<font size="4"><STRONG>添加代码位</STRONG></font>
<hr>

<form action="#" method="post">
    <div>
        <table style="font-size: 14px">
            <tr height = "50" id="spaceIdT">
                <td align = "right">广告位ID:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="spaceId" name="spaceId" placeholder="请输入广告位ID"></td>
            </tr>
            <tr height = "50">
                <td align = "right">广告位名称:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="spaceName" name="spaceName" placeholder="广告位名称"></td>
            </tr>
            <tr height = "50" id="nickNameT">
                <td align = "right">广告位宽度:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="width" name="width" placeholder="请输入广告位宽度"></td>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">广告位高度:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="height" name="height" placeholder="请输入广告位高度"></td>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">广告位类型:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 276px;height: 34px" id="platform">
                        <option value="0">请选择</option>
                        <option value="1">横幅</option>
                        <option value="2">开屏</option>
                        <option value="3">插屏</option>
                        <option value="4">信息流</option>
                        <option value="5">激励视频</option>
                    </select>
                </td>
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

        var appId =  sessionStorage.getItem("appId");
        //session里没有appId的时候是添加app信息
        if(null == appId){
            //隐藏id
            $('#spaceIdT').hide();
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

