<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>后台管理</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <meta name="description" content="overview &amp; stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

    <link rel="stylesheet" href="${ctx}/static/common/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/fonts.googleapis.com.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-skins.min.css" />
    <link rel="stylesheet" href="${ctx}/static/common/assets/css/ace-rtl.min.css" />

    <script src="${ctx}/static/common/assets/js/ace-extra.min.js"></script>
</head>

<body class="no-skin">
<div id="navbar" class="navbar navbar-default ace-save-state">
</div>
<input type="hidden" id="userName" value="${sessionScope.nickName}"/>
<input type="hidden" id="currentUserLevel" value="${sessionScope.userLevel}"/>
<input type="hidden" id="currentUserId" value="${sessionScope.userId}"/>
<input type="hidden" id="ctx" value="${ctx}"/>

<div class="main-container ace-save-state" id="main-container">
    <script type="text/javascript">
        try{ace.settings.loadState('main-container')}catch(e){}
    </script>

    <div id="sidebar" class="sidebar responsive ace-save-state">
    </div>

    <div class="main-content">

        <!-- 页面次头部 -->
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}/index">Home</a>
                    </li>
                    <li class="active">主页</li>
                </ul><!-- /.breadcrumb -->
                <div class="nav-search" id="nav-search">
                    <form class="form-search">
                            <span class="input-icon">
                                <input type="text" placeholder="敬请期待" class="nav-search-input" id="nav-search-input" autocomplete="off" />
                                <i class="ace-icon fa fa-search nav-search-icon"></i>
                            </span>
                    </form>
                </div><!-- /.nav-search -->
            </div>

            <!-- 正文主页面部分 -->
            <div class="page-content">
                上传百度统计Excel
                <form method="post" action="#" enctype="multipart/form-data">
                    <table>
                        <tr>
                            <td>
                                <input type="file" id="file" onchange="uploadFile()" multiple>
                            </td>
                        </tr>
                    </table>
                </form>

            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->

    <!-- 页面尾部 -->
    <div class="footer" id ="footer"></div>
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->

</body>

<script src="${ctx}/static/common/assets/js/jquery-2.1.4.min.js"></script>
<script src="${ctx}/static/manage/index/template.js"></script>

<script type="text/javascript">
    var path = "${ctx}";
</script>
<script type="text/javascript">
    loading("webReadExcel",$('#userName').val());

    function uploadFile() {
        var file = document.getElementById("file").files;
        var formData = new FormData();
        for(var i=0; i<file.length;i++){
            var reader = new FileReader();
            reader.readAsDataURL(file[i]);
            formData.append(i,file[i]);
        }

        $.ajax({
            url: path + "/web/upload",
            type: "post",
            data: formData,
            contentType: false,
            processData: false,
            mimeType: "multipart/form-data",
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.code == 200){
                    alert("上传成功");
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
<script src="${ctx}/static/common/assets/js/bootstrap.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery-ui.custom.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.easypiechart.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.sparkline.index.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.pie.min.js"></script>
<script src="${ctx}/static/common/assets/js/jquery.flot.resize.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace-elements.min.js"></script>
<script src="${ctx}/static/common/assets/js/ace.min.js"></script>

</html>
