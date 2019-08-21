<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<font size="4"><STRONG>添加代码位</STRONG></font>
<hr>

<form action="#" method="post">
    <input type="hidden" id="webId">
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
            <tr height = "50">
                <td align = "right">广告位终端:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 276px;height: 34px" id="terminal">
                        <option value="0">请选择</option>
                        <option value="1">PC</option>
                        <option value="2">WAP</option>
                    </select>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">广告位类型:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 276px;height: 34px" id="spaceType">
                        <option value="0">请选择</option>
                        <option value="1">固定块</option>
                        <option value="2">右下浮</option>
                        <option value="3">对联</option>
                    </select>
                </td>
            </tr>
            <tr height = "50">
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
                <td align = "right">备注:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="remark" name="remark" placeholder="备注信息"></td>
                </td>
            </tr>

            <tr height = "50">
                <td></td>
                <td>
                    <input type="button" id="send" value="确定" onclick="createAdspace()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" id="back" value="重置" onclick="reset()">
                </td>
            </tr>
        </table>
    </div>
</form>


<script language="javascript">

    //进入页面直接请求数据
    $(document).ready(function(){

        var webId =  sessionStorage.getItem("webId");
        $('#webId').val(webId);
        sessionStorage.removeItem("webId");
        $('#spaceIdT').hide();

    });


    //创建广告位信息
    function createAdspace(){
        //收集参数
        var webId = $('#webId').val();
        var spaceName = $('#spaceName').val();
        var width = $('#width').val();
        var height = $('#height').val();
        var spaceType = $('#spaceType').val();
        var terminal = $('#terminal').val();
        var remark = $('#remark').val();
        if(""==webId || ""==spaceName || ""==width || ""==height || 0==spaceType || 0==terminal){
            alert("请将信息填写完毕再提交");
        }else{
            //保存代码位信息
            $.ajax({
                url: path + "/web/createAdspace",
                data:{
                    "webId" : webId,
                    "spaceName" : spaceName,
                    "width" : width,
                    "height" : height,
                    "terminal" : terminal,
                    "remark" : remark,
                    "spaceType" : spaceType
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

