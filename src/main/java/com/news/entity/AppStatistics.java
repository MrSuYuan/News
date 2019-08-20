package com.news.entity;

import java.util.Date;

/**
 * APP数据统计信息
 */
public class AppStatistics {

    /**
     * 统计id
     */
    private Long statisticsId;
    /**
     * 上游广告位id
     */
    private String upstreamId;
    /**
     * 平台广告位id
     */
    private String spaceId;
    /**
     * appid
     */
    private String appId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 展现量
     */
    private int lookPV;
    /**
     * 点击量
     */
    private int clickNum;
    /**
     * 点击率
     */
    private double clickProbability;
    /**
     * 收益
     */
    private double income;
    /**
     * ecmp
     */
    private double ecmp;

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public Long getStatisticsId() {
        return statisticsId;
    }

    public void setStatisticsId(Long statisticsId) {
        this.statisticsId = statisticsId;
    }

    public String getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(String spaceId) {
        this.spaceId = spaceId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getLookPV() {
        return lookPV;
    }

    public void setLookPV(int lookPV) {
        this.lookPV = lookPV;
    }

    public int getClickNum() {
        return clickNum;
    }

    public void setClickNum(int clickNum) {
        this.clickNum = clickNum;
    }

    public double getClickProbability() {
        return clickProbability;
    }

    public void setClickProbability(double clickProbability) {
        this.clickProbability = clickProbability;
    }

    public double getIncome() {
        return income;
    }

    public void setIncome(double income) {
        this.income = income;
    }

    public double getEcmp() {
        return ecmp;
    }

    public void setEcmp(double ecmp) {
        this.ecmp = ecmp;
    }
}
