<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
</head>

<body>
    <button type="button" onclick="submit()">点击提交</button>

</body>
<script type="text/javascript">
    var path = "${ctx}";
</script>
<script src="${ctx}/static/js/jquery.js"></script>
<script type="text/javascript">
    function submit() {
        var a = {"page" : 1, "cate" : 2};
        alert(JSON.stringify(a));
        $.ajax({
            url: path+"news/test",
            type: "post",
            data:JSON.stringify(a),
            contentType:"json/application",
            dataType: 'json',
            async: false,
            success: function(result){
                // var result=JSON.parse(data);
                if(result.code == 200){
                    setNewsList(result);
                    $('#page').val(page + 1);
                }else{
                    alert(result.msg);
                    $('.loading').hide();
                }
            },
            error:function(){
                alert('网络错误,请您稍后重试');
                $('.loading').hide();
            }
        });
    }
</script>
</html>