<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>

<head>
    <title>应用审核详情</title>

</head>

<body>
<form id="form" action="#" method="post">
    <font size="4"><strong>APP名称 : <span id="appName"></span></strong></font><p><br>
    <input type="hidden" id="appUuid">
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
            <th style="width:150px;">上传|预览</th>
            <th style="width:160px;">备注</th>
        </tr>
        </thead>
        <tbody id="contentBody">
        </tbody>
    </table>

    <p></p>

    <div align="center">
        <input type="button" id="send" value="确定" onclick="audit()">
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
        var appUuid =  sessionStorage.getItem("appUuid");
        $('#appUuid').val(appUuid);
        sessionStorage.removeItem("appUuid");
        appName(appUuid);
        //隐私检测项
        body();
        //内容检测项
        contentBody();
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

    //隐私权限审核检测项
    function body() {
        $.ajax({
            url: path + "/review/reviewItems",
            type: "post",
            data:{
                reviewType : 1
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    var reviewList = obj.item.reviewItems;
                    var html="";
                    for (var i=0;i<reviewList.length;i++){
                        var review = reviewList[i];
                        html+='<tr>';
                        var reviewItemsList = review.reviewItemsList;
                        for (var j=0;j<reviewItemsList.length;j++){
                            var items = reviewItemsList[j];
                            html+='<tr class="chkList">';
                            html+='<input type="hidden" name="reviewItemsId" value="'+items.id+'"><input type="hidden" name="reviewType" value="1">';
                            html+='<td>'+items.itemsContent+'</td>';
                            html+='<td>'+items.contentDetails+'</td>';
                            html+='<td>'+items.standard+'</td>';
                            html+='<td>'+items.process+'</td>';
                            html+='<td>'+items.evidence+'</td>';
                            html+='<td>';
                                html+='&nbsp;&nbsp;<label><input name="'+items.id+'" type="radio" value="1"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="'+items.id+'" type="radio" value="2"/>未通过</label>&nbsp;&nbsp;<span id="s'+items.id+'"></span><br>';
                                html+='<select id="select" style="width:140px;">';
                                html+='<option value="0">请选择</option>';
                                var detailsList = items.reviewItemsDetailsList;
                                for (var k=0;k<detailsList.length;k++){
                                    var details = detailsList[k];
                                    html+='<option class="op'+items.id+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                                }
                                html+='</select><p><br>';
                                html+='<span class="btn btn-sm btn-primary fileinput-button"><span>上传</span><input type="file" id="file'+items.id+'" onchange="uploadFile('+items.id+')" multiple></span>&nbsp;&nbsp;';
                                html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="seePicture('+items.id+')"></span><input type="hidden" name="fileUrl" id="fileUrl'+items.id+'"><p><br>';
                                //html+='<input type="button" id="preview" value="预览" onclick="seePicture('+items.id+')"><input type="hidden" name="fileUrl" id="fileUrl'+items.id+'"><br>';
                                html+='<input name="remark" type="text" placeholder="请输入备注信息">';
                            html+='</td>';
                            html+='</tr>';
                        }
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

    //隐私权限审核检测项
    function contentBody() {
        $.ajax({
            url: path + "/review/reviewItems",
            type: "post",
            data:{
                reviewType : 2
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    var reviewList = obj.item.reviewItems;
                    var html="";
                    for (var i=0;i<reviewList.length;i++){
                        var review = reviewList[i];
                        html+='<tr>';
                        var reviewItemsList = review.reviewItemsList;
                        for (var j=0;j<reviewItemsList.length;j++){
                            var items = reviewItemsList[j];
                            html+='<tr class="chkList">';
                            html+='<input type="hidden" name="reviewItemsId" value="'+items.id+'"><input type="hidden" name="reviewType" value="2">';
                            html+='<td>'+items.itemsContent+'</td>';
                            html+='<td>&nbsp;&nbsp;<label><input name="'+items.id+'" type="radio" value="1"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="'+items.id+'" type="radio" value="2"/>未通过</label>&nbsp;&nbsp;<span id="s'+items.id+'"></span>';
                            html+='&nbsp;&nbsp;<select id="select" style="width:180px;">';
                            html+='<option value="0">请选择</option>';
                            var detailsList = items.reviewItemsDetailsList;
                            for (var k=0;k<detailsList.length;k++){
                                var details = detailsList[k];
                                html+='<option class="op'+items.id+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                            }
                            html+='</select></td>';
                            html+='<td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="btn btn-sm btn-primary fileinput-button"><span>上传</span><input type="file" id="file'+items.id+'" onchange="uploadFile('+items.id+')" multiple></span>&nbsp;&nbsp;';
                            html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="seePicture('+items.id+')"></span><input type="hidden" name="fileUrl" id="fileUrl'+items.id+'"></td>';
                            html+='<td><input name="remark" type="text" placeholder="请输入备注信息"></td>';
                            html+='</tr>';
                        }
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

    //图片上传
    function uploadFile(itemsId) {

        var appUuid = $('#appUuid').val();
        var file = document.getElementById("file"+itemsId).files;
        if(file.length>3){
            alert("每一项最多上传三张图片");
            return false;
        }
        var formData = new FormData();
        for(var i=0; i<file.length;i++){
            var reader = new FileReader();
            reader.readAsDataURL(file[i]);
            formData.append(i,file[i]);
        }
        formData.append('itemsId', itemsId);
        formData.append('appUuid', appUuid);

        $.ajax({
            url: path + "/review/upload",
            type: "post",
            data: formData,
            contentType: false,
            processData: false,
            mimeType: "multipart/form-data",
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.errorCode == 200){
                    $('#fileUrl'+itemsId).val(data.item.url);
                    alert("图片上传成功");
                }else{
                    alert(data.message);
                }
            },
            error: function (data) {
                console.log(data);
            }
        });
    }

    //审核提交
    function audit() {
        //1.获取页面条数,用于判断传参数据的数量
        var sumNum = $("input[name='reviewItemsId']").size();
        //2.获取全页面单选框选中的数量
        $('input:radio').each(function(){
            //获取单选框的name和value
            var radioId = $(this).attr("name");
            var check = $("input[name = "+radioId+"]:checked").val();
            //点击通过
            if(check != undefined){
                $('#s'+radioId).html('<img src="${ctx}/statics/picture/dui.png">');
            }else{
                $('#s'+radioId).html('<img src="${ctx}/statics/picture/cuo.png">');
            }
        });
        var radioNums = 0;
        $('input:radio:checked').each(function(){
            radioNums=radioNums+1;
        });
        //3.审核项全部审核才可以提交
        if(sumNum == radioNums){
            var appUuid = $('#appUuid').val();
            var objs = [];
            $('.chkList').each(function(index,val){
                var obj = {
                    msgId : null,
                    userId : null,
                    appUuid : appUuid,
                    itemsId : $(val).find('input[name=reviewItemsId]').eq(0).val(),
                    remark : $(val).find('input[name=remark]').eq(0).val(),
                    auditStatus : $(val).find('input:radio:checked').val(),
                    detailsId : $(val).find('#select option:selected').val(),
                    enclosureUrl : $(val).find('input[name=fileUrl]').eq(0).val(),
                    reviewType : $(val).find('input[name=reviewType]').eq(0).val(),
                }
                objs.push(obj)
            })
            console.log(objs);
            //提交数据
            $.ajax({
                url: path + "/review/reviewSubmit",
                type: "post",
                data: {
                    "appUuid" : appUuid,
                    "reviewList" : JSON.stringify(objs)
                },
                dataType: 'json',
                async: false,
                success: function (obj) {
                    if(obj.errorCode == 200){
                        alert(obj.message);
                        gotoURL(path+"/reviewNormalList");
                    }else if(obj.errorCode == "000"){
                        alert(obj.message);
                        window.open(path+"/login");
                    }else{
                        alert(obj.message);
                    }
                },
                error: function () {
                    alert("请求异常");
                }
            });
        }else{
            alert("您有检测项尚未审核");
        }

    }

    //返回到列表页
    function comeBack(){
        gotoURL(path+"/reviewNormalList");
    }

</script>

<style>
    /* //table边框
    table{
         border-collapse:collapse;//表格单元格间距样式
         border:1px solid #FFFFFF;
     }
     tr{
         border:1px solid #000000;
     }
     td{
         border:0px;
     }*/
</style>

</html>

