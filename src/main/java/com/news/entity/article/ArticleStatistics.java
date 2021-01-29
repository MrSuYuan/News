package com.news.entity.article;

/**
 * 收益统计
 */
public class ArticleStatistics {

    private int id;
    private String articleId;
    private int shareUser;
    private int shareTimes;
    private int backTimes;
    private int pv;
    private int uv;
    private int ip;
    private double income;
    private String createTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getArticleId() {
        return articleId;
    }

    public void setArticleId(String articleId) {
        this.articleId = articleId;
    }

    public int getShareUser() {
        return shareUser;
    }

    public void setShareUser(int shareUser) {
        this.shareUser = shareUser;
    }

    public int getShareTimes() {
        return shareTimes;
    }

    public void setShareTimes(int shareTimes) {
        this.shareTimes = shareTimes;
    }

    public int getBackTimes() {
        return backTimes;
    }

    public void setBackTimes(int backTimes) {
        this.backTimes = backTimes;
    }

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public int getUv() {
        return uv;
    }

    public void setUv(int uv) {
        this.uv = uv;
    }

    public int getIp() {
        return ip;
    }

    public void setIp(int ip) {
        this.ip = ip;
    }

    public double getIncome() {
        return income;
    }

    public void setIncome(double income) {
        this.income = income;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
