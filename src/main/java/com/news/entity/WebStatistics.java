package com.news.entity;

import java.util.Date;

/**
 * web端数据统计
 */
public class WebStatistics {

    /**
     * 统计id
     */
    private Long statisticsId;
    /**
     * 广告位id
     */
    private int spaceId;
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
    /**
     * 初始展现量
     */
    private int beforeLookPV;
    /**
     * 初始点击量
     */
    private int beforeClickNum;
    /**
     * 初始收益
     */
    private double beforeIncome;

    public int getBeforeLookPV() {
        return beforeLookPV;
    }

    public void setBeforeLookPV(int beforeLookPV) {
        this.beforeLookPV = beforeLookPV;
    }

    public int getBeforeClickNum() {
        return beforeClickNum;
    }

    public void setBeforeClickNum(int beforeClickNum) {
        this.beforeClickNum = beforeClickNum;
    }

    public double getBeforeIncome() {
        return beforeIncome;
    }

    public void setBeforeIncome(double beforeIncome) {
        this.beforeIncome = beforeIncome;
    }

    public Long getStatisticsId() {
        return statisticsId;
    }

    public void setStatisticsId(Long statisticsId) {
        this.statisticsId = statisticsId;
    }

    public int getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(int spaceId) {
        this.spaceId = spaceId;
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
