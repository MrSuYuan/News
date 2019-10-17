<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title>调度分配</title>
</head>

<body>
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


</body>

<script type="text/javascript">

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

