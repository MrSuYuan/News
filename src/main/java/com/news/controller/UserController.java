package com.news.controller;

import com.news.service.UserService;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("user")
@Api(value = "/user", tags = "用户模块")
public class UserController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    UserService userService;

    @RequestMapping(value = "/updatePassWord",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改密码", notes = "修改密码", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="oldPassWord" , value="原密码" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="passWord" , value="新密码" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="confirmPassWord" , value="确认密码" ,required = true , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse updatePassWord(String oldPassWord, String passWord, String confirmPassWord) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = userService.updatePassWord((Long)userId, oldPassWord, passWord, confirmPassWord);
        }
        return req;
    }

    @RequestMapping(value = "/createUser",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加用户信息", notes = "添加用户信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="loginName" , value="登录账号" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="passWord" , value="登录密码" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="confirmPassWord" , value="确认密码" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="nickName" , value="昵称设置" ,required = true , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse createUser(String loginName, String passWord, String confirmPassWord, String nickName, int belongCompany) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = userService.createUser((Long)userId, loginName, passWord, confirmPassWord, nickName, belongCompany);
        }
        return req;
    }

    @RequestMapping(value = "/userList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "用户列表", notes = "用户列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="loginName" , value="登录账号" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="nickName" , value="用户昵称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="userLevel" , value="用户权限 0全部 2管理 3普通用户" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="userStatus" , value="用户状态2全部 0禁用 1正常" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse userList(String loginName, String nickName, Integer userLevel, Integer userStatus, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = userService.userList((Long) userId, loginName, nickName, userLevel, userStatus, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value = "/userStatus",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "启用/禁用账号", notes = "启用/禁用账号", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="userId" , value="被操作用户id" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="userStatus" , value="1启用 2禁用" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse userStatus(Long userId, Integer userStatus) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == currentUserId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = userService.userStatus((Long) currentUserId, userId, userStatus);
        }
        return req;
    }


    @RequestMapping(value = "/selectProportion",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看分成比例", notes = "查看分成比例", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="type" , value="类型" ,required = false , paramType = "query" ,dataType = "int")
    })
    @CrossOrigin
    public ReqResponse selectProportion(int type) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == currentUserId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = userService.selectProportion((Long) currentUserId, type);
        }
        return req;
    }


    @RequestMapping(value = "/updateProportion",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "设置分成比例", notes = "设置分成比例", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="lookProportion" , value="展现比例" ,required = false , paramType = "query" ,dataType = "double"),
            @ApiImplicitParam(name="clickProportion" , value="点击比例" ,required = false , paramType = "query" ,dataType = "double"),
            @ApiImplicitParam(name="upstreamProportion" , value="上游设置分润比例" ,required = false , paramType = "query" ,dataType = "double"),
            @ApiImplicitParam(name="userProportion" , value="当前用户设置分润比例" ,required = false , paramType = "query" ,dataType = "double"),
            @ApiImplicitParam(name="type" , value="类型 1app端 2web端" ,required = false , paramType = "query" ,dataType = "int")
    })
    @CrossOrigin
    public ReqResponse updateProportion(double lookProportion, double clickProportion, double upstreamProportion, double userProportion, int type) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == currentUserId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = userService.updateProportion((Long) currentUserId, lookProportion, clickProportion, upstreamProportion, userProportion, type);
        }
        return req;
    }


}
