<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
    <title>上传图片</title>
    <link rel="stylesheet" href="${ctx}/statics/common/css/button.css"/>
</head>

<body>
    <font size="4"><strong>上传图片</strong></font>
    <hr>

    <form method="post" action="#" enctype="multipart/form-data">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-header"></div>
                <div>
                    <table id="dynamic-table"
                           class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>图片</th>
                            <th>路径</th>
                        </tr>
                        </thead>

                        <tr>
                            <td>鸣人君</td>
                            <td>
                                <input type="file" onchange="uploadFile()">
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>佐助君</td>
                            <td>
                                <input type="file">
                            </td>
                            <td>
                                <span class="btn btn-sm btn-primary fileinput-button">
                                    <span>上传</span>
                                    <input type="file" id="file" onchange="uploadFile()" multiple>
                                </span>
                                <span class="btn btn-sm btn-primary fileinput-button">
                                    <span>预览</span>
                                    <input type="button" id="yulan" value="预览">
                                </span>
                                <input type="hidden" id="fileUrl">
                            </td>
                        </tr>
                    </table>
                    <input type="submit" value="提交">
                </div>
            </div>
        </div>
    </form>

    <!-- 触发弹窗 - 图片改为你的图片地址 -->
    <!-- 弹窗 -->
    <div id="myModal" class="modal">
        <!-- 关闭按钮 -->
        <span class="close" onclick="document.getElementById('myModal').style.display='none'">&times;</span>
        <!-- 弹窗内容 -->
        <span id="pictureSpan"></span>
        <img class="modal-content" id="img01">
        <!-- 文本描述 -->
        <div id="caption"></div>
    </div>

    <input type="radio" name="radio">通过 <input type="radio" name="radio">驳回
    <span><img src="${ctx}/statics/picture/cuo.png"><img src="${ctx}/statics/picture/dui.png"></span>

</body>

<script src="${ctx}/statics/common/assets/js/jquery-2.1.4.min.js"></script>
<script src="${ctx}/statics/common/js/ajaxfileupload.js"></script>
<script type="text/javascript">

    // 获取弹窗
    var modal = document.getElementById('myModal');

    var url = "http://124.206.188.50:8015/resources/2019-05-28/A0176159ee0cabb0a1724f38bb7888bfeU39I1092502.png,http://124.206.188.50:8015/resources/2019-05-28/A0176159ee0cabb0a1724f38bb7888bfeU39I1092502.png,";
    var urls = url.split(",");
    var html = "";
    for(var i=0;i<urls.length;i++){
        html+= '<img src="'+urls[i]+'">';
    }

    // 获取图片插入到弹窗
    var yulan = document.getElementById('yulan');
    var modalImg = document.getElementById("img01");
    var pictureSpan = document.getElementById("pictureSpan");
    yulan.onclick = function(){
        modal.style.display = "block";
        $('#pictureSpan').html(html);
        //modalImg.src = path+"/statics/common/images/鸣人.png";
    }

    // 获取 <span> 元素，设置关闭按钮
    var span = document.getElementsByClassName("close")[0];

    // 当点击 (x), 关闭弹窗
    span.onclick = function() {
        modal.style.display = "none";
    }

    function uploadFile() {
        var file = document.getElementById("file").files;
        var formData = new FormData();
        for(var i=0; i<file.length;i++){
            alert(file[i]);
            var reader = new FileReader();
            reader.readAsDataURL(file[i]);
            formData.append(i,file[i]);
        }

        $.ajax({
            url: path + "/audit/upload",
            type: "post",
            data: formData,
            contentType: false,
            processData: false,
            mimeType: "multipart/form-data",
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.errorCode == 200){
                    alert("图片上传成功");
                }else{
                    alert(data.message);
                }
            },
            error: function (data) {
                alert("请求失败");
            }
        });
    }


</script>

</html>