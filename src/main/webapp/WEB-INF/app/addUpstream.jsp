<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<font size="4"><STRONG>审核广告位</STRONG></font>
<hr>

<form action="#" method="post">
    <input type="hidden" id="appId">
    <div>
        <table style="font-size: 14px">
            <tr height = "50" id="spaceIdT">
                <td align = "right">广告位ID:&nbsp;&nbsp;</td>
                <td width="300"><span id="spaceId"></span><%--<input type="text" size="35" id="spaceId" name="spaceId" placeholder="平台广告位ID" disabled="disabled">--%><font color="red">&nbsp;&nbsp;*</font></td>
            </tr>
            <tr height = "50">
                <td align = "right">上游广告位ID:&nbsp;&nbsp;</td>
                <td width="300"><input type="text" size="35" id="upstreamId" name="upstreamId" placeholder="上游广告位ID"><font color="red">&nbsp;&nbsp;*</font></td>
            </tr>
            <tr height = "50">
                <td align = "right">上游APPID:&nbsp;&nbsp;</td>
                <td width="300"><input type="text" size="35" id="upstreamAppId" name="upstreamAppId" placeholder="上游APPID"></td>
                </td>
            </tr>
            </tr>
            <tr height = "50">
                <td align = "right">上游平台:&nbsp;&nbsp;</td>
                <td width="300">
                    <select style="width: 276px;height: 34px" id="upstreamType">
                        <option value="0">请选择</option>
                        <option value="1">东方</option>
                        <option value="2">万咖</option>
                        <option value="3">极光</option>
                        <option value="4">余梁</option>
                        <option value="5">一点通</option>
                    </select>
                    <font color="red">&nbsp;&nbsp;*</font>
                </td>
            </tr>
            <tr height = "50">
                <td></td>
                <td>
                    <input type="button" id="send" value="确定" onclick="createAdUpstream()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" id="back" value="重置" onclick="reset()">
                </td>
            </tr>
        </table>
    </div>
</form>


<script language="javascript">

    //进入页面直接请求数据
    $(document).ready(function(){

        var spaceId =  sessionStorage.getItem("spaceId");
        $('#spaceId').html(spaceId);
        sessionStorage.removeItem("spaceId");

    });


    //提交广告位上游信息
    function createAdUpstream(){
        //收集参数
        var spaceId = document.getElementById("spaceId").innerHTML;
        var upstreamId = $('#upstreamId').val();
        var upstreamAppId = $('#upstreamAppId').val();
        var upstreamType = $('#upstreamType').val();
        if(""==upstreamId || 0==upstreamType){
            alert("请将信息填写完毕再提交");
        }else{
            //保存代码位信息
            $.ajax({
                url: path + "/app/appAdUpstream",
                data:{
                    "spaceId" : spaceId,
                    "upstreamId" : upstreamId,
                    "upstreamAppId" : upstreamAppId,
                    "upstreamType" : upstreamType
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

