package com.news.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("")
@Api(value = "/page", tags = "跳转路径接口")
public class PageController {

    private final Logger logger = LoggerFactory.getLogger(PageController.class);

    /*@Autowired
    UserService userService;

    *//**
     * 跳转到登录页
     *//*
    @RequestMapping(value = "/login",method=RequestMethod.GET)
    public ModelAndView loginPage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/index/login");
        return mv;
    }

    *//**
     * PC端
     * 动态生成验证码
     * @param request
     * @param response
     * @throws Exception
     *//*
    @RequestMapping(value="image")
    public void image(HttpServletRequest request,HttpServletResponse response)throws Exception{
        response.setHeader("Pragma", "No-cache");//No-cache不走缓存
        response.setHeader("Cache-Control", "No-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");
        //生成随机字符串  4位
        String verifyCode=ImageUtil.generateVerifyCode(4);
        //存入会话session
        HttpSession session=request.getSession(true);
        session.setAttribute("verify", verifyCode.toLowerCase());
        //生成图片
        int w=150,h=60;
        ImageUtil.outputImage(w, h, response.getOutputStream(), verifyCode);
    }

    *//**
     * 退出登录
     *//*
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        ModelAndView mv = new ModelAndView("redirect:/login");
        return mv;
    }

    *//**
     * 模板主页
     *//*
    @RequestMapping(value = "index" , method= RequestMethod.GET)
    @ApiOperation(value = "模板主页面", notes = "模板主页面", httpMethod = "GET")
    public String index(){
        return "index";
    }

    *//**
     * 模板实例
     *//*
    @RequestMapping(value = "exampleList" , method= RequestMethod.GET)
    @ApiOperation(value = "模板实例页面", notes = "模板实例页面", httpMethod = "GET")
    public String exampleList(){
        return "example/exampleList";
    }

    *//**
     * 新增用户
     *//*
    @RequestMapping(value = "createUser" , method= RequestMethod.GET)
    @ApiOperation(value = "新增用户页面", notes = "新增用户页面", httpMethod = "GET")
    public String createUser(){ return "example/createUser";}

    *//**
     * 用户审核列表
     *//*
    @RequestMapping(value = "userAuditList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户审核列表页面", notes = "用户审核列表页面", httpMethod = "GET")
    public String userAuditList(){ return "example/userAuditList";}

    *//**
     * 用户管理列表
     *//*
    @RequestMapping(value = "userManagementList" , method= RequestMethod.GET)
    @ApiOperation(value = "用户管理列表页面", notes = "用户管理列表页面", httpMethod = "GET")
    public String userManagementList(){ return "example/userManagementList";}

    *//**
     * 用户审核详情
     *//*
    @RequestMapping(value = "userAudit" , method= RequestMethod.GET)
    @ApiOperation(value = "用户审核详情", notes = "用户审核详情", httpMethod = "GET")
    public String userAudit(){ return "example/userAudit";}

    *//**
     * 用户管理详情
     *//*
    @RequestMapping(value = "userManagement" , method= RequestMethod.GET)
    @ApiOperation(value = "用户管理详情", notes = "用户管理详情", httpMethod = "GET")
    public String userManagement(){ return "example/userManagement";}

    *//**
     * 跳转到图片上传页面
     *//*
    @RequestMapping(value = "upload" , method= RequestMethod.GET)
    @ApiOperation(value = "跳转到图片上传页面", notes = "跳转到图片上传页面", httpMethod = "GET")
    public String upload(){ return "example/uploadPicture";}

    *//**
     * 应用审核列表页
     *//*
    @RequestMapping(value = "reviewNormalList" , method= RequestMethod.GET)
    @ApiOperation(value = "应用审核列表页面", notes = "应用审核列表页面", httpMethod = "GET")
    public String reviewNormalList(){ return "example/reviewNormalList";}

    *//**
     * 应用审核详情页
     *//*
    @RequestMapping(value = "reviewNormalDetails" , method= RequestMethod.GET)
    @ApiOperation(value = "应用审核详情页面", notes = "应用审核详情页面", httpMethod = "GET")
    public String reviewNormalDetails(){ return "example/reviewNormalDetails";}

    *//**
     * 应用审核历史页
     *//*
    @RequestMapping(value = "reviewNormalHistory" , method= RequestMethod.GET)
    @ApiOperation(value = "应用审核历史页", notes = "应用审核历史页", httpMethod = "GET")
    public String reviewNormalHistory(){ return "example/reviewNormalHistory";}

    *//**
     * 异常审核列表
     *//*
    @RequestMapping(value = "reviewErrorList" , method= RequestMethod.GET)
    @ApiOperation(value = "异常审核列表页面", notes = "异常审核列表页面", httpMethod = "GET")
    public String reviewErrorList(){ return "example/reviewErrorList";}

    *//**
     * 异常审核详情页
     *//*
    @RequestMapping(value = "reviewErrorDetails" , method= RequestMethod.GET)
    @ApiOperation(value = "异常审核详情页面", notes = "异常审核详情页面", httpMethod = "GET")
    public String reviewErrorDetails(){ return "example/reviewErrorDetails";}

    *//**
     * 修改密码
     *//*
    @RequestMapping(value = "updatePassWord" , method= RequestMethod.GET)
    @ApiOperation(value = "修改密码页面", notes = "修改密码页面", httpMethod = "GET")
    public String updatePassWord(){
        return "example/updatePass";
    }*/


}
