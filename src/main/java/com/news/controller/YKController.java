package com.news.controller;

import com.news.entity.YKAd;
import com.news.entity.YKAdvertiser;
import com.news.service.TemporaryService;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("yk")
@Api(value = "/yk", tags = "优酷相关")
public class YKController extends BaseController {

    @Autowired
    TemporaryService temporaryService;


    @RequestMapping(value="checkAdvertiser", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看广告主", notes = "查看广告主", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse checkAdvertiser(){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.ykAdvertiserList();
        }
        return req;
    }


    @RequestMapping(value="addAdvertiser", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加广告主信息", notes = "添加广告主信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="advertiser" , value="广告主信息对象" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addAdvertiser(YKAdvertiser advertiser)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.addAdvertiser(advertiser);
        }
        return req;
    }


    @RequestMapping(value="deleteAdvertiser", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除广告主信息", notes = "删除广告主信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="id" , value="数据id" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse deleteAdvertiser(int id) throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.deleteAdvertiser(id);
        }
        return req;
    }


    @RequestMapping(value="checkAd", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "查看广告", notes = "查看广告", httpMethod = "POST")
    @CrossOrigin
    public ReqResponse checkAd(){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.ykAdList();
        }
        return req;
    }


    @RequestMapping(value="addAd", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加广告信息", notes = "添加广告信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="ykAd" , value="广告信息参数" ,required = true , paramType = "query" ,dataType = "Object")
    })
    @CrossOrigin
    public ReqResponse addAd(YKAd ykAd)throws Exception{
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.addYKAd(ykAd);
        }
        return req;
    }


    @RequestMapping(value="deleteAd", method= RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除广告信息", notes = "删除广告信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="crid" , value="数据id" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse deleteAd(int crid){
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = temporaryService.deleteAd(crid);
        }
        return req;
    }

}
