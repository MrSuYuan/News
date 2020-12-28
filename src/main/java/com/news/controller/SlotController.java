package com.news.controller;

import com.news.service.SlotService;
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
@RequestMapping("slot")
@Api(value = "/slot", tags = "广告位模块")
public class SlotController extends BaseController {

    @Autowired
    SlotService slotService;

    @RequestMapping(value = "/slotMsg",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看广告位基本信息", notes = "查看广告位基本信息", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse slotMsg(String slotId) {
        ReqResponse req = slotService.slotMsg(slotId);
        return req;
    }


    @RequestMapping(value = "/platformStatistics",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "平台分时统计", notes = "平台统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse platformStatistics(String slotId, String date) {
        ReqResponse req = slotService.platformStatistics(slotId, date);
        return req;
    }


    @RequestMapping(value = "/channelStatistics",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "渠道分时统计", notes = "渠道统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse channelStatistics(String slotId, String date) {
        ReqResponse req = slotService.channelStatistics(slotId, date);
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
            req = slotService.appReportList(appId, slotId, startTime, endTime, currentPage, pageSize);
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
            req = slotService.appUpstreamReport(createTime, slotId);
        }
        return req;

    }

}
