package com.news.controller;

import com.news.entity.Web;
import com.news.service.WebService;
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
@RequestMapping("web")
@Api(value = "/web", tags = "WEB模块")
public class WebController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    WebService webService;

    @RequestMapping(value = "/createWeb",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "创建web信息", notes = "创建web信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="webName" , value="网站名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="webUrl" , value="网站域名" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="rootType" , value="大类" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="subType" , value="小类" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="recordInfo" , value="备案信息" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="accessLevel" , value="访问量" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="webDescription" , value="网站描述" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="remark" , value="备注" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="userId" , value="所属用户" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="currentUserLevel" , value="当前用户身份" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse createWeb(String webName, String webUrl, Long rootType, Long subType, String recordInfo,
                                 int accessLevel, String webDescription, String remark, Long userId, Integer currentUserLevel) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            Web web = new Web();
            web.setWebName(webName);
            web.setWebUrl(webUrl);
            web.setRootType(rootType);
            web.setSubType(subType);
            web.setRecordInfo(recordInfo);
            web.setAccessLevel(accessLevel);
            web.setWebDescription(webDescription);
            web.setRemark(remark);
            web.setUserId(userId);
            req = webService.createWeb((Long)currentUserId, currentUserLevel, web);
        }
        return req;
    }

    @RequestMapping(value = "/webList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "webList", notes = "webList", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="webId" , value="webId" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="webName" , value="web名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="webStatus" , value="web状态" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webList(Long webId, String webName, Integer webStatus, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.webList((Long) userId, webId, webName, webStatus, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value = "/webStatus",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改web状态", notes = "修改web状态", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="webId" , value="webId" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="webStatus" , value="web状态" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatus(Long webId, Integer webStatus) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.webStatus((Long) userId, webId, webStatus);
        }
        return req;
    }

    @RequestMapping(value = "/createAdspace",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "创建广告位信息", notes = "创建广告位信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="webId" , value="webId" ,required = true , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamType" , value="上游类型" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="terminal" , value="终端信息" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceType" , value="广告位类型" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="remark" , value="备注" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="width" , value="宽度" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="height" , value="高度" ,required = true , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse createAdspace(Long webId, int terminal, String spaceName, int spaceType, String remark, int width, int height, String spaceId, int upstreamType) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.createAdspace((Long)userId, webId, terminal, spaceName, spaceType, remark, width, height, spaceId, upstreamType);
        }
        return req;
    }

    @RequestMapping(value = "/webAdspaceList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位列表", notes = "广告位列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="webName" , value="web名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceType" , value="广告位类型" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="terminal" , value="终端" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webAdspaceList(String webName, String spaceName, int terminal, int spaceType, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.webAdspaceList((Long) userId, webName, spaceName, terminal, spaceType, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="addWebStatistics", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上传统计信息", notes = "上传统计信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="statisticsList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addWebStatistics(@RequestParam("statisticsList")String statisticsList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.addWebStatistics((Long)userId, statisticsList);
        }
        return req;
    }

    @RequestMapping(value="webStatisticsList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表", notes = "统计列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="webName" , value="网站名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatisticsList(String startTime, String endTime, String spaceName, String webName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.webStatisticsList(startTime, endTime, (Long)userId, spaceName, webName, currentPage, pageSize);
        }
        return req;
    }

}
