
/**
 * jquery 依赖 bootstrap 插件扩展
 * pagination: page 为一个json数据 func 为回调函数 同时会回传两个参数 curPage,pageCount
 */
var main={};
$.fn.extend({
    //分页扩展
    pagination: function (page, func) {
        var func = func ? func : toPage;

        this.empty();
        var pageCount = (page.pageSize > 0) ? page.pageSize : 20;
        page.totalPage =  Math.ceil(page.totalCount / pageCount);
        this.addClass("pagination pagination-sm navbar-right")

        this.append($("<li ><a href='javascript:void(0)'  title='首页'><<</a></li>").click(function () {
            func(1, pageCount);
        }));
        this.append($("<li ><a href='javascript:void(0)'  title='上一页'><</a></li>").click(function () {
            func(page.pageNo <= 1 ? 1 : (page.pageNo - 1), pageCount);
        }));
        if (page.totalPage <= 6) {
            for (var i = 1; i <= page.totalPage; i++) {
                this.append($("<li " + ((i == page.pageNo) ? "class='active'" : '') + " ><a href='javascript:void(0)' >" + i + "</a></li>").click(i, function (e) {
                    func(e.data, pageCount);
                }));
            }
        }

        if (page.totalPage > 6) {
            for (var i = 1; i <= page.totalPage; i++) {
                if (i <= 2) {
                    this.append($("<li " + ((i == page.pageNo) ? "class='active'" : '') + " ><a href='javascript:void(0)' >" + i + "</a></li>").click(i, function (e) {
                        func(e.data, pageCount);
                    }));
                }
                if (i > 2 && i <= page.totalPage - 2) {
                    this.append($("<li ><a href='javascript:void(0)' >...</a></li>").click(function (e) {
                        func(page.pageNo - 1, pageCount);
                    }));
                    if (page.pageNo > 2 && page.pageNo <= page.totalPage - 2) {
                        this.append($("<li class='active' ><a href='javascript:void(0)' >" + page.pageNo + "</a></li>").click(function () {
                            func(page.pageNo, pageCount);
                        }));
                    }
                    this.append($("<li ><a href='javascript:void(0)'  >...</a></li>").click(i, function (e) {
                        func(page.pageNo + 1, pageCount);
                    }));
                    i = page.totalPage - 2;
                }

                if (i > 3 && i > page.totalPage - 2) {
                    this.append($("<li  " + ((i == page.pageNo) ? "class='active'" : '') + "><a href='javascript:void(0)' >" + i + "</a></li>").click(i, function (e) {
                        func(e.data, pageCount);
                    }));
                }
            }
        }
        this.append($("<li ><a href='javascript:void(0)' title='下一页'>></a></li>").click(function () {
            func((page.pageNo == page.totalPage) ? page.pageNo : (page.pageNo + 1), pageCount);
        }));
        this.append($("<li ><a href='javascript:void(0)'  title='尾页'>>></a></li>").click(function () {
            func(page.totalPage, pageCount);
        }));

        //{"filterRecord":0,"pageCount":15,"curPage":1,"totalRecord":27,"maxPage":2}

        var div = $("<div class='input-group input-group-sm' ></div>");

        $("<span class='input-group-addon' style='background:#fff;color:#337ab7;border-left:none'>每页</span>")
            .appendTo(div)

        $("<select class='' style='width: 70px'><option>10</option><option>15</option><option>20</option><option>50</option><option>100</option></select>")
            .appendTo(div)
            .val(page.pageSize)
            .change(function () {
                pageCount = $(this).val();
                func(1, pageCount);
            })

        $("<span class='input-group-addon' style='background:#fff;color:#337ab7;'>条</span>")
            .appendTo(div)

        this.append($("<li class='form-inline'></li>").append(div));

        this.append("<li ><span >共" + page.totalCount + "条</span></li>");

        var div2 = $("<div class='input-group input-group-sm' style='width:90px;'  ></div>");
        $("<input type='text' class='form-control' >").appendTo(div2);
        $("<span class='input-group-addon' style='color:#337ab7;cursor: pointer;'>GO</span>")
            .appendTo(div2)
            .click(function () {
                var index = $(this).siblings("input").val();
                if (index && parseInt(index) > 0 && parseInt(index) <= page.totalPage) {
                    func(parseInt(index), pageCount);
                } else {
//						openAlert("页码超出范围!","警告:",1000);
                	$.alertModel('页码超出范围!');
                }
            });

        this.append($("<li class='form-inline'></li>").append(div2));
    },
    div2Module: function (title) {
        var thiz = this;
        var context = thiz.children();
        var id = "mod" + (new Date().getTime());
        title = title ? title : "";
        var mcontent = $("<div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button><h4 class='modal-title'>" + title + "</h4></div></div>");
        mcontent.append(context);
        var mlog = $("<div class='modal-dialog'></div>");
        mlog.append(mcontent);
        var modal = $("<div class='modal fade' id='" + id + "' tabindex='-1' role='dialog'  aria-labelledby='myModalLabel' aria-hidden='true'></div>")
            .append(mlog);
        modal.appendTo($("body")).modal({show: true}).on("hidden.bs.modal", function () {
            thiz.append(context);
            $(this).removeData("bs.modal");
            modal.remove();
            modal = null;
        });
        var close = thiz.close = function () {
            modal.modal("hide");
        }
        thiz.data("dm", close);
        return thiz;
    },
    modClose: function () {
        this.data("dm")();
    }, orderColumn: function (id, fun) {
        $(id).find("th[class='table-df']").click(function () {
            $(this).siblings().removeClass("tableHead_desc").removeClass("tableHead_asc");
            if ($(this).hasClass("tableHead_asc")) {
                $(this).addClass("tableHead_desc").removeClass("tableHead_asc");
            } else {
                $(this).addClass("tableHead_asc").removeClass("tableHead_desc");
            }
            var pageSize = $(this).parents("div[id$='_content']").find(".form-control").find("option:selected").text();
            fun(1, pageSize);
        });


    }
   
});

