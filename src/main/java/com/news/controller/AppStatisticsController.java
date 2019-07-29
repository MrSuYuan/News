package com.news.controller;

import com.news.service.AppStatisticsService;
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
@RequestMapping("appStatistics")
@Api(value = "/appStatistics", tags = "APP统计模块")
public class AppStatisticsController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    AppStatisticsService appStatisticsService;

    @RequestMapping(value="addAppStatistics", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上传统计信息", notes = "上传统计信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="reportList" , value="参数集合" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addAppStatistics(@RequestParam("reportList")String reportList)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appStatisticsService.addAppStatistics((Long)userId, reportList);
        }
        return req;
    }

    @RequestMapping(value="appStatisticsList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "统计列表", notes = "统计列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="appId" , value="appId" ,required = false , paramType = "query" ,dataType = "Long"),
            @ApiImplicitParam(name="appName" , value="app名称" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页面容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse appStatisticsList(Long appId, String appName, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = appStatisticsService.appStatisticsList((Long)userId, appId, appName, currentPage, pageSize);
        }
        return req;
    }

}
