<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<div id="">
    <div class="row">
        <div class=" col-xs-12 widget-container-col"
             id="widget-container-col-12">
            <div class="widget-box transparent" id="widget-box-12">
                <div class="widget-header">
                    <h4 class="widget-title lighter">查询</h4>
                    <div class="widget-toolbar no-border">
                        <a href="#" data-action="collapse"> <i
                                class="ace-icon fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>
                <div class="widget-body">
                    <div class="widget-main padding-6 no-padding-left no-padding-right">
                        <form class="form-horizontal" id="oveBeginForm">
                            <div class="form-group"></div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="col-sm-1 control-label no-padding-right"> 手机号 </label>
                                    <div class="col-sm-2">
                                    <textarea class="form-control" id="coll_list_begin_tels" name="tels"
                                              placeholder="键入查询的手机号,以回车分隔"></textarea>
                                    </div>

                                    <label class="col-sm-1 control-label no-padding-right">逾期天数 </label>
                                    <div class="col-sm-2">
                                        <div class="input-daterange input-group">
                                            <input type="text" class="input-sm form-control" name="oveDays1" onkeyup="value=value.replace(/[^\d$]/,'')"
                                                   id="oveDays1">
                                            <span class="input-group-addon">
																		<i class="fa fa-exchange"></i>
																	</span>

                                            <input type="text" class="input-sm form-control" name="oveDays2" onkeyup="value=value.replace(/[^\d$]/,'')"
                                                   id="oveDays2">
                                        </div>
                                    </div>

                                    <label class="col-sm-1 control-label">
                                        应还时间 </label>
                                    <div class="col-sm-2">
                                        <div class="input-group">
                                            <input id="mastTime1" type="text" placeholder="请选择开始日期"
                                                   class="col-xs-10 col-sm-12 dtx_ymdPicker"
                                                   name="mastTime1"/> <span class="input-group-addon">
											<i class="fa fa-clock-o bigger-110"></i>
										</span>
                                        </div>

                                    </div>
                                    <label class="col-sm-1 control-label no-padding-right"> 至 </label>
                                    <div class="col-sm-2">
                                        <div class="input-group">
                                            <input id="mastTime2" type="text" placeholder="请选择截止日期"
                                                   class="col-xs-10 col-sm-12 dtx_ymdPicker" name="mastTime2"/>
                                            <span class="input-group-addon"> <i
                                                    class="fa fa-clock-o bigger-110"></i>
										</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-2" style="float: right;">
                                        <button class="btn btn-primary " type="button" style="float: right;"
                                                onclick="selectWaitList(1,10)">
                                            <i class="ace-icon glyphicon glyphicon-search align-top bigger-125"></i>
                                            查询
                                        </button>
                                    </div>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <h3 class="header smaller lighter blue">逾期信息</h3>
            <div class="clearfix">
                <div class="pull-right tableTools-container"></div>
            </div>
            <div class="table-header"></div>
            <div>
                <p>
                    <!-- 	<button class="btn">Default </button>
                    <button class="btn btn-pink">Pink</button>
                    <button class="btn btn-info">Info</button> -->

                    <!-- <button class="btn btn-success">新增</button> -->

                     <button class="btn btn-success" onclick="coll_begin_batchAllotBill()">分单</button>
                     <button class="btn btn-success" onclick="coll_begin_exportExcel()">导出</button>

                    <!-- <button class="btn btn-primary">编辑 </button> -->


                </p>

            </div>
            <div>
                <table id="dynamic-table"
                       class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th class="center"><label class="pos-rel"> <input
                                type="checkbox" class="ace choose" value="0"
                                onclick="allChecked(this)"/> <span class="lbl"
                                                                   onclick="chooseAll()"> </span>
                        </label></th>
                        <th>订单编号</th>
                        <th>借款人</th>
                        <th>手机号</th>
                        <th>订单状态</th>
                        <th>逾期天数</th>
                        <th>借款金额</th>
                        <th>逾期费用</th>
                        <th>应还金额</th>
                        <th>借款时间</th>
                        <th>应还时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="coll_list_begin_body"></tbody>
                </table>
            </div>
            <div class="modal-footer no-margin-top">
                <ul class="pagination pull-right no-margin" id="coll_begin_page"></ul>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="coll_begin_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >分单</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="userQuota_modal_form">
                    <input type="hidden" id="collection_id" name="collection_id" value="">

                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right " >
                                催收小组: </label>
                            <div class="col-sm-8">
                                <select class="form-control" id="coll_begin_selectGroup">
                                    <%--<option value="111">开发A组</option>--%>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="beforeAllotToGroup();">确认分配
                </button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var oveBillIds = [];
    $(function () {
        //选择日期效果
        if (!ace.vars['old_ie'])
            $('.dtx_ymdPicker').datetimepicker({
                format: 'YYYY-MM-DD',//use this option to display seconds
                icons: {
                    time: 'fa fa-clock-o',
                    date: 'fa fa-calendar',
                    up: 'fa fa-chevron-up',
                    down: 'fa fa-chevron-down',
                    previous: 'fa fa-chevron-left',
                    next: 'fa fa-chevron-right',
                    today: 'fa fa-arrows ',
                    clear: 'fa fa-trash',
                    close: 'fa fa-times'
                }
            }).next().on(ace.click_event, function () {
                $(this).prev().focus();
            });
//        $('.form_datetime').datetimepicker({
//            language: 'zh-CN',
//            weekStart: 1,
//            todayBtn: 1,
//            autoclose: 1,
//            todayHighlight: 1,
//            startView: 2,
//            forceParse: 0,
//            showMeridian: 1
//        });

        //查询
//        firstDateInit('mastTime1');
//        secondDateInit('mastTime2');
        selectWaitList(1, 10)
    });

    //全选
    function chooseAll() {
        if ($(".choose").val() == 1) {
            $("input[name='skill']").prop("checked", false);
            $(".choose").val("0")
        } else if ($(".choose").val() == 0) {
            $("input[name='skill']").prop("checked", true);
            $(".choose").val("1")
        }
    }
    // 批量分单显示弹框
    function coll_begin_batchAllotBill(){
        coll_begin_usableOrg();
        // 清空上次所选择的单据
        oveBillIds = [];
        var num = $("#coll_list_begin_body").find("input:checked").length;
        if(num < 1){
            $.alertModel("请至少选择一条数据进行操作！");
            return false;
        }else{
            var ids = $("#coll_list_begin_body").find("input:checked");
            $("#coll_list_begin_body").find("input:checked").each(function (index,obj ){
                oveBillIds[index] = $(obj).val();
            });
            $("#coll_begin_modal").modal('show');
        }
    }
    // 单条分单弹框
    function coll_begin_onlyAllotBill(billId){
        coll_begin_usableOrg();
        oveBillIds = [];
        oveBillIds = [billId];
        $("#coll_begin_modal").modal('show');
    }

    // 查询当前可用的分组
    function coll_begin_usableOrg(){
        var html = "";
        $.ajax({
            url: path + "/coll/getUsableOrg",
            type: "post",
            data: {},
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.flag == "success"){
                    var data = obj.data;
                    for(var i=0;null != data && data.length > 0 && i< data.length ;i++){
                        html += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
                    }
                }else{
                    html += '<option value="">未查询到可用的分组!</option>';
                }
            },
            error: function () {
                html += '<option value="">未查询到可用的分组!</option>';
//                $.alertModel("请求失败!");
            }
        });
        $("#coll_begin_selectGroup").html(html);
    }
    // 分组前提示
    function beforeAllotToGroup(){
        var groupId = $("#coll_begin_selectGroup").val();
        if (groupId == null || groupId == undefined || groupId == ''){
            $.alertModel("分单失败,没有可用的分组");
            return false;
        }
        $.ajax({
            url: path + "/coll/beforeAllotToGroup",
            type: "post",
            data: {orgId:groupId},
            dataType: 'json',
            async: false,
            success: function (obj) {
                $.confirmModel("当前组未处理单据数量为:"+obj+"条!是否确认分配",function(){coll_begin_bill_allot();});
            },
            error: function () {
                $.alertModel("请求失败!");
            }
        });
    }
    // 分单确认按钮操作
    function coll_begin_bill_allot(){
        var groupId = $("#coll_begin_selectGroup").val();
        if (groupId == null || groupId == undefined || groupId == ''){
            $.alertModel("分单失败,没有可用的分组");
            return false;
        }
        var params = {
            oveBillIds : JSON.stringify(oveBillIds),
            groupId : groupId
        }
        $.ajax({
            url: path + "/coll/billAllotToGroup",
            type: "post",
            data: params,
            dataType: 'json',
            async: false,
            success: function (obj) {
                $.alertModel(obj.flagMsg);
            },
            error: function () {
                $.alertModel("请求失败!");
            }
        });
        // 刷新本页面
        gotoURL(path+'/coll/collBegin');
    }


    //展示
    function selectWaitList(pageNo, pageSize) {
        var dataSource = "";
        dataSource += $("#oveBeginForm").serialize();
        dataSource += "&pageNo=" + pageNo;
        dataSource += "&pageSize=" + pageSize;
        $.ajax({
            url: path + "/coll/selectWaitList",
            type: "post",
            data: dataSource,
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.flag == "success"){
                    $("#coll_begin_page").pagination(obj.page,selectWaitList);
                    var html="";
//                    html+='<input type ="hidden" id ="begin_pageNo" value ='+pageNo+'>';
//                    html+='<input type ="hidden" id ="begin_pageSize" value ='+pageSize+'>';
                    for (var i=0;i<obj.oveBillList.length;i++){
                        var data = obj.oveBillList[i];
                        html+='<tr>';
                        html+=' <td class="center">';
                        html+='	<label class="pos-rel"> ';
                        html+='		<input type="checkbox" class="ace" data-val="'+data.userid+'" id="skill'+data.id+'" name="skill" value="'+data.id+'"/>';
                        html+='		<span class="lbl" onclick="onChecked(this)" ></span>';
                        html+='	</label>';
                        html+='</td>';
                        html+='<td> '+data.ordernum+'</td>';
                        html+='<td> '+data.userName+'</td>';
                        html+='<td> '+data.tel+'</td>';
                        html+='<td> '+data.billState+'</td>';
                        html+='<td> '+data.oveDays+'</td>';
                        html+='<td> '+data.sum+'</td>';
                        html+='<td> '+data.oveCost+'</td>';
                        html+='<td> '+data.mastSum+'</td>';
                        html+='<td> '+data.startTime+'</td>';
                        html+='<td> '+data.mastTime+'</td>';
                        html+='<td> ';
                        html+='<button onclick="coll_begin_onlyAllotBill('+data.id+')" class="btn btn-xs btn-warning"><i class="ace-icon fa fa-flag bigger-120"></i></button>';
                        html+='<button type="button" onclick="coll_begin_report('+data.userid+')" style="margin-left:3px"  class="btn btn-white btn-purple btn-sm">报告</button>';
                        html+='</td> ';
                        html+='</tr>';
                    }
                    $("#coll_list_begin_body").html(html);

                }else{
                    $("#coll_list_begin_body").html('');
                }

            },
            error: function () {
                $.alertModel("请求失败!");
            }
        });
    }
    // 导出
    function coll_begin_exportExcel(){
        $.ajax({
            url: path + "/coll/collBeginExportExcel",
            type: "post",
            data: $("#oveBeginForm").serialize(),
            dataType: 'json',
            async: false,
            success: function (obj) {
                if(obj.flag=='1'){
                    window.location.href=path+obj.fileUrl;
                }else{
                    $.alertModel(obj.msg);
                }
            },
            error: function () {
                $.alertModel("网络超时!获取失败!");
            }

        });
    }

    function coll_begin_report(userid){
        gotoURL(path + '/report/reportShow?userid=' + userid);	// 查看报告
    }

</script>
</html>
