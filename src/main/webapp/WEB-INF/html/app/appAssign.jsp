<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <title>分流</title>
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

<!-- 页面头部 -->
<div id="navbar" class="navbar navbar-default ace-save-state"></div>
<input type="hidden" id="userName" value="${sessionScope.nickName}"/>
<input type="hidden" id="currentUserLevel" value="${sessionScope.userLevel}"/>
<input type="hidden" id="currentUserId" value="${sessionScope.userId}"/>
<input type="hidden" id="ctx" value="${ctx}"/>
<div class="main-container ace-save-state" id="main-container">
    <script type="text/javascript">
        try{ace.settings.loadState('main-container')}catch(e){}
    </script>

    <!-- 左侧导航栏 -->
    <div id="sidebar" class="sidebar responsive ace-save-state"></div>

    <!-- 次头部 -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="${ctx}/index">Home</a>
                    </li>
                    <li class="active">分流</li>
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

            <!-- 页面主体部分 -->
            <div class="page-content">
                <input type="hidden" id="spaceId">
                <div style="width: 100%">
                    <form action="#" method="post">
                        <div style="display:inline;width: 50%">
                            <table style="font-size: 14px">
                                <tr height = "50" id="dft">
                                    <td align = "right">东方:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="df" name="df" value="0"></td>
                                </tr>
                                <tr height = "50" id="wkt">
                                    <td align = "right">万咖:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="wk" name="wk" value="0"></td>
                                </tr>
                                <tr height = "50" id="jgt">
                                    <td align = "right">极光:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="jg" name="jg" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="ylt">
                                    <td align = "right">余梁:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="yl" name="yl" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="ydtt">
                                    <td align = "right">一点通:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="ydt" name="ydt" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="xzt">
                                    <td align = "right">小知:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="xz" name="xz" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="wmt">
                                    <td align = "right">旺脉:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="wm" name="wm" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="yqt">
                                    <td align = "right">甬祺:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="yq" name="yq" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="dkt">
                                    <td align = "right">点开:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="dk" name="dk" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="mjkt">
                                    <td align = "right">迈吉客:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="mjk" name="mjk" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="jlt">
                                    <td align = "right">聚量:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="jl" name="jl" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50" id="zmt">
                                    <td align = "right">众盟:&nbsp;&nbsp;</td>
                                    <td width="300"><input type="text" size="35" id="zm" name="zm" value="0"></td>
                                    </td>
                                </tr>
                                <tr height = "50">
                                    <td></td>
                                    <td>
                                        <%--<input type="button" id="editZ" value="编辑" onclick="createAdspace()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                                        <input type="button" id="submitZ" value="确定" onclick="updateAssign()">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br>
                    </form>
                </div>
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
    loading("appAssign", $('#userName').val());

    //进入页面直接请求数据
    $(document).ready(function(){
        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();
        var spaceId = sessionStorage.getItem("spaceId");
        $('#spaceId').val(spaceId);
        selectAppAssign();
    });

    //数据展示
    function selectAppAssign() {

        $.ajax({
            url: path + "/app/selectAppAssign",
            type: "post",
            data:{
                "spaceId" : $('#spaceId').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                console.log(obj)
                if(obj.code == 200){
                    var result = obj.result;
                    if(null == result.df){
                        $('#dft').hide()
                    }else{
                        $('#df').val(result.df);
                    }
                    if(null == result.wk){
                        $('#wkt').hide()
                    }else{
                        $('#wk').val(result.wk);
                    }
                    if(null == result.jg){
                        $('#jgt').hide()
                    }else{
                        $('#jg').val(result.jg);
                    }
                    if(null == result.yl){
                        $('#ylt').hide()
                    }else{
                        $('#yl').val(result.yl);
                    }
                    if(null == result.ydt){
                        $('#ydtt').hide()
                    }else{
                        $('#ydt').val(result.ydt);
                    }
                    if(null == result.xz){
                        $('#xzt').hide()
                    }else{
                        $('#xz').val(result.xz);
                    }
                    if(null == result.wm){
                        $('#wmt').hide()
                    }else{
                        $('#wm').val(result.wm);
                    }
                    if(null == result.yq){
                        $('#yqt').hide()
                    }else{
                        $('#yq').val(result.yq);
                    }
                    if(null == result.dk){
                        $('#dkt').hide()
                    }else{
                        $('#dk').val(result.dk);
                    }
                    if(null == result.mjk){
                        $('#mjkt').hide()
                    }else{
                        $('#mjk').val(result.mjk);
                    }
                    if(null == result.jl){
                        $('#jlt').hide()
                    }else{
                        $('#jl').val(result.jl);
                    }
                    if(null == result.zm){
                        $('#zmt').hide()
                    }else{
                        $('#zm').val(result.zm);
                    }

                }else if(obj.code == "300"){
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

    //正式服确认提交
    function updateAssign(){
        $.ajax({
            url: path + "/app/assignSubmit",
            type: "post",
            data : {
                "df" : $('#df').val(),
                "wk" : $('#wk').val(),
                "jg" : $('#jg').val(),
                "yl" : $('#yl').val(),
                "ydt" : $('#ydt').val(),
                "xz" : $('#xz').val(),
                "wm" : $('#wm').val(),
                "yq" : $('#yq').val(),
                "dk" : $('#dk').val(),
                "mjk" : $('#mjk').val(),
                "jl" : $('#jl').val(),
                "zm" : $('#zm').val(),
                "spaceId" : $('#spaceId').val(),
                "type" : 1
            },
            dataType: 'json',
            async: false,
            success: function (data) {
                if(data.code == 200){
                    alert(data.message);

                }else if(data.code == "300"){
                    alert(data.message);
                    window.location = path + "/login";
                }else{
                    alert(data.message);
                }

            },
            error: function () {
                alert("请求异常");
            }
        });
    }

</script>

</html>
