package com.news.controller;

import com.news.entity.App;
import com.news.service.AppService;
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
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
@RequestMapping("app")
@Api(value = "/app", tags = "APP模块")
public class AppController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    UserService userService;

    @Autowired
    AppService appService;

    @RequestMapping(value = "/industy",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "行业分类", notes = "行业分类", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse industy() {
        ReqResponse req = appService.industy();
        return req;
    }

    @RequestMapping(value = "/beLongUser",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看归属用户", notes = "查看归属用户", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse beLongUser() {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.beLongUser((Long)userId);
        }
        return req;
    }

    @RequestMapping(value = "/createApp",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "创建app信息", notes = "创建app信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="downloadlink" , value="下载地址" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="rootType" , value="大类" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="subType" , value="小类" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="platform" , value="系统" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="terminal" , value="客户端" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="packageName" , value="包名" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="version" , value="版本" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="description" , value="描述简介" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="keyWords" , value="关键字" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="userId" , value="所属用户" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="currentUserLevel" , value="当前用户身份" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse createApp(String appName, String downloadlink, Long rootType, Long subType, int platform,
                                 int terminal, String packageName, String version, String description, String keyWords, Long userId, Integer currentUserLevel) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            App app = new App();
            app.setAppName(appName);
            app.setDownloadlink(downloadlink);
            app.setRootType(rootType);
            app.setSubType(subType);
            app.setPlatform(platform);
            app.setTerminal(terminal);
            app.setPackageName(packageName);
            app.setVersion(version);
            app.setDescription(description);
            app.setKeyWords(keyWords);
            app.setUserId(userId);
            req = appService.createApp((Long)currentUserId, currentUserLevel, app);
        }
        return req;
    }

    @RequestMapping(value = "/appList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "app列表", notes = "app列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="appId" , value="appId" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appStatus" , value="app状态" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appList(Long appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appList((Long) userId, appId, appName, appStatus, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value = "/appStatus",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改app状态", notes = "修改app状态", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="appId" , value="appId" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="appStatus" , value="app状态" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatus(Long appId, Integer appStatus) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appStatus((Long) userId, appId, appStatus);
        }
        return req;
    }

}
