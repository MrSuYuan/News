package com.news.controller;

import com.news.service.NewsService;
import com.news.service.TaskService;
import com.utils.base.BaseController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


/**
 * 定时器
 */
//@Service
@Controller
@RequestMapping("task")
@Api(value = "/task", tags = "task模块")
public class TaskController extends BaseController {

    private final Logger logger = LoggerFactory.getLogger(NewsController.class);

    @Autowired
    NewsService newsService;
    @Autowired
    TaskService taskService;

    /**
     * 爬虫获取新闻信息
     */
    public void getNews() {
        logger.error("++++++++++++++获取新闻定时器开启+++++++++++++++++++");
        for(int i = 1; i < 8; i++){
            logger.error("++++++++++++++获取新闻类型+"+i+"++++++++++++++++++");
            newsService.getNews(i);
        }
        logger.error("++++++++++++++获取新闻定时器结束+++++++++++++++++++");
    }

    /**
     * 星辰+数据统计
     */
    @RequestMapping(value = "/xingChen",method=RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "星辰", notes = "星辰", httpMethod = "POST")
    @CrossOrigin
    public void xingChen() {
        logger.error("++++++++++++++星辰广告数据统计开始+++++++++++++++++++");
        //星辰账号key
        //String key = "47484e3dbaf3b66a80ced2";
        //String key = "fe27c82de28463ec3c3b81";
        key("47484e3dbaf3b66a80ced2");
        key("fe27c82de28463ec3c3b81");
        logger.error("++++++++++++++星辰广告数据统计结束+++++++++++++++++++");
    }

    public void key(String key){
        //获取日期(获取昨天的日期)
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE,-1);
        Date d = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(d);
        //请求地址
        String url = "https://channel.xingchenjia.com/client/dataapi/pcwap?key="+key+"&date="+date;
        //https://channel.xingchenjia.com/client/dataapi/pcwap?key=47484e3dbaf3b66a80ced2&date=2020-01-01
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url);
        CloseableHttpResponse response;
        try {
            response = httpClient.execute(httpGet);
            HttpEntity entity = response.getEntity();
            //返回数据
            String str = EntityUtils.toString(entity,"utf-8");
            taskService.xingChen(str, date, d);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
