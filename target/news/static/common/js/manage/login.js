/*$(document).ready(function(){
	var validator = new Validator();   
    validator.bindingEvent("logindiv");
    var lang = getCookie("lang") || "zh_CN";
    var scriptUrl = getContextPath() + "/static/js/validator/locale_" + lang + ".js";   		   
    loadScript([scriptUrl]);
    
    $("input[name='loginbtn']").die().live("click", function(){
    	submitLogin();
    }); 
    
    // 登录界面就一个按钮，所以绑到body 上，否则帮到password框上面.
    $("body").keydown(function(event){  
	  if(event.keyCode==13){  
		  submitLogin();
	  }  
    }); 
});*/

function submitLogin(){
	//先验证参数为空
	var loginName  = $("#loginName").val();
	var passWord = $("#passWord").val();
	var captcha = $("#captcha").val();

    if(loginName == ""){
        $("#span").html("<font color='red'>请输入账号</font>");
    }else if(passWord == ""){
        $("#span").html("<font color='red'>请输入密码</font>");
    }else if(captcha == ""){
        $("#span").html("<font color='red'>请输入验证码</font>");
    }else{
        login();
	}

}

function refreshCode(){
	$("#captchaImg").attr("src",getContextPath() + "/validateCode?"+Math.random());
}

function login(){
	$("#SaveSubmit").attr("disabled",true);
	var user = {};
    user.loginName  = $("#loginName").val();
    user.passWord = $("#passWord").val();
    user.captcha = $("#captcha").val();
    url = getContextPath() + "/userLogin";
    var request = {url:url, data:user,type:"POST",async:true,dataType:"json"};

    return ajaxCall( request ).done(function(data){
    	if (data.code == "200" ){
    		window.location = getContextPath() + data.result;
    	}else{
    		$("#email").siblings("[validationError]").remove();	
    		$("#span").html("<font color='red'>"+data.message+"</font>");
    	}
    	
    }).fail(function(){
    	
    });
}