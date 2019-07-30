package com.news.controller;

import com.news.entity.News;
import com.news.service.NewsService;
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
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("news")
@Api(value = "/news", tags = "新闻模块")
public class NewsController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    NewsService newsService;

    /**
     * 爬虫获取新闻信息
     */
    @RequestMapping(value = "/getNews",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "爬虫获取新闻信息", notes = "爬虫获取新闻信息", httpMethod = "POST")
    @ApiImplicitParams(value={
        @ApiImplicitParam(name="contentType" , value="1推荐 2热点 3娱乐 4科技 5探索 6趣闻 7历史" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse getNews(HttpServletRequest request) {
        int contentType = Integer.valueOf(request.getParameter("contentType"));
        ReqResponse req = newsService.getNews(contentType);
        return req;
    }

    /**
     * 主页面
     */
    @RequestMapping(value = "/pcList",method=RequestMethod.GET)
    public ModelAndView pcList(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/pcList");
        List<News> hotNews = newsService.hotNews();
        mv.addObject("hotNews",hotNews);
        return mv;
    }

    /**
     * 主页面滑动加载 和 切换选项分类加载
     */
    @RequestMapping(value = "/pcListMore",method=RequestMethod.POST)
    @ResponseBody
    public ReqResponse pcListMore(HttpServletRequest request) {
        ReqResponse req = new ReqResponse();
        String page = request.getParameter("page");
        String contentType = request.getParameter("cate");
        List<News> indexNews = newsService.indexNews(page,contentType);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载成功");
        req.setResult(indexNews);
        return req;
    }

    /**
     * 新闻详情页
     */
    @RequestMapping(value = "/newsDetail",method=RequestMethod.GET)
    public ModelAndView newsDetail(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/pcDetail");
        Long newsId = Long.parseLong(request.getParameter("newsId"));
        News news = newsService.newDetails(newsId);
        mv.addObject("news",news);
        List<News> hotNews = newsService.hotNews();
        mv.addObject("hotNews",hotNews);
        return mv;
    }

    /**
     * 移动端主页面跳转
     */
    @RequestMapping(value = "/mobileList",method=RequestMethod.GET)
    public ModelAndView mobileList(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/mobileList");
        List<News> indexNews = newsService.indexNews("1","1");
        mv.addObject("index",indexNews);
        return mv;
    }

    /**
     * 移动端新闻详情页
     */
    @RequestMapping(value = "/mobileDetail",method=RequestMethod.GET)
    public ModelAndView mobileDetail(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/mobileDetail");
        Long newsId = Long.parseLong(request.getParameter("newsId"));
        News news = newsService.newDetails(newsId);
        mv.addObject("news",news);
        return mv;
    }


    /**
     * 移动端主页面跳转
     */
    @RequestMapping(value = "/appList",method=RequestMethod.GET)
    public ModelAndView appList(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/appList");
        return mv;
    }


    @RequestMapping(value = "/loadData",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "移动端数据加载", notes = "移动端数据加载", httpMethod = "POST")
    @ApiImplicitParams(value={
            @ApiImplicitParam(name="currentPage" , value="当前页" ,required = false , paramType = "query" ,dataType = "Integer"),
            @ApiImplicitParam(name="sign" , value="分类标记" ,required = false , paramType = "query" ,dataType = "Integer")
    })
    @CrossOrigin
    public ReqResponse loadData(Integer currentPage, Integer sign) {
        ReqResponse req = newsService.loadData(currentPage, sign);
        return req;
    }


    /**
     * 模板
     */
    @RequestMapping(value = "/moban",method=RequestMethod.GET)
    public ModelAndView moban(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/moban");
        return mv;
    }

    /**
     * 模板
     */
    @RequestMapping(value = "/newsList",method=RequestMethod.GET)
    public ModelAndView newsList(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("news/newsList");
        return mv;
    }

}
