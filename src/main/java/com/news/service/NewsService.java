package com.news.service;

import com.news.entity.News;
import com.utils.response.ReqResponse;

import java.util.List;

/**
 * 新闻模块
 */
public interface NewsService {

    /**
     * 爬虫爬取新闻
     */
    ReqResponse getNews(int contentType);

    /**
     * 主页面-主列表
     */
    List<News> indexNews(String page, String contentType);

    /**
     * 主页面-热门列表
     */
    List<News> hotNews();

    /**
     * 新闻详情
     */
    News newDetails(Long newsId);
}
