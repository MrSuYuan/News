package com.news.controller;

import com.news.entity.News;
import com.news.service.IndexService;
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
@RequestMapping("")
@Api(value = "/index", tags = "跳转路径接口")
public class IndexController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    IndexService indexService;

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
        ReqResponse req = indexService.getNews(contentType);
        return req;
    }

    /**
     * 主页面
     */
    @RequestMapping(value = "/index",method=RequestMethod.GET)
    public ModelAndView loginPage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("pcList");
        List<News> hotNews = indexService.hotNews();
        mv.addObject("hotNews",hotNews);
        return mv;
    }

    /**
     * 主页面滑动加载 和 切换选项分类加载
     */
    @RequestMapping(value = "/indexMore",method=RequestMethod.POST)
    @ResponseBody
    public ReqResponse indexMore(HttpServletRequest request) {
        ReqResponse req = new ReqResponse();
        String page = request.getParameter("page");
        String contentType = request.getParameter("cate");
        List<News> indexNews = indexService.indexNews(page,contentType);
        req.setCode(ErrorMessage.SUCCESS.getCode());
        req.setMessage("数据加载成功");
        req.setResult(indexNews);
        return req;
    }

    /**
     * 新闻详情页
     */
    @RequestMapping(value = "/detail",method=RequestMethod.GET)
    public ModelAndView detail(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("pcDetail");
        Long newsId = Long.parseLong(request.getParameter("newsId"));
        News news = indexService.newDetails(newsId);
        mv.addObject("news",news);
        List<News> hotNews = indexService.hotNews();
        mv.addObject("hotNews",hotNews);
        return mv;
    }

    /**
     * 移动端主页面跳转
     */
    @RequestMapping(value = "/mobileList",method=RequestMethod.GET)
    public ModelAndView mobileList(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("mobileList2");
        List<News> indexNews = indexService.indexNews("1","1");
        mv.addObject("index",indexNews);
        return mv;
    }

    /**
     * 移动端新闻详情页
     */
    @RequestMapping(value = "/mobileDetail",method=RequestMethod.GET)
    public ModelAndView mobileDetail(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("mobileDetail");
        Long newsId = Long.parseLong(request.getParameter("newsId"));
        News news = indexService.newDetails(newsId);
        mv.addObject("news",news);
        return mv;
    }

    /**
     * 移动端主页面跳转
     */
    @RequestMapping(value = "/test",method=RequestMethod.GET)
    public ModelAndView test(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("test");
        List<News> indexNews = indexService.indexNews("1","1");
        mv.addObject("index",indexNews);
        return mv;
    }

    /**
     * 移动端主页面跳转
     */
    @RequestMapping(value = "/t2",method=RequestMethod.GET)
    public ModelAndView t2(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("mobileList");
        List<News> indexNews = indexService.indexNews("1","1");
        mv.addObject("index",indexNews);
        return mv;
    }
}
