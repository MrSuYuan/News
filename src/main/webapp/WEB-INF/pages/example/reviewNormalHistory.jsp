<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>

<head>
    <title>应用审核历史预览</title>

</head>

<body>
<form id="form" action="#" method="post">
    <font size="4"><strong>APP名称 : <span id="appName"></span></strong></font><p><br>
    <input type="hidden" id="appUuid">
    <input type="hidden" id="userId">
    <font size="4"><strong>隐私权限审核</strong></font>
    <hr>
    <table border="1">
        <thead>
        <tr>
            <th style="width:60px;"><font size="3">检测项</font></th>
            <th><font size="3">内容解读</font></th>
            <th><font size="3">判定标准</font></th>
            <th><font size="3">操作流程</font></th>
            <th><font size="3">存证</font></th>
            <th style="width:150px;"><font size="3">审核操作</font></th>
        </tr>
        </thead>
        <tbody id="body">
        </tbody>
    </table>

    <p></p>

    <font size="4"><strong>内容审核</strong></font>
    <hr>
    <table border="1">
        <thead>
        <tr>
            <th>检测项</th>
            <th style="width:180px;">审核操作</th>
            <th style="width:150px;">预览</th>
            <th style="width:160px;">备注</th>
        </tr>
        </thead>
        <tbody id="contentBody">
        </tbody>
    </table>

    <p></p>

    <div align="center">
        <input type="button" id="send" value="已审核">
        <span></span>
        <input type="button" id="back" value="返回" onclick="comeBack()">
    </div>
</form>

<!-- 弹窗 -->
<div id="myModal" class="modal">

    <!-- 关闭按钮 -->
    <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>

    <!-- 弹窗内容 -->
    <span id="pictureSpan"></span>

    <!-- 文本描述 -->
    <div id="caption"></div>
</div>

</body>

<script type="text/javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        var obj =  sessionStorage.getItem("obj");
        var appUuid =  obj.split(",")[0];
        var userId =  obj.split(",")[1];
        $('#appUuid').val(appUuid);
        $('#userId').val(userId);
        sessionStorage.removeItem("obj");
        appName(appUuid);
        body(appUuid,userId);
        contentBody(appUuid,userId);
    });

    //app名称
    function appName(appUuid) {
        $.ajax({
            url: path + "/review/appName",
            type: "post",
            data: {
                "appUuid" : appUuid
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    $('#appName').html(obj.item.appName);
                }else{
                    alert("数据加载错误");
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //隐私审核项结果
    function body(appUuid,userId) {
        $.ajax({
            url: path + "/review/reviewNormalHistory",
            type: "post",
            data: {
                "appUuid" : appUuid,
                "userId" : userId,
                reviewType : 1
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    var reviewList = obj.item.reviewItems;
                    var html="";
                    for (var i=0;i<reviewList.length;i++){
                        var items = reviewList[i];
                        html+='<tr class="chkList">';
                        html+='<td>'+items.itemsContent+'</td>';
                        html+='<td>'+items.contentDetails+'</td>';
                        html+='<td>'+items.standard+'</td>';
                        html+='<td>'+items.process+'</td>';
                        html+='<td>'+items.evidence+'</td>';
                        html+='<td>';
                            if(items.auditStatus == 1){
                                html+='&nbsp;&nbsp;<label><input name="'+items.itemsId+'" type="radio" value="1" checked/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="'+items.itemsId+'" type="radio" value="2"/>未通过</label><br>';
                            }else{
                                html+='&nbsp;&nbsp;<label><input name="'+items.itemsId+'" type="radio" value="1"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="'+items.itemsId+'" type="radio" value="2" checked/>未通过</label><br>';
                            }
                            html+='<select id="select" style="width:140px;">';
                            html+='<option value="0">请选择</option>';
                            var detailsList = items.reviewItemsDetails;
                            for (var j=0;j<detailsList.length;j++){
                                var details = detailsList[j];
                                if(items.detailsId == details.id){
                                    html+='<option class="opu1'+items.itemsId+'" value="'+details.id+'" selected>'+details.detailsContent+'</option>';
                                }else{
                                    html+='<option class="opu1'+items.itemsId+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                                }
                            }
                            html+='</select><p><br>';
                        html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="seePicture('+items.itemsId+')"></span><input type="hidden" name="fileUrl" id="fileUrl'+items.itemsId+'" value="'+items.enclosureUrl+'"><p><br>';
                        html+='<input name="remark" type="text" value="'+items.remark+'" placeholder="未填写备注">';
                        html+='</td>';
                        html+='</tr>';
                    }

                    //添加数据
                    $("#body").html(html);
                }else{
                    alert("数据加载错误");
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //内容权限审核检测项
    function contentBody(appUuid,userId) {
        $.ajax({
            url: path + "/review/reviewNormalHistory",
            type: "post",
            data: {
                "appUuid" : appUuid,
                "userId" : userId,
                reviewType : 2
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    var reviewList = obj.item.reviewItems;
                    var html="";
                    for (var i=0;i<reviewList.length;i++){
                        var items = reviewList[i];
                        html+='<tr class="chkList">';
                        html+='<td>'+items.itemsContent+'</td>';
                        html+='<td>';
                        if(items.auditStatus == 1){
                            html+='&nbsp;&nbsp;<label><input name="'+items.itemsId+'" type="radio" value="1" checked/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="'+items.itemsId+'" type="radio" value="2"/>未通过</label><br>';
                        }else{
                            html+='&nbsp;&nbsp;<label><input name="'+items.itemsId+'" type="radio" value="1"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="'+items.itemsId+'" type="radio" value="2" checked/>未通过</label><br>';
                        }
                        html+='<select id="select" style="width:180px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = items.reviewItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(items.detailsId == details.id){
                                html+='<option class="opu1'+items.itemsId+'" value="'+details.id+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu1'+items.itemsId+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select></td>';
                        html+='<td><span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="seePicture('+items.itemsId+')"></span><input type="hidden" name="fileUrl" id="fileUrl'+items.itemsId+'" value="'+items.enclosureUrl+'"></td>';
                        html+='<td><input name="remark" type="text" value="'+items.remark+'" placeholder="未填写备注"></td>';
                        html+='</tr>';
                    }

                    //添加数据
                    $("#contentBody").html(html);
                }else{
                    alert("数据加载错误");
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }


    //下拉框内容受单选框选择影响
    $('input:radio').change(function () {
        //获取单选框的name和value
        var radioId = $(this).attr("name");
        var radioVal = $(this).val();
        //点击通过
        if(radioVal == 1){
            $('.op'+radioId).each(function (){
                this.style='display:none';
            });
        }
        //点击未通过
        if(radioVal == 2){
            $('.op'+radioId).each(function (){
                this.style='display:block';
            });
        }
    })

    //预览
    function seePicture(itemsId) {
        // 获取弹窗
        var modal = document.getElementById('myModal');

        // 获取图片插入到弹窗
        var fileUrl = $('#fileUrl'+itemsId).val();
        var urls = fileUrl.split(",");
        var html = "";
        for(var i=0;i<urls.length;i++){
            html+= '<img src="'+urls[i]+'"><br>';
        }
        modal.style.display = "block";
        $('#pictureSpan').html(html);

        // 获取 <span> 元素，设置关闭按钮
        var span = document.getElementsByClassName("close")[0];

        // 当点击 (x), 关闭弹窗
        span.onclick = function() {
            modal.style.display = "none";
        }
    }


    //返回到列表页
    function comeBack(){
        gotoURL(path+"/reviewNormalList");
    }

</script>

<style>

</style>

</html>

