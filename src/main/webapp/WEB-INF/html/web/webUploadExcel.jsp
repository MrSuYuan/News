<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard - Ace Admin</title>
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

<input type="hidden" id="userName" value="${sessionScope.nickName}"/>
<input type="hidden" id="currentUserLevel" value="${sessionScope.userLevel}"/>
<input type="hidden" id="currentUserId" value="${sessionScope.userId}"/>
<input type="hidden" id="ctx" value="${ctx}"/>

<div class="main-container ace-save-state" id="main-container">
    <script type="text/javascript">
        try{ace.settings.loadState('main-container')}catch(e){}
    </script>

    <!-- 次头部 -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}/index">Home</a>
                    </li>
                    <li class="active">WEB上传Excel表格</li>
                </ul><!-- /.breadcrumb -->
                <div class="nav-search" id="nav-search">
                    <a class="btn btn-primary btn-xs">
                        <input type="file" id="file" onchange="uploadFile()" multiple>
                    </a>
                </div><!-- /.nav-search -->
            </div>

            <!-- 页面主体部分 -->
            <div class="page-content">
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr style="height: 50px">
                        <th><font color="red">时间</font></th>
                        <th><font color="red">ID</font></th>
                        <th><font color="red">展现</font></th>
                        <th><font color="red">点击</font></th>
                        <th><font color="red">收益</font></th>
                        <th><font color="red">ECPM</font></th>
                        <th width="60px">系数</th>
                        <th><font color="green">平台ID</font></th>
                        <th><font color="green">广告位名称</font></th>
                        <th><font color="green">分成X</font></th>
                        <th><font color="green">分成Y</font></th>
                        <th><font color="green">收益</font></th>
                        <th><font color="green">ECPM</font></th>
                    </tr>
                    </thead>
                    <tbody id="coll_list_begin_body">
                    </tbody>
                </table>
                <input style="float:right" class="btn btn-sm btn-info no-radius" type="button" value="保存" onclick="submit()">
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
<script type="text/javascript">
    var path = "${ctx}";
</script>
<!-- 加载预加载部分,头部和左导航栏 -->
<script type="text/javascript">

    function uploadFile() {
        var file = document.getElementById("file").files;
        var formData = new FormData();
        for(var i=0; i<file.length;i++){
            var reader = new FileReader();
            reader.readAsDataURL(file[i]);
            formData.append(i,file[i]);
        }

        $.ajax({
            url: path + "/web/webUploadExcel",
            type: "post",
            data: formData,
            contentType: false,
            processData: false,
            mimeType: "multipart/form-data",
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr class="excelTr" style="height: 40px">';
                        html+='<td name="create_Time">'+data.create_Time+'</td>';
                        html+='<td name="upstreamId">'+data.upstreamId+'</td>';
                        html+='<td name="beforeLookPV" id="beforeLookPV'+i+'">'+data.beforeLookPV+'</td>';
                        html+='<td name="beforeClickNum" id="beforeClickNum'+i+'"> '+data.beforeClickNum+'</td>';
                        html+='<td name="beforeIncome" id="beforeIncome'+i+'">'+data.beforeIncome+'</td>';
                        html+='<td name="beforeEcpm">'+data.beforeEcpm+'</td>'
                        html+='<td> <input type="text" style="width:50px" value="1" id="input'+i+'" onchange="change(\''+i+'\')"></td>';
                        html+='<td name="spaceId">'+data.spaceId+'</td>'
                        html+='<td>'+data.spaceName+'</td>'
                        html+='<td id="dividedX'+i+'">'+data.dividedX+'</td>'
                        html+='<td id="dividedY'+i+'">'+data.dividedY+'</td>'
                        html+='<td name="income" id="income'+i+'">'+data.income+'</td>'
                        html+='<td name="ecpm" id="ecpm'+i+'">'+data.ecpm+'</td>'
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求失败");
            }
        });
    }


    function change(i) {
        var xs = $('#input'+i).val();//系数
        if (xs > 1 || xs < 0){
            alert("系数设置错误");
        }else{
            var beforeLookPV = $('#beforeLookPV'+i).text();//展现
            var beforeIncome = $('#beforeIncome'+i).text();//收益
            var dividedX = $('#dividedX'+i).text();//分成
            var dividedY = $('#dividedY'+i).text();//分成
            var income = xs * beforeIncome * dividedX * dividedY;
            var ecpm = xs * beforeIncome * dividedX * dividedY * 1000 / beforeLookPV;

            $('#income'+i).html(income.toFixed(2));//新收益
            $('#ecpm'+i).html(ecpm.toFixed(2));//新ecpm
        }
    }

    /**
     * 提交
     */
    function submit() {
        var objs = [];
        $('.excelTr').each(function(index,val){
            var obj = {
                spaceId : format_text($(val).find('td[name=spaceId]')),
                createTime : format_text($(val).find('td[name=create_Time]')),
                beforeLookPV : format_text($(val).find('td[name=beforeLookPV]')),
                beforeClickNum : format_text($(val).find('td[name=beforeClickNum]')),
                beforeIncome : format_text($(val).find('td[name=beforeIncome]')),
                lookPV : format_text($(val).find('td[name=beforeLookPV]')),
                clickNum : format_text($(val).find('td[name=beforeClickNum]')),
                income : format_text($(val).find('td[name=income]')),
                clickProbability : 0,
                ecpm : format_text($(val).find('td[name=ecpm]')),
            }
            objs.push(obj)
        })
        console.log(objs);

        //提交数据
        $.ajax({
            url: path + "/web/addExcelWebStatistics",
            type: "post",
            data: {
                "statisticsList" : JSON.stringify(objs)
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    alert(obj.message);
                    window.location = path + "/webStatistics";
                }else if(obj.code == 300){
                    alert(obj.message);
                    window.location = path + "/login";
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //格式化数字
    function format_text(str) {
        return str.eq(0).text().replace(/(^\s*)|(\s*$)/g, "");
    }

</script>

</html>
