<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>

<head>
    <title>广告位详情</title>
</head>

<body>
<font size="4"><STRONG>广告位详情</STRONG></font>
<hr>
<input type="hidden" id="spaceId">
<form action="#" method="post">
    <div class="row">
        <div class="col-xs-12">
            <div class="table-header"></div>
            <div>
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr style="height: 50px">
                        <th>广告位ID</th>
                        <th>上游广告位ID</th>
                        <th>上游APPID</th>
                        <th>上游平台</th>
                        <th>创建时间</th>
                        <th id="statistics">数据统计</th>
                    </tr>
                    </thead>
                    <tbody id="coll_list_begin_body">
                    </tbody>
                </table>
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


        if(currentUserLevel == 3){
            alert("权限不足");
        }else if(currentUserLevel == 1) {
            $('#statistics').hide();
            var spaceId =  sessionStorage.getItem("spaceId");
            $('#spaceId').val(spaceId);
            sessionStorage.removeItem("spaceId");
            appUpstreamList();
        }else{
            var spaceId =  sessionStorage.getItem("spaceId");
            $('#spaceId').val(spaceId);
            sessionStorage.removeItem("spaceId");
            appUpstreamList();
        }

    });

    //页面数据展示
    function appUpstreamList() {
        var currentUserLevel = $('#currentUserLevel').val();
        $.ajax({
            url: path + "/app/appUpstreamList",
            type: "post",
            data: {
                "spaceId" : $('#spaceId').val()
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    var list = obj.result;
                    var html="";
                    for (var i=0;i<list.length;i++){
                        var data = list[i];
                        html+='<tr style="height: 40px">';
                        html+='<td> '+data.spaceId+'</td>';
                        html+='<td> '+data.upstreamId+'</td>';
                        html+='<td> '+data.upstreamAppId+'</td>';
                        var upstreamType = data.upstreamType;
                        if(upstreamType == 1){
                            html+='<td> 东方 </td>';
                        }else if(upstreamType == 2){
                            html+='<td> 万咖 </td>';
                        }else if(upstreamType == 3){
                            html+='<td> 极光 </td>';
                        }else if(upstreamType == 4){
                            html+='<td> 余梁 </td>';
                        }else if(upstreamType == 5){
                            html+='<td> 一点通 </td>';
                        }else if(upstreamType == 6){
                            html+='<td> 小知 </td>';
                        }else{
                            html+='<td> <font color="red">信息错误</font> </td>';
                        }
                        html+='<td> '+data.createTime+'</td>';
                        if(currentUserLevel == 2){
                            html+='<td><button type="button" onclick="addAppStatistice(\''+data.upstreamId+'\')">添加数据统计</button></td>';
                        }
                        html+='</tr>';
                    }
                    //添加数据
                    $("#coll_list_begin_body").html(html);
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

    function addAppStatistice(upstreamId) {
        sessionStorage.setItem("upstreamId",upstreamId);
        gotoURL(path + "/addAppStatistics");
    }


</script>

</html>

