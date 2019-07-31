<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<font size="4"><STRONG>编辑WEB网站</STRONG></font>
<hr>

<form action="#" method="post">
    <div>
        <table style="font-size: 14px">
            <tr height = "50" id="webIdT">
                <td align = "right">WEBID:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="webId" name="webId" placeholder="WEBID"></td>
            </tr>
            <tr height = "50">
                <td align = "right">WEB名称:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="webName" name="webName" placeholder="请输入应用名称"></td>
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
                <td align = "right">访问量级:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 276px;height: 34px" id="accessLevel">
                        <option value="0">请选择</option>
                        <option value="1">0--1万</option>
                        <option value="2">1万--10万</option>
                        <option value="3">10万--100万</option>
                        <option value="4">100万-1000万</option>
                        <option value="5">1000万以上</option>
                    </select>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">网站地址:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="webUrl" placeholder="请输访问地址"></td>
            </tr>
            <tr height = "50">
                <td align = "right">备案信息:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="recordInfo" placeholder="请输入备案信息"></td>
            </tr>
            <tr height = "50">
                <td align = "right">网站描述:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="webDescription" placeholder="请输入网站描述"></td>
            </tr>
            <tr height = "50">
                <td align = "right">备注信息:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="remark" placeholder="请输入备注信息"></td>
            </tr>
            <tr height = "50">
                <td></td>
                <td>
                    <input type="button" id="send" value="确定" onclick="createWeb()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

        var webId =  sessionStorage.getItem("webId");
        //session里没有webId的时候是添加web信息
        if(null == webId){
            //隐藏id
            $('#webIdT').hide();
            //session里有appId时,是修改app信息
        }else{
            $('#appUuid').val(appUuid);
            sessionStorage.removeItem("appUuid");
            appName(appUuid);
        }
    });

    //查看分类
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

    //创建web信息
    function createWeb(){
        //收集参数
        var currentUserLevel = $('#currentUserLevel').val();
        var currentUserId = $('#currentUserId').val();
        var webName = $('#webName').val();
        var webUrl = $('#webUrl').val();
        var rootType = $('#rootType').val();
        var subType = $('#subType').val().split("?")[0];
        var recordInfo = $('#recordInfo').val();
        var accessLevel = $('#accessLevel').val();
        var webDescription = $('#webDescription').val();
        var remark = $('#remark').val();
        var userId;
        if(currentUserLevel == 3){
            userId = currentUserId;
        }else{
            userId = $('#beLongUserId').val();
        }
        if(""==webName || ""==webUrl || 0==rootType || 0==subType || 0==accessLevel ||
            ""==recordInfo || ""==recordInfo || ""==webDescription || ""==remark || 0==userId){
            alert("请将信息填写完毕再提交");
        }else{
            alert("可以提交");
            //保存app信息
            $.ajax({
                url: path + "/web/createWeb",
                data:{
                    "webName" : webName,
                    "webUrl" : webUrl,
                    "rootType" : rootType,
                    "subType" : subType,
                    "recordInfo" : recordInfo,
                    "accessLevel" : accessLevel,
                    "webDescription" : webDescription,
                    "remark" : remark,
                    "userId" : userId,
                    "currentUserLevel" : currentUserLevel
                },
                type: "post",
                dataType: 'json',
                async: false,
                success: function (data) {
                    if(data.code == 200){
                        alert(data.message);
                        gotoURL(path + "/webList");
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

