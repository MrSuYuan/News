package com.news.dao;

import com.news.entity.article.Article;
import com.news.entity.article.ArticleStatisticsVo;
import com.news.entity.article.ArticleVo;
import com.news.vo.AppListVo;
import com.news.vo.AppStatisticsListVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 文章微信分享模块
 */
@Repository("articleDao")
public interface ArticleDao {

    /**
     * 广告位数量
     */
    int articleNum();

    /**
     * 添加新的广告位
     */
    void insertArticle(Article article);

    /**
     * 广告位列表
     */
    List<ArticleVo> articleList(Map<String,Object> map);

    /**
     * 广告位列表数量
     */
    int articleListNum(Map<String,Object> map);

    /**
     * 收益列表
     */
    List<ArticleStatisticsVo> articleStatisticsList(Map<String,Object> map);

    /**
     * 收益列表数量
     */
    int articleStatisticsListNum(Map<String,Object> map);

    /**
     * 查看数据统计信息列表
     */
    List<ArticleStatisticsVo> excel(Map<String,Object> map);

}