$.alertModel=function(msg){
	//var id = "mod" + (new Date().getTime());
	var alertHtml="";
	alertHtml+='<div class="modal"   tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">';
	alertHtml+='  <div class="modal-dialog" style="width: 25%">';
	alertHtml+='	 <div class=" widget-container-col ui-sortable" id="widget-container-col-6">';
	alertHtml+='		<div class="widget-box light-border ui-sortable-handle" id="widget-box-6">';
	alertHtml+='			<div class="widget-header">';
	alertHtml+='				<h5 class="widget-title smaller">提示</h5>';
	alertHtml+='				<div class="widget-toolbar">';
	alertHtml+='					<a href="#" data-action="close" data-dismiss="modal" aria-label="Close">';
	alertHtml+='						<i class="ace-icon fa fa-times" aria-hidden="true"></i>';
	alertHtml+='					</a>';
	alertHtml+='				</div>';
	alertHtml+='			</div>';
	alertHtml+='			<div class="widget-body">';
	alertHtml+='				<div class="widget-main padding-6">';
	alertHtml+='					<div class="alert alert-info"> '+dateFormate(msg)+' </div>';
	alertHtml+='				</div>';
	alertHtml+='			</div>';
	alertHtml+='		</div>';
	alertHtml+='	</div>';
	alertHtml+=' </div>';
	alertHtml+='</div>';
	
	var modal=$(alertHtml);
	 modal.appendTo($("body")).modal({show: true}).on("hidden.bs.modal", function () {
        // thiz.append(context);
         $(this).removeData("bs.modal");
         modal.remove();
         modal = null;
     });
} 

$.confirmModel=function(msg,fun){
	//var id = "mod" + (new Date().getTime());
	var alertHtml="";
	alertHtml+='<div class="modal"   tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">';
	alertHtml+='  <div class="modal-dialog" style="width: 25%">';
	alertHtml+='	 <div class=" widget-container-col ui-sortable" id="widget-container-col-6">';
	alertHtml+='		<div class="widget-box light-border ui-sortable-handle" id="widget-box-6">';
	alertHtml+='			<div class="widget-header">';
	alertHtml+='				<h5 class="widget-title smaller">提示</h5>';
//	alertHtml+='				<div class="widget-toolbar">';
//	alertHtml+='					<a href="#" data-action="close" data-dismiss="modal" aria-label="Close">';
//	alertHtml+='						<i class="ace-icon fa fa-times" aria-hidden="true"></i>';
//	alertHtml+='					</a>';
//	alertHtml+='				</div>';
	alertHtml+='			</div>';
	alertHtml+='			<div class="widget-body">';
	alertHtml+='				<div class="widget-main padding-6">';
	alertHtml+='					<div class="alert alert-info"> '+dateFormate(msg)+' </div>';
	alertHtml+='				</div>';
	alertHtml+='			</div>';
	alertHtml+='			<div class="widget-toolbox padding-8 clearfix">';
	alertHtml+='				<button class="btn btn-xs btn-danger pull-left" data-dismiss="modal" aria-label="Close">';
	alertHtml+='					<i class="ace-icon fa fa-times" aria-hidden="true"></i>';
	alertHtml+='					<span class="bigger-110">取消</span>';
	alertHtml+='				</button>';
	alertHtml+='				<button class="btn btn-xs btn-success pull-right">';
	alertHtml+='					<i class="ace-icon fa fa-check icon-on-right"></i>';
	alertHtml+='					<span class="bigger-110">确认</span>';
	alertHtml+='				</button>';
	alertHtml+='			</div>';
	alertHtml+='		</div>';
	alertHtml+='	</div>';
	alertHtml+=' </div>';
	alertHtml+='</div>';
	
	var modal=$(alertHtml);
	 modal.appendTo($("body")).modal({show: true}).on("hidden.bs.modal", function () {
         $(this).removeData("bs.modal");
         modal.remove();
         modal = null;
     });
	 $(modal).find(".widget-toolbox").find(".btn-success").on("click",function(){
		 $(modal).modal("hide");
		 fun();
	 })
} 

