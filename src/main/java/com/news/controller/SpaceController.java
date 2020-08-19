package com.news.controller;

import com.news.service.SpaceService;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("space")
@Api(value = "/space", tags = "广告位模块")
public class SpaceController extends BaseController {

    @Autowired
    SpaceService spaceService;

    @RequestMapping(value = "/spaceMsg",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看广告位基本信息", notes = "查看广告位基本信息", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse spaceMsg(String spaceId) {
        ReqResponse req = spaceService.spaceMsg(spaceId);
        return req;
    }


    @RequestMapping(value = "/platformStatistics",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "平台分时统计", notes = "平台统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse platformStatistics(String spaceId, String date) {
        ReqResponse req = spaceService.platformStatistics(spaceId, date);
        return req;
    }


    @RequestMapping(value = "/channelStatistics",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "渠道分时统计", notes = "渠道统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse channelStatistics(String spaceId, String date) {
        ReqResponse req = spaceService.channelStatistics(spaceId, date);
        return req;
    }

    @RequestMapping(value="appReportList", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上报统计列表", notes = "上报统计列表", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse appReportList(String appId, String slotId, String startTime, String endTime, Integer currentPage, Integer pageSize){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = spaceService.appReportList(appId, slotId, startTime, endTime, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value="appUpstreamReport", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "上报统计详情", notes = "上报统计详情", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse appUpstreamReport(String createTime, String slotId){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = spaceService.appUpstreamReport(createTime, slotId);
        }
        return req;

    }

}
