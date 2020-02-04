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
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.Iterator;

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
            @ApiImplicitParam(name="upstreamId" , value="广告位id" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="upstreamType" , value="上游类型" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="terminal" , value="终端信息" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = true , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="spaceType" , value="广告位类型" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="remark" , value="备注" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="width" , value="宽度" ,required = true , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="height" , value="高度" ,required = true , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse createAdspace(Long webId, int terminal, String spaceName, int spaceType, String remark, int width, int height, String upstreamId, int upstreamType) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.createAdspace((Long)userId, webId, terminal, spaceName, spaceType, remark, width, height, upstreamId, upstreamType);
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


    @RequestMapping(value="idStatus", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "id状态", notes = "id状态", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="status" , value="最新状态" ,required = false , paramType = "query" ,dataType = "Integer"),
    })
    @CrossOrigin
    public ReqResponse idStatus(int spaceId, int status){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.idStatus(spaceId, status);
        }
        return req;
    }


    @RequestMapping(value="webStatisticsManage", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表-管理", notes = "统计列表-管理", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="webName" , value="网站名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webStatisticsManage(String startTime, String endTime, String spaceName, String webName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.webStatisticsManage(startTime, endTime, (Long)userId, spaceName, webName, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="webStatisticsUser", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表-用户", notes = "统计列表-用户", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceName" , value="广告位名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="webName" , value="网站名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webStatisticsUser(String startTime, String endTime, String spaceName, String webName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = webService.webStatisticsUser(startTime, endTime, (Long)userId, spaceName, webName, currentPage, pageSize);
        }
        return req;
    }



    @RequestMapping(value="spaceDivided", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "spaceDivided", notes = "spaceDivided", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="dividedY" , value="Y" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="dividedZ" , value="Z" ,required = false , paramType = "query" ,dataType = "Double")
    })
    @CrossOrigin
    public ReqResponse spaceDivided(Integer spaceId, double dividedY, double dividedZ){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = webService.spaceDivided(spaceId, dividedY, dividedZ);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }


    @RequestMapping(value="webUpstreamTypeList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "web上游列表", notes = "web上游列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webUpstreamTypeList(Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = webService.webUpstreamTypeList(currentPage, pageSize);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    @RequestMapping(value="webUpstreamDivided", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "设置上游分成比例", notes = "设置上游分成比例", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="upstreamType" , value="上游" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="upstreamDivided" , value="分成比例" ,required = false , paramType = "query" ,dataType = "Double")
    })
    @CrossOrigin
    public ReqResponse webUpstreamDivided(Integer upstreamType, double upstreamDivided){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = webService.webUpstreamDivided(upstreamType, upstreamDivided);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    @RequestMapping(value="webStatisticsStatus", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "通过/删除数据", notes = "通过/删除数据", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="statisticsId" , value="数据id" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="status" , value="状态" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webStatisticsStatus(Integer statisticsId, Integer status){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = webService.webStatisticsStatus(statisticsId, status);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    @RequestMapping(value="webStatisticsOne", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查询数据", notes = "查询数据", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="statisticsId" , value="数据id" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse webStatisticsOne(Integer statisticsId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = webService.webStatisticsOne(statisticsId);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    @RequestMapping(value="updateStatistics", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "修改数据", notes = "修改数据", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="dividedY" , value="y" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="dividedZ" , value="z" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="lookPV" , value="展现" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="clickNum" , value="点击" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="income" , value="收入" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="clickProbability" , value="点击率" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="ecmp" , value="ecpm" ,required = false , paramType = "query" ,dataType = "Double"),
            @ApiImplicitParam(name="spaceId" , value="广告位id" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="statisticsId" , value="数据id" ,required = false , paramType = "query" ,dataType = "Integer"),
    })
    @CrossOrigin
    public ReqResponse updateStatistics(double dividedY, double dividedZ, Integer lookPV, Integer clickNum, double income, double clickProbability,
                                        double ecmp, Integer spaceId, Integer statisticsId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        Object userLevel = request.getSession().getAttribute("userLevel");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            if ((int)userLevel == 1 || (int)userLevel == 2){
                req = webService.updateStatistics(dividedY, dividedZ, lookPV, clickNum, income, clickProbability, ecmp, spaceId, statisticsId);
            }else{
                req.setCode(ErrorMessage.FAIL.getCode());
                req.setMessage("您没有权限");
            }
        }
        return req;
    }

    @RequestMapping(value="upload", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上传Excel", notes = "上传Excel", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse upload(HttpServletRequest request) throws Exception {
        ReqResponse req = new ReqResponse();
        Workbook workBook;
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver( request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 取得上传文件\
                MultipartFile file = multiRequest.getFile(iter.next());
                InputStream fis =  file.getInputStream();
                workBook = WorkbookFactory.create(fis);
                int numberOfSheets = workBook.getNumberOfSheets();
                // sheet工作表
                for (int s = 0; s < numberOfSheets; s++) {
                    Sheet sheetAt = workBook.getSheetAt(s);
                    webService.baiDuExcel(sheetAt);
                }
            }
            req.setCode("200");
            req.setMessage("成功");
        }else{
            req.setCode("300");
            req.setMessage("检测不到文件");
        }
        return req;
    }


}
