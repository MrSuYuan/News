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
            @ApiImplicitParam(name="appId" , value="appId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appStatus" , value="app状态" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appList(String appId, String appName, Integer appStatus, Integer currentPage, Integer pageSize) {
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
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceType" , value="广告位类型" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appAdspaceList(String appName, String spaceName, int spaceType, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appAdspaceList((Long) userId, appName, spaceName, spaceType, currentPage, pageSize);
        }
        return req;
    }


    @RequestMapping(value = "/appAdUpstream",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加广告位上游信息", notes = "添加广告位上游信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamId" , value="上游广告位id" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamAppId" , value="上游appId" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamType" , value="上游平台类型" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="upstreamPackageName" , value="上游包名" ,required = false , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse appAdUpstream(String spaceId, String upstreamId, String upstreamAppId, String upstreamPackageName, int upstreamType) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appAdUpstream((Long) userId, spaceId, upstreamId, upstreamAppId, upstreamPackageName, upstreamType);
        }
        return req;
    }

    @RequestMapping(value = "/appUpstreamList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位上游信息详情", notes = "广告位上游信息详情", httpMethod = "POST")
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


    @RequestMapping(value="addAppStatistics", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上传统计信息", notes = "上传统计信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="statisticsList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addAppStatistics(@RequestParam("statisticsList")String statisticsList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.addAppStatistics((Long)userId, statisticsList);
        }
        return req;
    }

    @RequestMapping(value="appStatisticsManage", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表-管理", notes = "统计列表-管理", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatisticsManage(String spaceName, String appName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appStatisticsList((Long)userId, spaceName, appName, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="appStatisticsUser", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表-用户", notes = "统计列表-用户", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatisticsUser(String spaceName, String appName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appStatisticsUserList((Long)userId, spaceName, appName, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="selectAppAssign", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看调度数据", notes = "查看调度数据", httpMethod = "POST")
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
    @ApiOperation(value = "修改调度数据", notes = "修改调度数据", httpMethod = "POST")
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

    @RequestMapping(value="appReportList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位统计", notes = "广告位统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse appReportList(String appId, String slotId, Integer currentPage, Integer pageSize){
        System.out.println(appId);
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.appReportList(appId, slotId, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="appUpstreamTypeList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上游列表", notes = "上游列表", httpMethod = "POST")
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
    @ApiOperation(value = "全部上游列表", notes = "上游列表", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse allAppUpstreamType(){
        ReqResponse req = appService.allAppUpstreamType();
        return req;
    }

    @RequestMapping(value="updateUpstreamStatus", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改上游状态", notes = "修改上游状态", httpMethod = "POST")
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
    @ApiOperation(value = "添加新上游", notes = "添加新上游", httpMethod = "POST")
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
    @ApiOperation(value = "上游广告位列表", notes = "添加新上游", httpMethod = "POST")
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

    @RequestMapping(value="addReport", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "假-统计信息", notes = "假-统计信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="reportList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addReport(@RequestParam("reportList")String reportList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.addReport(reportList);
        }
        return req;
    }

    @RequestMapping(value="reportList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "假-统计列表", notes = "假-统计列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="startTime" , value="起始时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="endTime" , value="结束时间" ,required = false , paramType = "query" ,dataType = "String")
    })
    @CrossOrigin
    public ReqResponse reportList(String adId, String startTime, String endTime){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appService.reportList(adId, startTime, endTime);
        }
        return req;
    }

}