function dateFormate(obj) {
    return obj == undefined || obj == null ? '&nbsp;' : obj;
}
function dateFormateVal(obj,val) {
    return obj == undefined || obj == null ? val : obj;
}	

//选项全选与全不选
function allChecked(e){
	if($(e).parents("table").find("thead").find("input[type='checkbox']").is(":checked")){
		$(e).parents("table").find("tbody").find("input[type='checkbox']").prop("checked",true);
	}else {
		$(e).parents("table").find("tbody").find("input[type='checkbox']").prop("checked",false);
	}
}
 function onChecked(e){
	var i=0;
	if($(e).prev().is(":checked")){
		i=-1;
	}else{
		i=1;
	}
 	var ckNum = $(e).parents("table").find("tbody").find("input[type='checkbox']:checked").length+i;
 	var allNum = $(e).parents("table").find("tbody").find("input[type='checkbox']").length;
 	if(ckNum == allNum){
 		$(e).parents("table").find("thead").find("input[type='checkbox']").prop("checked",true);
 	}else{
 		$(e).parents("table").find("thead").find("input[type='checkbox']").prop("checked",false);
 	}
 }

 //时间格式转换器格式  秒数 转换为正常时间格式
 function dateFtt(fmt,date)   
	{ //author: meizz   
	  var o = {   
	    "M+" : date.getMonth()+1,                 //月份   
	    "d+" : date.getDate(),                    //日   
	    "h+" : date.getHours(),                   //小时   
	    "m+" : date.getMinutes(),                 //分   
	    "s+" : date.getSeconds(),                 //秒   
	    "q+" : Math.floor((date.getMonth()+3)/3), //季度   
	    "S"  : date.getMilliseconds()             //毫秒   
	  };   
	  if(/(y+)/.test(fmt))   
	    fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));   
	  for(var k in o)   
	    if(new RegExp("("+ k +")").test(fmt))   
	  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
	  return fmt;   
	} 

	function crtTimeFtt(value){
	    var crtTime = new Date(value);
	    return top.dateFtt("yyyy-MM-dd hh:mm:ss",crtTime);//直接调用公共JS里面的时间类处理的办法     
	}
	$(function(){
		tModel=function(msg){
			//var id = "mod" + (new Date().getTime());
			var alertHtml="";
			alertHtml+='<div class="modal">';
			alertHtml+='  <div class="modal-dialog" style="width:30%">';
			alertHtml+='	 <div class=" widget-container-col ui-sortable" id="widget-container-col-6">';
			alertHtml+='		<div class="widget-box light-border ui-sortable-handle" id="widget-box-6">';
			alertHtml+='			<div class="widget-header">';
			alertHtml+='				<h5 class="widget-title smaller">'+msg.title+'</h5>';
			alertHtml+='				<div class="widget-toolbar">';
			alertHtml+='					<a href="#" data-action="close" data-dismiss="modal" aria-label="Close">';
			alertHtml+='						<i class="ace-icon fa fa-times" aria-hidden="true"></i>';
			alertHtml+='					</a>';
			alertHtml+='				</div>';
			alertHtml+='			</div>';
			alertHtml+='			<div class="widget-body">';
			alertHtml+='				<div class="widget-main padding-6">';
			alertHtml+='					<div class="alert-info"> ';
			alertHtml+='						<form class="form-horizontal" role="form"  id="addmodelform">';
			alertHtml+='							<div class="">';
			alertHtml+='								<label class=" control-label no-padding-right" for="form-field-1">'+msg.label+'</label>';
			alertHtml+='								<input type="text" id="beizhu" placeholder="" value="01" name="customerNameadmodel">';
			alertHtml+='								<span class="error"></span>';
			alertHtml+='							</div>';
			alertHtml+='						</form>';
			alertHtml+='					</div>';
			alertHtml+=' 					<footer class="fd">';
			alertHtml+='						<a href="#" id="yes_btn" data-action="close" data-dismiss="modal" aria-label="Close">'+ msg.yesText+'</a>';
			alertHtml+='						<a href="#" id="no_btn" class=" alert-btn alert-btn-st" >' + msg.noText + '</a>' ;
			alertHtml+='					</footer>';
			alertHtml+='				</div>';
			alertHtml+='			</div>';
			alertHtml+='		</div>';
			alertHtml+='	</div>';
			alertHtml+=' </div>';
			alertHtml+='</div>';
			var modal=$(alertHtml);
			 var reason = $("#beizhu").val();
			 modal.appendTo($("body")).modal({show: true}).on("hidden.bs.modal", function () {
				 ExamineAjax(msg.id,reason);
		     });
		     $("#no_btn").click(function(){
		    	  $(this).removeData("bs.modal");
		         modal.remove();
		         modal = null;
		         $(".modal-backdrop").hide();
			 });
		
		} 
	})
	
	function dtx_retreat(){
		var tagId="dtx_index_tag_";
		var thisObj=$("#myTab").find("li.active");
		var thisObjId=$(thisObj).attr("id");
		var menuId=thisObjId.substring(tagId.length,thisObjId.length);
		var thisUrl=$("#"+menuId).attr("url");
		gotoURL(thisUrl);
	}
