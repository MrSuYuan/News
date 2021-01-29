package com.news.controller;

import com.news.entity.article.Article;
import com.news.service.ArticleService;
import com.utils.base.BaseController;
import com.utils.response.ErrorMessage;
import com.utils.response.ReqResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;

@Controller
@RequestMapping("article")
@Api(value = "/article", tags = "文章微信分享模块")
public class ArticleController extends BaseController {

    @Autowired
    ArticleService articleService;

    @RequestMapping(value = "/addArticle",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "添加广告位信息", notes = "添加广告位信息", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="article" , value="文章广告位信息对象" ,required = true , paramType = "query" ,dataType = "List")
    })
    @CrossOrigin
    public ReqResponse addArticle(Article article) {
        ReqResponse req = new ReqResponse();
        Object userId = request.getSession().getAttribute("userId");
        if(null == userId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = articleService.addArticle(article);
        }
        return req;
    }


    @RequestMapping(value = "/articleList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位列表", notes = "广告位列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse articleList(Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == currentUserId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = articleService.articleList((Long) currentUserId, currentPage, pageSize);
        }
        return req;
    }


    @RequestMapping(value = "/articleStatisticsList",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "广告位收益列表", notes = "广告位收益列表", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="articleId" , value="广告位ID" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="startTime" , value="起始时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="endTime" , value="结束时间" ,required = false , paramType = "query" ,dataType = "String"),
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="pageSize" , value="页码容量" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse articleStatisticsList(String articleId, String startTime, String endTime, Integer currentPage, Integer pageSize) {
        ReqResponse req = new ReqResponse();
        Object currentUserId = request.getSession().getAttribute("userId");
        if(null == currentUserId){
            req.setCode(ErrorMessage.INVALID_LOGIN.getCode());
            req.setMessage("无效的登录");
        }else{
            req = articleService.articleStatisticsList((Long) currentUserId, articleId, startTime, endTime, currentPage, pageSize);
        }
        return req;
    }

    @RequestMapping(value = "excel" , method= RequestMethod.GET)
    @ApiOperation(value = "数据统计列表", notes = "数据统计列表", httpMethod = "GET")
    public void excel(HttpServletResponse response)throws Exception{

        Object userId = request.getSession().getAttribute("userId");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String excelName = startTime+"-"+endTime;
        OutputStream out = response.getOutputStream();
        response.reset();
        response.addHeader("Content-Disposition", "filename="+new String(excelName.getBytes("gb2312"), "utf-8" )+".xls");
        response.setContentType("application/octet-stream; charset=utf-8");
        articleService.excel((long)userId, startTime, endTime, null, out);
    }

}
