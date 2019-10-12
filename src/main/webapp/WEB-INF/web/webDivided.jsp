<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>

<!-- 设置模态框 -->
<div class="modal" id="web_divided_set" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form class="form-horizontal" role="form">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">设置APP分润比例</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right "> 展现比例: </label>
                            <div class="col-sm-8">
                                <input type="text" placeholder="输入分润比例" class="col-xs-10 col-sm-7" id="lookProportion">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right "> 点击比例: </label>
                            <div class="col-sm-8">
                                <input type="text" placeholder="输入分润比例" class="col-xs-10 col-sm-7" id="clickProportion">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right "> 上游比例: </label>
                            <div class="col-sm-8">
                                <input type="text" placeholder="输入分润比例" class="col-xs-10 col-sm-7" id="upstreamProportion">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right "> 个人比例: </label>
                            <div class="col-sm-8">
                                <input type="text" placeholder="输入分润比例" class="col-xs-10 col-sm-7" id="userProportion">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="updateProportion()">确定</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>

<script language="javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        $("#web_divided_set").modal("show");
        selectProportion();
    });

    //查看
    function selectProportion() {
        $.ajax({
            url: path + "/user/selectProportion",
            type: "post",
            data: {
                "type" : 2
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    $("#lookProportion").val(obj.result.lookProportion);
                    $("#clickProportion").val(obj.result.clickProportion);
                    $("#upstreamProportion").val(obj.result.upstreamProportion);
                    $("#userProportion").val(obj.result.userProportion);
                }else{
                    alert(obj.message);
                }

            },
            error: function () {
                $.alertModel("网络超时!获取失败!");
            }
        });
    }

    //修改
    function updateProportion() {
        $.ajax({
            url: path + "/user/updateProportion",
            type: "post",
            data: {
                "lookProportion" : $("#lookProportion").val(),
                "clickProportion" : $("#clickProportion").val(),
                "upstreamProportion" : $("#upstreamProportion").val(),
                "userProportion" : $("#userProportion").val(),
                "type" : 2
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    alert(obj.message);
                    $("#index_set").modal("hide");
                }else{
                    alert(obj.message);
                    $("#index_set").modal("show");
                }

            },
            error: function () {
                $.alertModel("网络超时!获取失败!");
            }
        });
    }

</script>

</html>
