<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>

<head>
    <title>异常审核详情</title>

</head>

<body>
<form id="form" action="#" method="post">
    <font size="4"><strong>APP名称 : <span id="appName"></span></strong></font><p><br>
    <input type="hidden" id="appUuid">
    <font size="4"><strong>异常审核详情</strong></font><p><br>
    审核人:&nbsp;&nbsp;<span id="user1"></span>(左)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="user2"></span>(右)
    <br>
    注:异常审核员审核需要以左侧结果为基准
    <hr>

    <table border="1">
        <thead>
        <tr>
            <th>检测项</th>
            <th>检内容解读</th>
            <th style="width:200px;">审核操作</th>
            <th style="width:200px;">审核操作</th>
        </tr>
        </thead>
        <tbody id="body">
        </tbody>
    </table>

    <p><br>

    <font size="4"><strong>内容审核</strong></font>
    <hr>
    <table border="1">
        <thead>
        <tr>
            <th>检测项</th>
            <th>审核操作</th>
            <th>审核操作</th>
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

    <!-- 弹窗 -->
    <div id="myModal" class="modal">

        <!-- 关闭按钮 -->
        <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>

        <!-- 弹窗内容 -->
        <span id="pictureSpan"></span>

        <!-- 文本描述 -->
        <div id="caption"></div>
    </div>
</form>
</body>


