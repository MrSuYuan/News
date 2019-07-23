$(document).ready(function(){
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
});

function submitLogin(){

	//先验证参数为空
	var email  = $("#email").val();
	var password = $("#password").val();
	var captcha = $("#captcha").val();

    if(email == ""){
        $("#span").html("<font color='red'>请输入账号</font>");
    }else if(password == ""){
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
    user.email  = $("#email").val();
    user.password = $("#password").val();
    user.captcha = $("#captcha").val();
    url = getContextPath() + "/login";
    var request = {url:url, data:user,type:"POST",async:true,dataType:"json"};


    
    return ajaxCall( request ).done(function(data){
    	if (data.errorCode == "200" ){
    		window.location = getContextPath() + data.item.firstUrl;
    	}else if (data.errorCode == "1000" ){
    		$("#email").siblings("[validationError]").remove();	
    		$("#span").html("<font color='red'>用户不存在</font>");
    	}else if (data.errorCode == "1100" || data.errorCode == '10020'){
    		$("#password").siblings("[validationError]").remove();
            $("#span").html("<font color='red'>密码错误</font>");
    	}else if (data.errorCode == "10105"){
    		$("#password").siblings("[validationError]").remove();
            $("#span").html("<font color='red'>账户被锁定</font>");
    	}else if (data.errorCode == "1007"){
    		$("#captcha").siblings("[validationError]").remove();
            $("#span").html("<font color='red'>验证码错误</font>");
    	} else {
    		alert("登录错误，错误代码为："+ data.errorCode);
    	}
    	
    }).fail(function(){
    	
    });
}