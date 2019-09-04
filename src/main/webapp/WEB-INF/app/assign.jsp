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
            <font size="4"><STRONG>正式服</STRONG></font>
            <table style="font-size: 14px">
                <tr height = "50" id="dfzt">
                    <td align = "right">东方:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="dfz" name="dfz" value="0"></td>
                </tr>
                <tr height = "50" id="wkzt">
                    <td align = "right">万咖:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="wkz" name="wkz" value="0"></td>
                </tr>
                <tr height = "50" id="jgzt">
                    <td align = "right">极光:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="jgz" name="jgz" value="0"></td>
                    </td>
                </tr>
                <tr height = "50" id="ylzt">
                    <td align = "right">余梁:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="ylz" name="ylz" value="0"></td>
                    </td>
                </tr>
                <tr height = "50" id="ydtzt">
                    <td align = "right">一点通:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="ydtz" name="ydtz" value="0"></td>
                    </td>
                </tr>
                <tr height = "50">
                    <td></td>
                    <td>
                        <%--<input type="button" id="editZ" value="编辑" onclick="createAdspace()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                        <input type="button" id="submitZ" value="确定" onclick="updateAssignZ()">
                    </td>
                </tr>
            </table>
        </div>
        <br>
    </form>
    <hr>
    <form action="#" method="post">
        <br>
        <div style="display:inline;width: 50%">
            <font size="4"><STRONG>测试服</STRONG></font>
            <table style="font-size: 14px">
                <tr height = "50" id="dfct">
                    <td align = "right">东方:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="dfc" name="dfc" value="0"></td>
                </tr>
                <tr height = "50" id="wkct">
                    <td align = "right">万咖:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="wkc" name="wkc" value="0"></td>
                </tr>
                <tr height = "50" id="jgct">
                    <td align = "right">极光:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="jgc" name="jgc" value="0"></td>
                    </td>
                </tr>
                <tr height = "50" id="ylct">
                    <td align = "right">余梁:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="ylc" name="ylc" value="0"></td>
                    </td>
                </tr>
                <tr height = "50" id="ydtct">
                    <td align = "right">一点通:&nbsp;&nbsp;</td>
                    <td width="300"><input type="text" size="35" id="ydtc" name="ydtc" value="0"></td>
                    </td>
                </tr>
                <tr height = "50">
                    <td></td>
                    <td>
                        <%--<input type="button" id="editC" value="编辑" onclick="createAdspace()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                        <input type="button" id="submitC" value="确定" onclick="updateAssignC()">
                    </td>
                </tr>
            </table>
        </div>
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
                    if(null == result.dfz){
                        $('#dfzt').hide()
                    }else{
                        $('#dfz').val(result.dfz);
                    }
                    if(null == result.wkz){
                        $('#wkzt').hide()
                    }else{
                        $('#wkz').val(result.wkz);
                    }
                    if(null == result.jgz){
                        $('#jgzt').hide()
                    }else{
                        $('#jgz').val(result.jgz);
                    }
                    if(null == result.ylz){
                        $('#ylzt').hide()
                    }else{
                        $('#ylz').val(result.ylz);
                    }
                    if(null == result.ydtz){
                        $('#ydtzt').hide()
                    }else{
                        $('#ydtz').val(result.ydtz);
                    }

                    if(null == result.dfc){
                        $('#dfct').hide()
                    }else{
                        $('#dfc').val(result.dfc);
                    }
                    if(null == result.wkc){
                        $('#wkct').hide()
                    }else{
                        $('#wkc').val(result.wkc);
                    }
                    if(null == result.jgc){
                        $('#jgct').hide()
                    }else{
                        $('#jgc').val(result.jgc);
                    }
                    if(null == result.ylc){
                        $('#ylct').hide()
                    }else{
                        $('#ylc').val(result.ylc);
                    }
                    if(null == result.ydtc){
                        $('#ydtct').hide()
                    }else{
                        $('#ydtc').val(result.ydtc);
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
    function updateAssignZ(){
        $.ajax({
            url: path + "/app/assignSubmit",
            type: "post",
            data : {
                "df" : $('#dfz').val(),
                "wk" : $('#wkz').val(),
                "jg" : $('#jgz').val(),
                "yl" : $('#ylz').val(),
                "ydt" : $('#ydtz').val(),
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

    //测试服确认提交
    function updateAssignC(){
        $.ajax({
            url: path + "/app/assignSubmit",
            type: "post",
            data : {
                "df" : $('#dfc').val(),
                "wk" : $('#wkc').val(),
                "jg" : $('#jgc').val(),
                "yl" : $('#ylc').val(),
                "ydt" : $('#ydtc').val(),
                "type" : 2
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