<script type="text/javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        var appUuid =  sessionStorage.getItem("appUuid");
        $('#appUuid').val(appUuid);
        sessionStorage.removeItem("appUuid");
        appName(appUuid);
        body();
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
            url: path + "/review/errorReviewItems",
            type: "post",
            data: {
                "appUuid" : $('#appUuid').val(),
                "reviewType" : 1
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    $('#user1').html(obj.item.userName1);
                    $('#user2').html(obj.item.userName2);
                    var list = obj.item.reviewItems;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr class="chkList">';
                        html+='<input type="hidden" name="itemsId" value="'+data.itemsId+'"><input type="hidden" name="reviewType" value="1">';
                        if(data.u1AuditStatus != data.u2AuditStatus){
                            html+='<td><font color=red>'+data.itemsContent+'</font></td>';
                            html+='<td><font color=red>'+data.contentDetails+'</font></td>';
                        }else{
                            html+='<td>'+data.itemsContent+'</td>';
                            html+='<td>'+data.contentDetails+'</td>';
                        }

                        <!-- 第一个人的审核结果 -->
                        html+='<td>';
                            if(data.u1AuditStatus == 1){
                                html+='&nbsp;&nbsp;<label><input name="u1'+data.itemsId+'" type="radio" value="1" class="u1Radio" checked/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" class="u1Radio"/>未通过</label><br>';
                            }else{
                                html+='&nbsp;&nbsp;<label><input name="u1'+data.itemsId+'" type="radio" value="1" class="u1Radio"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" class="u1Radio" checked/>未通过</label><br>';
                            }
                            html+='<select style="width:190px;">';
                            html+='<option value="0">请选择</option>';
                            var detailsList = data.reviewItemsDetails;
                            for (var j=0;j<detailsList.length;j++){
                                var details = detailsList[j];
                                if(data.u1DetailsId == details.id){
                                    html+='<option class="opu1'+data.itemsId+'" value="'+details.id+'" selected>'+details.detailsContent+'</option>';
                                }else{
                                    html+='<option class="opu1'+data.itemsId+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                                }
                            }
                            html+='</select><p><br>';
                            html+='<span class="btn btn-sm btn-primary fileinput-button"><span>上传</span><input type="file" id="file'+data.itemsId+'" onchange="uploadFile('+data.itemsId+')" multiple></span>&nbsp;&nbsp;';
                            html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="u1SeePicture('+data.itemsId+')"></span><input type="hidden" name="fileUrl" id="u1FileUrl'+data.itemsId+'" value="'+data.u1EnclosureUrl+'"><p><br>';
                            //html+='<input type="button" id="preview" value="预览" onclick="u1SeePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="u1FileUrl'+data.itemsId+'" value="'+data.u1EnclosureUrl+'">';
                            html+='<input name="u1Remark" type="text" placeholder="备注信息" value="'+data.u1Remark+'" style="width:190px;">';
                        html+='</td>';

                        <!-- 第二个人的审核结果 -->
                        html+='<td>';
                            if(data.u2AuditStatus == 1){
                                html+='&nbsp;&nbsp;<label><input name="u2'+data.itemsId+'" type="radio" value="1" class="u2Radio" checked/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" class="u2Radio"/>未通过</label><br>';
                            }else{
                                html+='&nbsp;&nbsp;<label><input name="u2'+data.itemsId+'" type="radio" value="1" class="u2Radio"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                                html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" class="u2Radio" checked/>未通过</label><br>';
                            }
                            html+='<select style="width:190px;">';
                            html+='<option value="0">请选择</option>';
                            var detailsList = data.reviewItemsDetails;
                            for (var j=0;j<detailsList.length;j++){
                                var details = detailsList[j];
                                if(data.u2DetailsId == details.id){
                                    html+='<option class="opu2'+data.itemsId+'" value="'+details.id+'" selected>'+details.detailsContent+'</option>';
                                }else{
                                    html+='<option class="opu2'+data.itemsId+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                                }
                            }
                            html+='</select><p><br>';
                            html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="u2SeePicture('+data.itemsId+')"></span><input type="hidden" name="fileUrl" id="u2FileUrl'+data.itemsId+'" value="'+data.u2EnclosureUrl+'"><p><br>';
                            //html+='<input type="button" id="preview" value="预览" onclick="u2SeePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="u2FileUrl'+data.itemsId+'" value="'+data.u2EnclosureUrl+'">';
                            html+='<input name="u2Remark" type="text" placeholder="备注信息" value="'+data.u2Remark+'" style="width:190px;">';
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

    //内容审核检测项
    function contentBody() {
        $.ajax({
            url: path + "/review/errorReviewItems",
            type: "post",
            data: {
                "appUuid" : $('#appUuid').val(),
                "reviewType" : 2
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    var list = obj.item.reviewItems;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr class="chkList">';
                        html+='<input type="hidden" name="itemsId" value="'+data.itemsId+'"><input type="hidden" name="reviewType" value="2">';
                        if(data.u1AuditStatus != data.u2AuditStatus){
                            html+='<td><font color=red>'+data.itemsContent+'</font></td>';
                        }else{
                            html+='<td>'+data.itemsContent+'</td>';
                        }

                        <!-- 第一个人的审核结果 -->
                        html+='<td>';
                        if(data.u1AuditStatus == 1){
                            html+='&nbsp;&nbsp;<label><input name="u1'+data.itemsId+'" type="radio" value="1" class="u1Radio" checked/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" class="u1Radio"/>未通过</label><br>';
                        }else{
                            html+='&nbsp;&nbsp;<label><input name="u1'+data.itemsId+'" type="radio" value="1" class="u1Radio"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" class="u1Radio" checked/>未通过</label><br>';
                        }
                        html+='<select style="width:190px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = data.reviewItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(data.u1DetailsId == details.id){
                                html+='<option class="opu1'+data.itemsId+'" value="'+details.id+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu1'+data.itemsId+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select><p><br>';
                        html+='<span class="btn btn-sm btn-primary fileinput-button"><span>上传</span><input type="file" id="file'+data.itemsId+'" onchange="uploadFile('+data.itemsId+')" multiple></span>&nbsp;&nbsp;';
                        html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="u1SeePicture('+data.itemsId+')"></span><input type="hidden" name="fileUrl" id="u1FileUrl'+data.itemsId+'" value="'+data.u1EnclosureUrl+'"><p><br>';
                        //html+='<input type="button" id="preview" value="预览" onclick="u1SeePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="u1FileUrl'+data.itemsId+'" value="'+data.u1EnclosureUrl+'">';
                        html+='<input name="u1Remark" type="text" placeholder="备注信息" value="'+data.u1Remark+'" style="width:190px;">';
                        html+='</td>';

                        <!-- 第二个人的审核结果 -->
                        html+='<td>';
                        if(data.u2AuditStatus == 1){
                            html+='&nbsp;&nbsp;<label><input name="u2'+data.itemsId+'" type="radio" value="1" class="u2Radio" checked/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" class="u2Radio"/>未通过</label><br>';
                        }else{
                            html+='&nbsp;&nbsp;<label><input name="u2'+data.itemsId+'" type="radio" value="1" class="u2Radio"/>通过</label>&nbsp;&nbsp;&nbsp;&nbsp;';
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" class="u2Radio" checked/>未通过</label><br>';
                        }
                        html+='<select style="width:190px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = data.reviewItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(data.u2DetailsId == details.id){
                                html+='<option class="opu2'+data.itemsId+'" value="'+details.id+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu2'+data.itemsId+'" value="'+details.id+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select><p><br>';
                        html+='<span class="btn btn-sm btn-primary fileinput-button"><span>预览</span><input type="button" id="preview" value="预览" onclick="u2SeePicture('+data.itemsId+')"></span><input type="hidden" name="fileUrl" id="u2FileUrl'+data.itemsId+'" value="'+data.u2EnclosureUrl+'"><p><br>';
                        //html+='<input type="button" id="preview" value="预览" onclick="u2SeePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="u2FileUrl'+data.itemsId+'" value="'+data.u2EnclosureUrl+'">';
                        html+='<input name="u2Remark" type="text" placeholder="备注信息" value="'+data.u2Remark+'" style="width:190px;">';
                        html+='</td>';

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
                    $('#u1FileUrl'+itemsId).val(data.item.url);
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


    //u1预览
    function u1SeePicture(itemsId) {
        // 获取弹窗
        var modal = document.getElementById('myModal');

        // 获取图片插入到弹窗
        var fileUrl = $('#u1FileUrl'+itemsId).val();
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

    //u2预览
    function u2SeePicture(itemsId) {
        // 获取弹窗
        var modal = document.getElementById('myModal');

        // 获取图片插入到弹窗
        var fileUrl = $('#u2FileUrl'+itemsId).val();
        var urls = fileUrl.split(",");
        var html = "";
        for(var i=0;i<urls.length;i++){
            html+= '<img src="'+urls[i]+'">';
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


    //审核提交
    function audit() {

        //1.获取页面条数,用于判断传参数据的数量
        var sumNum = $("input[name='itemsId']").size();

        //2.获取全页面单选框选中的数量
        var radioNums = 0;
        $('input:radio:checked').each(function(){
            radioNums=radioNums+1;
        });

        //3.审核项全部审核才可以提交
        var sum = sumNum * 2;
        if(sum == radioNums){

            //4.检测异常审核员审核的两边结果是否一致
            var differentNum = 0;
            $('.chkList').each(function(index,val){
                //用户1的审核结果
                var u1Radio = $(val).find('input:radio:checked').eq(0).val();
                //用户2的审核结果
                var u2Radio = $(val).find('input:radio:checked').eq(1).val();
                if(u1Radio != u2Radio){
                    differentNum = differentNum + 1;
                }
            })

            //5.有不同结果的选项,不予通过
            if(differentNum > 0){
                alert("有不同结果审核项"+differentNum+"个");
            }else{

                //6.将最新数据保存到后台
                var appUuid = $('#appUuid').val();
                var objs = [];
                $('.chkList').each(function(index,val){
                    var obj = {
                        msgId : null,
                        userId : null,
                        appUuid : appUuid,
                        itemsId : $(val).find('input[name=itemsId]').eq(0).val(),
                        remark : $(val).find('input[name=u1Remark]').eq(0).val(),
                        auditStatus : $(val).find('input:radio:checked').eq(0).val(),
                        detailsId : $(val).find('#select option:selected').eq(0).val(),
                        enclosureUrl : $(val).find('input[name=fileUrl]').val(),
                        reviewType : $(val).find('input[name=reviewType]').eq(0).val(),
                    }
                    objs.push(obj)
                })
                //提交数据
                $.ajax({
                    url: path + "/review/errorAuditSubmit",
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
                            gotoURL(path+"/reviewErrorList");
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

            }
        }else{
            alert("您有检测项尚未审核");
        }

    }

    //返回到列表页
    function comeBack(){
        gotoURL(path+"/reviewErrorList");
    }

</script>

<style>
    /* table{
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

