package com.news.service;

import com.news.entity.article.Article;
import com.utils.response.ReqResponse;

import java.io.OutputStream;

/**
 * 文章微信分享模块接口
 */
public interface ArticleService {

    /**
     * 添加新的广告位信息
     */
    ReqResponse addArticle(Article article);

    /**
     * APP列表
     */
    ReqResponse articleList(Long currentUserId, Integer currentPage, Integer pageSize);

    /**
     * APP收益列表
     */
    ReqResponse articleStatisticsList(Long currentUserId, String articleId, String startTime, String endTime, Integer currentPage, Integer pageSize);

    /**
     * excel
     */
    void excel(long userId, String startTime, String endTime, Integer currentPage, OutputStream out) ;
}
