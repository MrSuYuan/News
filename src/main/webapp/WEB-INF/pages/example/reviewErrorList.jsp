<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
    <title>异常审核列表</title>
</head>

<body>
<font size="4"><STRONG>异常审核</STRONG></font>
<hr>
<%--<form action="${ctx}/user/createUser" method="post">--%>
<form action="#" method="post">
    <div align="center">
        应用名称：<input type="text" id="appName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        应用商店：<span id="options"></span>&nbsp;&nbsp;&nbsp;
        MD5：<input type="text" id="MD5" style="width:150px;height:30px">
        <br><span></span><br>
        上传时间：<input type="date" id="startTime" style="width:150px;height:30px">&nbsp;&nbsp;--&nbsp;&nbsp;
        <input type="date" id="endTime" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;
        审核状态：<select id="auditStatus" style="width:100px;height:30px">
        <option value="0">未审核</option>
        <option value="3">全部</option>
        <option value="1">审核通过</option>
        <option value="2">审核驳回</option>
        <option value="4">对比通过</option>
    </select>
        <input type="button" style="width:50px;height:30px" value="搜索" onclick="selectWaitList($('#currentPage').val())">
    </div>
    <br><span></span><br>
    <div class="row">
        <div class="col-xs-12">
            <div class="table-header"></div>
            <div>
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>应用名称</th>
                        <th>MD5</th>
                        <th>提交时间</th>
                        <th>发布平台名称</th>
                        <th>审核报告</th>
                        <th>审核对比</th>
                        <th>终审状态</th>
                        <th>更新时间</th>
                        <th>包体路径</th>
                    </tr>
                    </thead>
                    <tbody id="coll_list_begin_body">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer no-margin-top">
                页数<a onclick="lastPageData()"><</a>
                &nbsp;<input type="text" id="currentPage" style="width:35px;height:20px">
                <a onclick="nextPageData()">></a>&nbsp;
                共&nbsp;<span id="sumPage"></span>&nbsp;页&nbsp;|&nbsp;
                页面容量
                &nbsp;<input type="text" id="pageSize" style="width:35px;height:20px">&nbsp;|&nbsp;
                共&nbsp;<span id="sumData"></span>&nbsp;条数据
                <ul class="pagination pull-right no-margin" id="coll_begin_page"></ul>
            </div>
        </div>
    </div>
</form>
</body>

<script type="text/javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        channel();
        selectWaitList(1);
    });

    //查询应用商店信息
    function channel(){
        $.ajax({
            url: path + "/review/channel",
            type: "post",
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.errorCode == 200){
                    var list=obj.item.list;
                    var html='<select style="width:150px;height:30px"><option value="0">请选择</option>';
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<option value="'+data.id+'">'+data.name+'</option>';
                    }
                    html+='</select>';
                    $('#options').html(html);

                }else{
                    alert("数据加载错误");
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

    //点击搜索数据展示
    function selectWaitList(currentPage) {
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/review/appErrorAuditList",
            type: "post",
            data: {
                "pageType" : 2,
                "appName" : $('#appName').val(),
                "channelId" :  $('#options option:selected').val(),
                "MD5" : $('#MD5').val(),
                "startTime" : $('#startTime').val(),
                "endTime" : $('#endTime').val(),
                "auditStatus" : $('#auditStatus').val(),
                "currentPage" : currentPage,
                "pageSize" : pageSize
            },
            dataType: 'json',
            async: false,
            success: function (obj) {

                if(obj.errorCode == 200){
                    console.log(obj);
                    var list = obj.item.auditList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr>';
                        html+='<td> '+data.appName+'</td>';
                        html+='<td> '+data.mD5+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        html+='<td> '+data.name+'</td>';
                        html+='<td> <a href="http://124.206.188.50:5000/CertPortal/appScan/fs/report/'+data.uuid+'" target="_blank">查看</a></td>';
                        html+='<td><a id="a" onclick="a(\''+data.appUuid+'\')" style="cursor:pointer">'+data.auditComparison+'</a></td>';
                        html+='<td> '+data.userAuditRemark+'</td>';
                        html+='<td> '+data.auditTime+'</td>';
                        html+='<td> <a href="'+data.applocalpath+'">'+'点击下载'+'</a></td>';
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                    //更新页码
                    $('#currentPage').val(obj.item.currentPage);
                    $('#pageSize').val(obj.item.pageSize);
                    $('#sumPage').html(obj.item.sumPage);
                    $('#sumData').html(obj.item.sumData);
                }else if(obj.errorCode == "100"){
                    alert(obj.message);
                    window.open(path+"/index");
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

    //上一页
    function lastPageData() {
        var page = parseInt($('#currentPage').val());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            selectWaitList(page);
        }
    }

    //下一页
    function nextPageData() {
        var page = parseInt($('#currentPage').val());
        var sumPage = parseInt($('#sumPage').text());
        if(page == sumPage){
            alert("当前是最后一页");
        }else{
            page = page + 1;
            selectWaitList(page);
        }
    }

    //查看审核详情
    function a(appUuid) {
        sessionStorage.setItem("appUuid",appUuid);
        gotoURL(path+"/reviewErrorDetails");
    }

</script>

</html>

