<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title> 添加数据统计 </title>
</head>

<body>

<font size="4"><STRONG>添加数据统计</STRONG></font>
<hr>

<input type = "hidden" id="upstreamId">

<div class="row">
    <div class="col-xs-12">
        <div class="table-header"></div>
        <div>
            <table  width="50%" cellpadding="0" cellspacing="0" id="dynamic-table"
                    class="table table-striped table-bordered table-hover">
                <thead>

                <tr style="height: 50px">
                    <th>选择</th>
                    <th>日期</th>
                    <th>代码位ID</th>
                    <th>代码位尺寸</th>
                    <th>媒体</th>
                    <th>计费名</th>
                    <th>广告展现量</th>
                    <th>预计收入</th>
                    <th>点击量</th>
                </tr>

                </thead>
                <tbody id="tbody">
                </tbody>
            </table>
        </div>
    </div>
</div>

<style type="text/css">
    table,th,td{
        border:1px solid #328AA4;
    }
    td input{
        border:none;
        width:100%;
    }
</style>


<input class="btn btn-sm btn-info no-radius" type="button" value="新增" onclick="createRow()">
<input class="btn btn-sm btn-info no-radius" type="button" value="保存" onclick="submit()">
<input class="btn btn-sm btn-info no-radius" type="button" value="删除" onclick="delRow()">

</body>
</html>

<script type="text/javascript">

    /**
     * 动态添加行
     */
    function createRow(){
        var editTable=document.getElementById("tbody");
        var tr=document.createElement("tr");
        tr.className="trClass";
        var td0=document.createElement("td");
        var checkbox=document.createElement("input");
        checkbox.type="checkbox";
        checkbox.name="checkRow";
        td0.appendChild(checkbox);
        var td1=document.createElement("td");
        var date=document.createElement("input");
        date.type="date";
        date.name="createTime";
        td1.appendChild(date);
        var td2=document.createElement("td");
        td2.innerHTML="<input type='text' name='adId'/>";
        var td3=document.createElement("td");
        td3.innerHTML="<input type='text' name='adSize'/>";
        var td4=document.createElement("td");
        td4.innerHTML="<input type='text' name='address'/>";
        var td5=document.createElement("td");
        td5.innerHTML="<input type='text' name='adName'/>";
        var td6=document.createElement("td");
        td6.innerHTML="<input type='text' name='lookPv'/>";
        var td7=document.createElement("td");
        td7.innerHTML="<input type='text' name='income'/>";
        var td8=document.createElement("td");
        td8.innerHTML="<input type='text' name='clickNum'/>";
        tr.appendChild(td0);
        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);
        tr.appendChild(td4);
        tr.appendChild(td5);
        tr.appendChild(td6);
        tr.appendChild(td7);
        tr.appendChild(td8);
        editTable.appendChild(tr);
    }

    /**
     * 动态删除行
     */
    function delRow(){
        var editTable=document.getElementById("tbody");
        var checkboxs=document.getElementsByName("checkRow");
        for(var i=0;i<checkboxs.length;i++){
            if(checkboxs[i].checked){
                var n=checkboxs[i].parentNode.parentNode;
                editTable.removeChild(n);
                i--;
            }
        }
    }

    /**
     * 提交
     */
    function submit() {
        var objs = [];
        $('.trClass').each(function(index,val){
            var obj = {
                createTime : $(val).find('input[name=createTime]').eq(0).val(),
                adId : $(val).find('input[name=adId]').eq(0).val(),
                adSize : $(val).find('input[name=adSize]').eq(0).val(),
                address : $(val).find('input[name=address]').eq(0).val(),
                adName : $(val).find('input[name=adName]').eq(0).val(),
                lookPv : $(val).find('input[name=lookPv]').eq(0).val(),
                income : $(val).find('input[name=income]').eq(0).val(),
                clickNum : $(val).find('input[name=clickNum]').eq(0).val(),
                ecpm : 0,
                clickProbability : 0,
                cpc : 0,
                id : 0,
            }
            objs.push(obj)
        })
        console.log(objs);

        //提交数据
        $.ajax({
            url: path + "/app/addReport",
            type: "post",
            data: {
                "reportList" : JSON.stringify(objs)
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.code == 200){
                    alert(obj.message);
                    gotoURL(path+"/reportList");
                }else if(obj.code == 300){
                    alert(obj.message);
                    gotoURL(path+"/login");
                }else{
                    alert(obj.message);
                }
            },
            error: function () {
                alert("请求异常");
            }
        });
    }

</script>