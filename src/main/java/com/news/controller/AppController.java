package com.news.controller;

import com.news.entity.App;
import com.news.service.AppService;
import com.news.service.UserService;
import org.apache.http.HttpResponse;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import net.sf.json.JSONObject;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.util.Iterator;

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
            @ApiImplicitParam(name="loginName" , value="筛选项登录账号" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="nickName" , value="筛选项公司名" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appId" , value="appId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appStatus" , value="app状态" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appList(String loginName, String nickName, String appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == currentUserId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appList((Long) currentUserId, loginName, nickName, appId, appName, appStatus, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value = "/appStatus",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改app状态", notes = "修改app状态", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="appId" , value="appId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appStatus" , value="app状态" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatus(String appId, Integer appStatus) {
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

    @RequestMapping(value = "/createAdspace",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "创建广告位信息", notes = "创建广告位信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="appId" , value="appId" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceType" , value="广告位类型" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="width" , value="宽度" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="height" , value="高度" ,required = true , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse createAdspace(String appId, int spaceType, String spaceName, int width, int height) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.createAdspace((Long)userId, appId, spaceType, spaceName, width, height);
        }
        return req;
    }

    @RequestMapping(value = "/appAdspaceList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位列表", notes = "广告位列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="loginName" , value="筛选项登录账号" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="nickName" , value="筛选项公司名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appId" , value="筛选项APPID" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceId" , value="筛选项广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceType" , value="广告位类型" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appAdspaceList(String loginName, String nickName, String appId, String spaceId, int spaceType, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appAdspaceList((Long) userId, loginName, nickName, appId, spaceId, spaceType, currentPage, pageSize);
        }
        return req;
    }


    @RequestMapping(value = "/flowStatus",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位列表", notes = "广告位列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="筛选项广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="flowStatus" , value="0停量 1放量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse flowStatus(String spaceId, int flowStatus) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.flowStatus((Long) userId, spaceId, flowStatus);
        }
        return req;
    }


    @RequestMapping(value = "/appAdUpstream",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位页面-添加上游", notes = "添加广告位上游信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamId" , value="上游广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamAppId" , value="上游appId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamType" , value="上游平台类型" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="upstreamPackageName" , value="上游包名" ,required = false , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse appAdUpstream(String spaceId, String upstreamId, String upstreamAppId, String upstreamAppName, String upstreamPackageName, Integer upstreamWidth, Integer upstreamHeight, int upstreamType) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            System.out.println();
            req = appService.appAdUpstream((Long) userId, spaceId, upstreamId, upstreamAppId, upstreamAppName, upstreamPackageName, upstreamWidth, upstreamHeight, upstreamType);
        }
        return req;
    }


    @RequestMapping(value = "/appUpstreamList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位页面-查看上游", notes = "广告位上游信息列表详情", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse appUpstreamList(String spaceId) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appUpstreamList(spaceId);
        }
        return req;
    }


    @RequestMapping(value="selectAppAssign", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位页面-查看分流", notes = "查看分流", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse selectAppAssign(String spaceId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.selectAppAssign(spaceId);
        }
        return req;
    }

    @RequestMapping(value="assignSubmit", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改分流比例", notes = "修改分流比例", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse assignSubmit(@RequestParam("list")String list, String spaceId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.assignSubmit(list, spaceId);
        }
        return req;
    }

    @RequestMapping(value="updateSpaceDivided", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位页面-修改分成", notes = "分成", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="dividedY" , value="Y" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="dividedZ" , value="Z" ,required = false , paramType = "query" ,dataType = "Double")
    })
    @CrossOrigin
    public ReqResponse updateSpaceDivided(String spaceId, double dividedY, double dividedZ){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.updateSpaceDivided(spaceId, dividedY, dividedZ);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    @RequestMapping(value="appUpstreamTypeList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游设置-上游列表", notes = "上游列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appUpstreamTypeList(Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appUpstreamList(currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="allAppUpstreamType", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游设置-全部上游列表", notes = "上游列表", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse allAppUpstreamType(){
        ReqResponse req = appService.allAppUpstreamType();
        return req;
    }

    @RequestMapping(value="updateUpstreamStatus", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游设置-修改上游状态", notes = "修改上游状态", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="id" , value="id" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="status" , value="状态" ,required = true , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse updateUpstreamStatus(Integer id, Integer status){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.updateUpstreamStatus(id, status);
        }
        return req;
    }

    @RequestMapping(value="appUpstreamAdd", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游设置-添加新上游", notes = "添加新上游", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="type" , value="编号" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="name" , value="名称" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="shortName" , value="简称" ,required = true , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse appUpstreamAdd(Integer type, String name, String shortName){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.appUpstreamAdd(type, name, shortName);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }

        }
        return req;
    }

    @RequestMapping(value="appUpstreamIdList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游设置-上游广告位列表", notes = "按上游查看广告位", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="type" , value="上游类型" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="upstreamId" , value="上游id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appUpstreamIdList(Integer currentPage, Integer pageSize, Integer type, String upstreamId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.appUpstreamIdList(currentPage, pageSize, type, upstreamId);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }

        }
        return req;
    }

    @RequestMapping(value="appUpstreamIdMsg", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游id对应详情", notes = "上游id对应详情", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="upstreamId" , value="上游id" ,required = false , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse appUpstreamIdMsg(String upstreamId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.appUpstreamIdMsg(upstreamId);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }

        }
        return req;
    }

    @RequestMapping(value="newUpstream", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "更换绑定", notes = "更换绑定", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="upstreamId" , value="广告位id" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="newUpstreamId" , value="新上游id" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="newUpstreamAppId" , value="新上游appId" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="newUpstreamPackageName" , value="新上游包名" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="newUpstreamType" , value="新上游类型" ,required = true , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse newUpstream(String upstreamId, String newUpstreamId, String newUpstreamAppId, Integer newUpstreamType, String newUpstreamPackageName){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.changeUpstream(upstreamId, newUpstreamId, newUpstreamAppId, newUpstreamType, newUpstreamPackageName);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }

        }
        return req;
    }

    @RequestMapping(value="deleteUpstreamId", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除上游ID", notes = "删除上游ID", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="upstreamId" , value="广告位id" ,required = true , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse deleteUpstreamId(String upstreamId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.deleteUpstreamId(upstreamId);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }

        }
        return req;
    }

    @RequestMapping(value="appUpstreamDivided", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "设置上游分成比例", notes = "设置上游分成比例", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="upstreamType" , value="上游" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="upstreamDivided" , value="分成比例" ,required = false , paramType = "query" ,dataType = "Double")
    })
    @CrossOrigin
    public ReqResponse appUpstreamDivided(Integer upstreamType, double upstreamDivided){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.appUpstreamDivided(upstreamType, upstreamDivided);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    /**
     * ________________________________________________________________________________
     */


    @RequestMapping(value="addAppStatistics", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上传统计信息", notes = "上传统计信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="statisticsList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addAppStatistics(@RequestParam("statisticsList")String statisticsList, int currentUserLevel)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.addAppStatistics((Long)userId, currentUserLevel, statisticsList);
        }
        return req;
    }

    @RequestMapping(value="appStatisticsUser", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表-用户", notes = "统计列表-用户", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="startTime" , value="起始时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="endTime" , value="结束时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatisticsUser(String startTime, String endTime, String spaceName, String appName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appStatisticsUserList((int)userLevel, startTime, endTime, (Long)userId, spaceName, appName, currentPage, pageSize);
        }
        return req;
    }


    @RequestMapping(value="appStatisticsManage", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表-管理", notes = "统计列表-管理", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="status" , value="审核状态" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="startTime" , value="起始时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="endTime" , value="结束时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatisticsManage(String startTime, String endTime, String spaceName, String appName, Integer currentPage, Integer pageSize, Integer status){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appStatisticsList(startTime, endTime, (Long)userId, spaceName, appName, currentPage, pageSize, status);
        }
        return req;
    }


    @RequestMapping(value="examinationPassed", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "多选通过", notes = "多选通过", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="ids" , value="id集合" ,required = false , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse examinationPassed(String ids){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.examinationPassed(ids);
        }
        return req;
    }


    @RequestMapping(value = "/httpRequest", method = {RequestMethod.GET, RequestMethod.POST })
    @ResponseBody
    @CrossOrigin
    public ReqResponse httpRequest(@RequestBody String data,HttpServletResponse response) throws Exception{
        ReqResponse req = new ReqResponse();
        System.out.println(data);
        String url = "http://47.95.31.238/adx/ssp/dspAdVideo";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        JSONObject jsonResult;
        HttpPost method = new HttpPost(url);
        method.setHeader("Content-Type","application/json");
        try {
            StringEntity entity = new StringEntity(data);
            method.setEntity(entity);
            HttpResponse result = httpClient.execute(method);
            url = URLDecoder.decode(url, "UTF-8");
            String str = EntityUtils.toString(result.getEntity(), "utf-8");
            jsonResult = JSONObject.fromObject(str);
            System.out.println("post请求提交成功:" + jsonResult);
            req.setCode("200");
            req.setResult(jsonResult.toString());
        } catch (IOException e) {
            System.out.println("post请求提交失败:" + url);
            req.setCode("500");
        }
        return req;
    }

    @RequestMapping(value="adspaceDetail", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位详情", notes = "广告位详情", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位ID" ,required = true , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse adspaceDetail(String spaceId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.adspaceDetail(spaceId);
        }
        return req;
    }


    @RequestMapping(value="changeStatus", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "changeStatus", notes = "通过数据统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse changeStatus(String statisticsId,int status){
        //1通过 0删除
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = appService.changeStatus(statisticsId, status);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    /**
     * 上传uc_excel
     */
    @RequestMapping(value = "/uploadUCExcel", method = RequestMethod.POST)
    @ResponseBody
    public ReqResponse uploadUCExcel(HttpServletRequest request) throws Exception {
        ReqResponse req = new ReqResponse();
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver( request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                InputStream inputStream = file.getInputStream(); // 获取文件的输入流
                Workbook workbook = WorkbookFactory.create(inputStream);
                int numberOfSheets = workbook.getNumberOfSheets();
                if (numberOfSheets > 0){
                    // sheet工作表
                    Sheet sheet = workbook.getSheetAt(0);
                    req = appService.readUCExcel(sheet);
                    req.setCode("200");
                    req.setMessage("成功");
                }else{
                    req.setCode("300");
                    req.setMessage("表格数据错误");
                }
            }

        }else{
            req.setCode("300");
            req.setMessage("检测不到文件");
        }
        return req;
    }


    @RequestMapping(value="addAppStatisticsUC", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "保存UCExcel数据", notes = "保存UCExcel数据", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="statisticsList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addAppStatisticsUC(@RequestParam("statisticsList")String statisticsList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");

        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            int userLevel = (int)request.getSession().getAttribute("userLevel");
            if (userLevel == 0 || userLevel == 1 || userLevel == 2){
                req = appService.addAppStatisticsUC(statisticsList);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("无权限操作");
            }
        }
        return req;
    }


    /**
     * 上传其他_excel
     */
    @RequestMapping(value = "/uploadExcel", method = RequestMethod.POST)
    @ResponseBody
    public ReqResponse uploadExcel(HttpServletRequest request) throws Exception {
        ReqResponse req = new ReqResponse();
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver( request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                InputStream inputStream = file.getInputStream(); // 获取文件的输入流
                Workbook workbook = WorkbookFactory.create(inputStream);
                int numberOfSheets = workbook.getNumberOfSheets();
                if (numberOfSheets > 0){
                    // sheet工作表
                    Sheet sheet = workbook.getSheetAt(0);
                    req = appService.readExcel(sheet);
                    req.setCode("200");
                    req.setMessage("成功");
                }else{
                    req.setCode("300");
                    req.setMessage("表格数据错误");
                }
            }

        }else{
            req.setCode("300");
            req.setMessage("检测不到文件");
        }
        return req;
    }




}
