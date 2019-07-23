<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>

<head>
    <title>异常审核详情</title>
</head>

<body>
<form id="form" action="#" method="post">
    <input type="hidden" id="appUuid">
    <font size="4"><strong>隐私权限审核</strong></font><p><br>
    审核人:&nbsp;&nbsp;<span id="user1"></span>(左)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="user2"></span>(右)
    <hr>

    <table>
        <thead>
        <tr>
            <th>检测项</th>
            <th>检测详情内容</th>
            <th style="width:150px;">审核操作</th>
            <th style="width:50px;">上传</th>
            <th style="width:50px;">附件</th>
            <th style="width:100px;">备注</th>
            <th style="width:150px;">审核操作</th>
            <th style="width:50px;">附件</th>
            <th style="width:90px;">备注</th>
        </tr>
        </thead>
        <tbody id="hideBody">
        </tbody>
    </table>

    <font size="4"><strong>内容审核</strong></font>
    <hr>
    <table>
        <thead>
        <tr>
            <th>检测项</th>
            <th style="width:150px;">审核操作</th>
            <th style="width:50px;">上传</th>
            <th style="width:50px;">附件</th>
            <th style="width:120px;">备注</th>
            <th style="width:150px;">审核操作</th>
            <th style="width:50px;">附件</th>
            <th style="width:110px;">备注</th>
        </tr>
        </thead>
        <tbody id="contentBody">
        </tbody>
    </table>
    <p><br>
    <div align="center">
        <input type="button" id="send" value="确定" onclick="audit()">
        <span></span>
        <input type="button" id="back" value="返回" onclick="comeBack()">
    </div>
</form>
</body>


