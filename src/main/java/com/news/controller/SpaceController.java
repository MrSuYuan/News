package com.news.controller;

import com.news.service.SpaceService;
import com.utils.base.BaseController;
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
    @ApiOperation(value = "平台统计", notes = "平台统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse platformStatistics(String spaceId, String date) {
        ReqResponse req = spaceService.platformStatistics(spaceId, date);
        return req;
    }


    @RequestMapping(value = "/channelStatistics",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "渠道统计", notes = "渠道统计", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse channelStatistics(String spaceId, String date) {
        ReqResponse req = spaceService.channelStatistics(spaceId, date);
        return req;
    }
}