var numStr= new RegExp("^[0-9]*$");
//多订单号字符串拼接
function multiOrderOrPhone(str) {
    var strArr = '';
    if (numStr.test(str.replace(/\s+/g,""))) {
        strArr = str.trim().replace(/\s+/g,",").split(",");
        return '(' +strArr.join(",") + ')';
	}
	return strArr;
}
//格式化日期     by wangzs
//例子   new Date().Format("yyyy-MM-dd hh:mm:ss"); ------- 2018-09-02 10:01:23
Date.prototype.Format = function(format){
    var o = {
        "M+" : this.getMonth()+1, //month
        "d+" : this.getDate(), //day
        "h+" : this.getHours(), //hour
        "m+" : this.getMinutes(), //minute
        "s+" : this.getSeconds(), //second
        "q+" : Math.floor((this.getMonth()+3)/3), //quarter
        "S" : this.getMilliseconds() //millisecond
    }
    if(/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    for(var k in o) {
        if(new RegExp("("+ k +")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
        }
    }
    return format;
}
//初始化开始时间     id : 标签的id值
function firstDateInit(id){
    var currentTime = new Date().Format("yyyy-MM-dd 00:00:00");
	$("#"+id).val(currentTime);
}

//初始化结束时间     id ：标签的id值
function secondDateInit(id){
    var currentTime = new Date().Format("yyyy-MM-dd 23:59:59");
	$("#"+id).val(currentTime);
}

function thisDateInit_day(id,day){
	var date = new Date();//获取当前时间
	date.setDate(date.getDate()-day);//设置天数 -n 天
    var currentTime = date.Format("yyyy-MM-dd");
	$("#"+id).val(currentTime);
}
function thisDateInit(id){
    var currentTime = new Date().Format("yyyy-MM-dd");
	$("#"+id).val(currentTime);
}

$.validator.addMethod("isPhone", function(value,element) {//手机、固话自定义验证   
	 var length = value.length;   
	 var mobile = /^((1[3-8][0-9])+\d{8})$/;   
	 var tel = /^\d{3,4}-?\d{7,9}$/;   
	 return this.optional(element) || (tel.test(value)) || (length==11 && mobile.test(value));   
}, "*请填写正确的联系电话");  

$.validator.addMethod("stringCheck", function(value, element) {//用户名自定义验证
	var name = /^[\u0391-\uFFE5\w]+$/;
	return this.optional(element) || name.test(value);       
}, "*只能包括中文字、英文字母、数字和下划线");  

// 中文字两个字节       
$.validator.addMethod("byteRangeLength", function(value, element, param) {       
	var length = value.length;       
	for(var i = 0; i < value.length; i++){       
		if(value.charCodeAt(i) > 127){       
			length++;       
	    }       
	}       
   return this.optional(element) || ( length >= param[0] && length <= param[1] );       
}, "*请确保输入的值在3-15个字节之间(一个中文字算2个字节)");   



$.validator.addMethod("checkEmail",function(value,element,params){//邮箱自定义验证
   var checkEmail = /^[a-z0-9]+@([a-z0-9]+\.)+[a-z]{2,4}$/i;  
   return this.optional(element)||(checkEmail.test(value));  
},"*请输入正确的邮箱！"); 

$.validator.addMethod("checkName",function(value,element,params){//登陆账号自定义验证  
   var checkName = /^\w{6,12}$/g;  
   return this.optional(element)||(checkName.test(value));  
},"*只允许6-12位英文字母、数字或者下划线！");

$.validator.addMethod("checkPwd",function(value,element,params){//登陆密码自定义验证  
   var checkPwd = /^\w{6,16}$/g;  
   return this.optional(element)||(checkPwd.test(value));  
},"*只允许6-16位英文字母、数字或者下划线！");