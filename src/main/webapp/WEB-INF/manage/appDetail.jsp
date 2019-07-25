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
                <td width="250"><input type="text" size="35" id="nickName" name="passWord" placeholder="归属用户"></td>
            </tr>
            <tr height = "50">
                <td align = "right">所属行业:&nbsp;&nbsp;</td>
                <td width="250">
                    <select style="width: 133px;height: 33.44px">
                        <option>大类</option>
                    </select>&nbsp;&nbsp;
                    <select style="width: 133px;height: 33.44px">
                        <option>小类</option>
                    </select>
                </td>
            </tr>
            <tr height = "50">
                <td align = "right">适用系统:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="appSystem" name="userPhone" placeholder="请输入手机号"></td>
            </tr>
            <tr height = "50">
                <td align = "right">适应终端:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="appTerminal" name="userPhone" placeholder="请输入手机号"></td>
            </tr>
            <tr height = "50">
                <td align = "right">下载地址:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="downloadUrl" name="userPhone" placeholder="请输入手机号"></td>
            </tr>
            <tr height = "50">
                <td align = "right">程序主包名:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="packageName" name="userPhone" placeholder="请输入手机号"></td>
            </tr>
            <tr height = "50">
                <td align = "right">应用版本:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="version" name="userPhone" placeholder="请输入手机号"></td>
            </tr>
            <tr height = "50">
                <td align = "right">关键词:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="keyWords" name="userPhone" placeholder="请输入手机号"></td>
            </tr>
            <tr height = "50">
                <td align = "right">应用简介:&nbsp;&nbsp;</td>
                <td width="250"><input type="text" size="35" id="introduction" name="userPhone" placeholder="请输入手机号"></td>
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

    //进入页面直接请求数据
    $(document).ready(function(){
        //session放值
        //sessionStorage.setItem("appUuid",appUuid);
        var appId =  sessionStorage.getItem("appId");
        if(null == appId){
            alert("没有");
        }else{
            alert("有");
            $('#appUuid').val(appUuid);
            sessionStorage.removeItem("appUuid");
            appName(appUuid);
        }
    });



    $(function() {
        $("#platform").val('${app.platform}');
        $("#terminal").val('${app.terminal}');
        $("#accType").val('${app.accType}');
        $("#rootType").val('${app.rootType}');
        $("#subType").val('${app.subType}');
        $("#owner").val('${app.owner}');

        var appId = '${app.appId}';

        /* if(appId != 0){
            $(".readonly").each(function() {
                $(this).attr('disabled',true);
            });
        } */

        var msg = "";
        //如果是必填的，则加红星标识.
        $("form :input.required").each(function() {
            var $required = $("<strong class='high'> *</strong>"); //创建元素
            $(this).parent().append($required); //然后将它追加到文档中
        });
        //文本框失去焦点后
        $('form :input').blur(
            function() {
                var $parent = $(this).parent();
                $parent.find(".formtips").remove();
                //验证邮件
                if ($(this).is('#email')) {
                    if (this.value == ""
                        || (this.value != "" && !/.+@sogou-inc\.com/
                            .test(this.value))) {
                        var errorMsg = '请输入正确的E-Mail地址,以sogou-inc.com结束.';
                        $parent.append('<span class="formtips onError">'
                            + errorMsg + '</span>');
                    } else {
                        var okMsg = '输入正确.';
                        $parent.append('<span class="formtips onSuccess">'
                            + okMsg + '</span>');
                    }
                }
                if ($(this).is('#roleType')) {
                    if (this.value == ""
                        || (this.value != "0" && this.value!="1")) {
                        var errorMsg = '请选择用户类型';
                        $parent.append('<span class="formtips onError">'
                            + errorMsg + '</span>');
                    } else {
                        var okMsg = '输入正确.';
                        $parent.append('<span class="formtips onSuccess">'
                            + okMsg + '</span>');
                    }
                }
            }).keyup(function() {
            $(this).triggerHandler("blur");
        }).focus(function() {
            $(this).triggerHandler("blur");
        });//end blur

        //提交，最终验证。
        $('#addbtn').click(function() {
            $("form :input.required").trigger('blur');
            var numError = $('form .onError').length;
            if (numError) {
                return false;
            }
            $("#queryform").attr("action", "${scopePrefix}/app/save");
            $("#queryform").submit();
        });
    })

    $("#listbtn").click(function() {
        $("input").val("");
        $("#queryform").attr("action", "${scopePrefix}/app/list");
        $("#queryform").submit();
    })

    $("#rootType").change(function () {
        var tid = $("#rootType option:selected").val();
        $.ajax({
            url: "${scopePrefix}/common/getIndustryByParentId?parentId="+tid,
            type: "Post",
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                var ddl = $("#subType");
                $("#subType option").remove();
                var result = eval(data.data);
                $(result).each(function (key) {
                    var opt = $("<option></option>").text(result[key].name).val(result[key].id);
                    ddl.append(opt);
                });
            },
            error: function () {
                alert("Error");
            }
        });
    });
</script>