<script type="text/javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        var appUuid =  sessionStorage.getItem("appUuid");
        $('#appUuid').val(appUuid);
        sessionStorage.removeItem("appUuid");
        hideBody(1);
        contentBody(2);
    });

    //隐私权限审核检测项
    function hideBody(itemsType) {
        $.ajax({
            url: path + "/audit/errorAuditMessage",
            type: "post",
            data: {
                "appUuid" : $('#appUuid').val(),
                "itemsType" : itemsType
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    $('#user1').html(obj.item.userName1);
                    $('#user2').html(obj.item.userName2);
                    var list = obj.item.auditItems;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr class="chkList">';
                        html+='<input type="hidden" name="hideAuditItemsId" value="'+data.itemsId+'">';
                        if(data.u1AuditStatus != data.u2AuditStatus){
                            html+='<td><font color=red>'+data.itemsId+'.'+data.itemsTitle+'</font></td>';
                            html+='<td><font color=red>'+data.itemsContent+'</font></td>';
                        }else{
                            html+='<td>'+data.itemsId+'.'+data.itemsTitle+'</td>';
                            html+='<td>'+data.itemsContent+'</td>';
                        }
                        html+='<td>';
                        if(data.u1AuditStatus == 1){
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="1" class="u1Radio" checked/>通过</label>';
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" class="u1Radio"/>未通过</label>';
                        }else{
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="1" class="u1Radio"/>通过</label>';
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" class="u1Radio" checked/>未通过</label>';
                        }
                        html+='<select style="width:140px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = data.auditItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(data.u1DetailsId == details.detailsId){
                                html+='<option class="opu1'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu1'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select>';
                        html+='</td>';
                        //html+='<td><input type="file" id="file'+data.itemsId+'" onchange="uploadFile('+data.itemsId+')"></td>';
                        html+='<td><span class="fileinput-button"><button>上传</button><input type="file" id="file'+data.itemsId+'" onchange="uploadFile('+data.itemsId+')"></span></td>';
                        html+='<td><input type="button" id="preview" value="预览" onclick="seePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="fileUrl'+data.itemsId+'"></td>';
                        html+='<td><input name="u1hideRemark" type="text" placeholder="备注信息" value="'+data.u1Remark+'" style="width:90px;"></td>';

                        html+='<td>';
                        if(data.u2AuditStatus == 1){
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="1" class="u2Radio" checked/>通过</label>';
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" class="u2Radio"/>未通过</label>';
                        }else{
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="1" class="u2Radio"/>通过</label>';
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" class="u2Radio" checked/>未通过</label>';
                        }
                        html+='<select style="width:140px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = data.auditItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(data.u2DetailsId == details.detailsId){
                                html+='<option class="opu2'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu2'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select>';
                        html+='</td>';
                        html+='<td><input type="button" id="preview" value="预览" onclick="seePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="fileUrl'+data.itemsId+'"></td>';
                        html+='<td><input name="u2hideRemark" type="text" placeholder="备注信息" value="'+data.u2Remark+'" style="width:90px;"></td>';

                        html+='</tr>';
                    }
                    //添加数据
                    $("#hideBody").html(html);
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
    function contentBody(itemsType) {
        $.ajax({
            url: path + "/audit/errorAuditMessage",
            type: "post",
            data: {
                "appUuid" : $('#appUuid').val(),
                "itemsType" : itemsType
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.errorCode == 200){
                    var list = obj.item.auditItems;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr class="chkList">';
                        html+='<input type="hidden" name="hideAuditItemsId" value="'+data.itemsId+'">';
                        if(data.u1AuditStatus != data.u2AuditStatus){
                            html+='<td><font color=red>'+data.itemsId+'.'+data.itemsTitle+'</font></td>';
                        }else{
                            html+='<td>'+data.itemsId+'.'+data.itemsTitle+'</td>';
                        }
                        html+='<td>';
                        if(data.u1AuditStatus == 1){
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="1" checked/>通过</label>';
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2"/>未通过</label>';
                        }else{
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="1"/>通过</label>';
                            html+='<label><input name="u1'+data.itemsId+'" type="radio" value="2" checked/>未通过</label>';
                        }
                        html+='<select style="width:140px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = data.auditItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(data.u1DetailsId == details.detailsId){
                                html+='<option class="opu1'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu1'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select>';
                        html+='</td>';
                        //html+='<td><input type="file" id="file'+data.itemsId+'" onchange="uploadFile('+data.itemsId+')"></td>';
                        html+='<td><span class="fileinput-button"><button>上传</button><input type="file" id="file'+data.itemsId+'" onchange="uploadFile('+data.itemsId+')"></span></td>';
                        html+='<td><input type="button" id="preview" value="预览" onclick="seePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="fileUrl'+data.itemsId+'"></td>';
                        html+='<td><input name="u1hideRemark" type="text" placeholder="备注信息" value="'+data.u1Remark+'" style="width:110px;"></td>';

                        html+='<td>';
                        if(data.u2AuditStatus == 1){
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="1" checked/>通过</label>';
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2"/>未通过</label>';
                        }else{
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="1"/>通过</label>';
                            html+='<label><input name="u2'+data.itemsId+'" type="radio" value="2" checked/>未通过</label>';
                        }
                        html+='<select style="width:140px;">';
                        html+='<option value="0">请选择</option>';
                        var detailsList = data.auditItemsDetails;
                        for (var j=0;j<detailsList.length;j++){
                            var details = detailsList[j];
                            if(data.u2DetailsId == details.detailsId){
                                html+='<option class="opu2'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'" selected>'+details.detailsContent+'</option>';
                            }else{
                                html+='<option class="opu2'+data.itemsId+'" value="'+details.detailsId+'?'+details.detailsType+'">'+details.detailsContent+'</option>';
                            }
                        }
                        html+='</select>';
                        html+='</td>';
                        html+='<td><input type="button" id="preview" value="预览" onclick="seePicture('+data.itemsId+')"><input type="hidden" name="fileUrl" id="fileUrl'+data.itemsId+'"></td>';
                        html+='<td><input name="u2hideRemark" type="text" placeholder="备注信息" value="'+data.u2Remark+'" style="width:110px;"></td>';

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
                var val=$(this).val();
                var idAndType = val.split("?");
                var type = idAndType[1];
                if(type == 1){
                    this.style='display:block';
                }
                if(type == 2){
                    this.style='display:none';
                }
            });
        }
        //点击未通过
        if(radioVal == 2){
            $('.op'+radioId).each(function (){
                var val=$(this).val();
                var idAndType = val.split("?");
                var type = idAndType[1];
                if(type == 1){
                    this.style='display:none';
                }
                if(type == 2){
                    this.style='display:block';
                }
            });
        }
    })

    //预览
    function seePicture(itemsId) {
        // 获取弹窗
        var modal = document.getElementById('myModal');

        // 获取图片插入到弹窗
        var fileUrl = $('#fileUrl'+itemsId).val();
        alert(fileUrl);
        var modalImg = document.getElementById("img01");
        modal.style.display = "block";

        modalImg.src = fileUrl;

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
        var file = document.getElementById("file"+itemsId).files[0];
        var formData = new FormData();
        formData.append('file', file);
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
        var sumNum = $("input[name='hideAuditItemsId']").size()+$("input[name='contentAuditItemsId']").size();

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
                        itemsId : $(val).find('input[name=hideAuditItemsId]').eq(0).val(),
                        remark : $(val).find('input[name=hideRemark]').eq(0).val(),
                        auditStatus : $(val).find('input:radio:checked').val(),
                        detailsId : null,
                        enclosureUrl : $(val).find('input[name=fileUrl]').eq(0).val(),
                    }
                    objs.push(obj)
                })
                //提交数据
                $.ajax({
                    url: path + "/audit/errorAuditSubmit",
                    type: "post",
                    data: {
                        "appUuid" : appUuid,
                        "auditList" : JSON.stringify(objs)
                    },
                    dataType: 'json',
                    async: false,
                    success: function (obj) {

                        if(obj.errorCode == 200){
                            alert(obj.message);
                            gotoURL(path+"/appErrorAuditList");
                        }else if(obj.errorCode == "000"){
                            alert(obj.message);
                            window.open(path+"/login");
                        }else{
                            alert("数据加载错误");
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
        gotoURL(path+"/appAudit");
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

