<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
    <title>广告位列表</title>
</head>

<body>
<font size="4"><STRONG>广告位列表</STRONG></font>
<hr>

<form action="#" method="post">
    <div align="center">
        WEB名称：<input type="text" id="webName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        广告位名称：<input type="text" id="spaceName" style="width:150px;height:30px">&nbsp;&nbsp;&nbsp;&nbsp;
        终端：
        <select id="terminal" style="width:100px;height:30px">
            <option value="0">请选择</option>
            <option value="1">PC</option>
            <option value="2">WAP</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;
        广告位类型：
        <select id="spaceType" style="width:100px;height:30px">
            <option value="0">请选择</option>
            <option value="1">固定块</option>
            <option value="2">右下浮</option>
            <option value="3">对联</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" style="width:50px;height:30px" value="搜索" onclick="webAdspaceList($('#currentPage').val())">&nbsp;&nbsp;

    </div>
    <br><span></span><br>
    <div class="row">
        <div class="col-xs-12">
            <div class="table-header"></div>
            <div>
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr style="height: 50px">
                        <th>广告位ID</th>
                        <th>广告位名称</th>
                        <th>WEB名称</th>
                        <th>终端</th>
                        <th>类型</th>
                        <th>宽度</th>
                        <th>高度</th>
                        <th>创建时间</th>
                        <th id="statistics">数据统计</th>
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

        //根据权限隐藏特定的展示栏和搜索条件
        var currentUserLevel = $('#currentUserLevel').val();
        if(currentUserLevel == 2){
            $('#statistics').show();
        }else{
            $('#statistics').hide();
        }
        webAdspaceList(1);
    });

    //点击搜索数据展示
    function webAdspaceList(currentPage) {
        var currentUserLevel = $('#currentUserLevel').val();
        var pageSize = $('#pageSize').val();
        if(pageSize == ""){
            pageSize = 20;
        }else if(pageSize == 0){
            alert("页码容量不能为0");
            return false;
        }
        $.ajax({
            url: path + "/web/webAdspaceList",
            type: "post",
            data: {
                "currentPage" : currentPage,
                "pageSize" : pageSize,
                "webName" : $('#webName').val(),
                "spaceName" : $('#spaceName').val(),
                "terminal" : $('#terminal').val(),
                "spaceType" :  $('#spaceType option:selected').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result.adspaceList;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.spaceId+'</td>';
                        html+='<td> '+data.spaceName+'</td>';
                        html+='<td> '+data.webName+'</td>';
                        var terminal = data.terminal;
                        if(terminal == 1){
                            html+='<td> PC </td>';
                        }else if(terminal == 2){
                            html+='<td> WAP </td>';
                        }else{
                            html+='<td> <font color="red">信息错误</font> </td>';
                        }
                        var spaceType = data.spaceType;
                        if(spaceType == 1){
                            html+='<td> 固定块 </td>';
                        }else if(spaceType == 2){
                            html+='<td> 右下浮 </td>';
                        }else if(spaceType == 3){
                            html+='<td> 对联 </td>';
                        }else{
                            html+='<td> <font color="red">信息错误</font> </td>';
                        }
                        html+='<td> '+data.width+'</td>';
                        html+='<td> '+data.height+'</td>';
                        html+='<td> '+data.createTime+'</td>';
                        if(currentUserLevel == 2){
                            html+='<td><button type="button" onclick="addWebStatistice(\''+data.spaceId+'\')">添加数据统计</button></td>';
                        }
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
                    //更新页码
                    $('#currentPage').val(obj.result.currentPage);
                    $('#pageSize').val(obj.result.pageSize);
                    $('#sumPage').html(obj.result.sumPage);
                    $('#sumData').html(obj.result.sumData);
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

    //上一页
    function lastPageData() {
        var page = parseInt($('#currentPage').val());
        if(page == 1){
            alert("当前是第一页");
        }else{
            page = page - 1;
            webAdspaceList(page);
        }
    }

    //下一页
    function nextPageData() {
        var page = parseInt($('#currentPage').val());
        var sumPage = parseInt($('#sumPage').text());
        if(page == sumPage){
            alert("当前是最后一页");
        }else{
            var page = page + 1;
            webAdspaceList(page);
        }
    }

    function addWebStatistice(spaceId) {
        sessionStorage.setItem("spaceId",spaceId);
        gotoURL(path + "/addWebStatistics");
    }

</script>

</html>

