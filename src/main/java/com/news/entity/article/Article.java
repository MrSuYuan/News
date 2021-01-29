package com.news.entity.article;

import java.util.Date;

/**
 * 文章分享对象
 */
public class Article {

    private String articleId;
    private String appId;
    private String upstreamAppkey;
    private String upstreamAppid;
    private String articleName;
    private String backUrl;
    private Date createTime;
    private Date updateTime;

    public String getArticleId() {
        return articleId;
    }

    public void setArticleId(String articleId) {
        this.articleId = articleId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getUpstreamAppkey() {
        return upstreamAppkey;
    }

    public void setUpstreamAppkey(String upstreamAppkey) {
        this.upstreamAppkey = upstreamAppkey;
    }

    public String getUpstreamAppid() {
        return upstreamAppid;
    }

    public void setUpstreamAppid(String upstreamAppid) {
        this.upstreamAppid = upstreamAppid;
    }

    public String getArticleName() {
        return articleName;
    }

    public void setArticleName(String articleName) {
        this.articleName = articleName;
    }

    public String getBackUrl() {
        return backUrl;
    }

    public void setBackUrl(String backUrl) {
        this.backUrl = backUrl;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
