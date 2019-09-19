<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html lang="en" class="">

<head>
    <meta charset=utf-8>
    <meta http-equiv=X-UA-Compatible content="IE=edge">
    <link rel=icon href=https://mssp.baidu.com/bqt/favicon.ico>
    <link rel=stylesheet href=https://mssp.baidu.com/bqt/nprogress/nprogress.css>
    <title>百青藤</title>
    <link href=https://mssp.baidu.com/bqt/css/website-bundle.632aad23.css rel=prefetch>
    <link href=https://mssp.baidu.com/bqt/js/website-bundle.cd852384.js rel=prefetch>
    <link href=https://mssp.baidu.com/bqt/css/chunk-common.3ee374fc.css rel=preload as=style>
    <link href=https://mssp.baidu.com/bqt/css/chunk-vendors.b02c10d4.css rel=preload as=style>
    <link href=https://mssp.baidu.com/bqt/css/websiteco.ee1140a4.css rel=preload as=style>
    <link href=https://mssp.baidu.com/bqt/js/chunk-common.10adc6eb.js rel=preload as=script>
    <link href=https://mssp.baidu.com/bqt/js/chunk-vendors.5d9814b7.js rel=preload as=script>
    <link href=https://mssp.baidu.com/bqt/js/websiteco.c2e76cac.js rel=preload as=script>
    <link href=https://mssp.baidu.com/bqt/css/chunk-vendors.b02c10d4.css rel=stylesheet>
    <link href=https://mssp.baidu.com/bqt/css/chunk-common.3ee374fc.css rel=stylesheet>
    <link href=https://mssp.baidu.com/bqt/css/websiteco.ee1140a4.css rel=stylesheet>
</head>

<body>
<script src="https://hm.baidu.com/hm.js?776949f88324f6b5ac7dfac51763a596"></script>
<script src="https://mssp.baidu.com/bqt/nprogress/nprogress.js"></script>

<div id="app" class="app-view">

    <div class="base-view list-view adp-report-view" style="top:80px">
        <div class="list-header">
            <div class="list-summary"></div>
            <form>
                <div id="12333" class="left">
                    <%--<select id="userStatus" style="width:100px;height:30px">
                        <option value="0">代码位</option>
                        <option value="1">正常</option>
                        <option value="2">禁用</option>
                    </select>--%>
                    <input type="date" id="startTime">&nbsp;&nbsp;&nbsp;-<input type="date" id="endTime">
                    <input type="button" value="查询" onclick="selectUserList()">
                </div>
            </form>
        </div>
        <table ui="slim alt" class="veui-table">

            <colgroup>
                <col width="190">
                <col width="150">
                <col width="180">
                <col width="130">
                <col width="160">
                <col width="120">
                <col width="130">
                <col width="120">
                <col width="120">
            </colgroup>

            <thead>
            <tr>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">代码位</div>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">媒体</div>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">计费名</div>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">广告展现量</div>
                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                        </svg>
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                        </svg>
                    </svg>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">预计收入</div>
                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                        </svg>
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                        </svg>
                    </svg>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">点击量</div>
                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                        </svg>
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                        </svg>
                    </svg>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">eCPM</div>
                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                        </svg>
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                        </svg>
                    </svg>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">点击率</div>
                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                        </svg>
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                        </svg>
                    </svg>
                </th>
                <th scope="col" role="columnheader">
                    <div class="veui-table-cell">CPC</div>
                    <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 16 16" class="fa-icon veui-icon veui-sorter veui-sorter-unordered">
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M11.98 3.97l-.65.73L9 1.53V12H8V0h.99z"></path>
                        </svg>
                        <svg version="1.1" role="presentation" width="16" height="16" viewBox="0 0 12 12" class="fa-icon veui-icon" x="0" y="0">
                            <path d="M0 8.03l.65-.73 2.34 3.17V0h1v12h-1z"></path>
                        </svg>
                    </svg>
                </th>
            </tr>
            </thead>
            <tbody id="coll_list_begin_body">
            <tbody>
            <%--<tr class>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div class="adposition">
                            <div>dh300*250II</div>
                            <div>ID: u4768084</div>
                        </div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div class="app">
                            <div>zol.com.cn</div>
                        </div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div class="app">
                            <div>97025528_cpr</div>
                        </div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div>1234</div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div>1234</div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div>1234</div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div>1234</div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div>1234</div>
                    </div>
                </td>
                <td role="cell">
                    <div class="veui-table-cell">
                        <div>1234</div>
                    </div>
                </td>
            </tr>--%>

          <%--  <tr class>
                <td role="cell"><div class="veui-table-cell"><div class="adposition"><div>dh300*250II</div><div>ID: u4768084</div></div></div></td>
                <td role="cell"><div class="veui-table-cell"><div class="app"><div>zol.com.cn</div></div></div></td>
                <td role="cell"><div class="veui-table-cell"><div class="app"><div>97025528_cpr</div></div></div></td>
                <td role="cell"><div class="veui-table-cell"><div>1234</div></div></td>
                <td role="cell"><div class="veui-table-cell"><div>1234</div></div></td>
                <td role="cell"><div class="veui-table-cell"><div>1234</div></div></td>
                <td role="cell"><div class="veui-table-cell"><div>1234</div></div></td>
                <td role="cell"><div class="veui-table-cell"><div>1234</div></div></td>
                <td role="cell"><div class="veui-table-cell"><div>1234</div></div></td>
            </tr>--%>

            </tbody>

        </table>
    </div>
</div>
</body>

<script type="text/javascript">

    //进入页面直接请求数据
    $(document).ready(function(){
        selectUserList();
    });

    //点击搜索数据展示
    function selectUserList() {
        var startTime = $('#startTime').val();
        var endTime = $('#endTime').val();
        $.ajax({
            url: path + "/app/reportList",
            type: "post",
            data: {
                "startTime" : startTime,
                "endTime" : endTime
            },
            dataType: 'json',
            async: false,
            success: function (obj) {
            if(obj.code == 200){
                var list = obj.result;
                var html="";
                for (var i=0;i<list.length;i++){
                    var data = list[i];
                    html+='<tr class>';
                    html+='<td role="cell"><div class="veui-table-cell"><div class="adposition"><div>'+data.adSize+'</div><div>'+data.adId+'</div></div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div class="app"><div>'+data.address+'</div></div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div class="app"><div>'+data.adName+'</div></div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div>'+parseFloat(data.lookPv).toLocaleString()+'</div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div>'+data.income+'</div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div>'+parseFloat(data.clickNum).toLocaleString()+'</div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div>'+data.ecpm+'</div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div>'+data.clickProbability+'%</div></div></td>';
                    html+='<td role="cell"><div class="veui-table-cell"><div>'+data.cpc+'</div></div></td>';
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
</script>
</html>