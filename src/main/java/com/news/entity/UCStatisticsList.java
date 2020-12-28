package com.news.entity;

import java.util.Date;

/**
 * uc结算Excel表
 */
public class UCStatisticsList {

    /**
     * 统计id
     */
    private Long statisticsId;
    /**
     * 上游广告位id
     */
    private String upstreamId;
    private String upstreamName;
    /**
     * 平台广告位id
     */
    private String slotId;
    /**
     * appid
     */
    private String appId;
    /**
     * 创建时间
     */
    private Date createTime;
    private String create_Time;
    private Date startTime;
    private Date endTime;
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
     * ecpm
     */
    private double ecpm;
    private String beforeEcpm;
    private String afterEcpm;
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

    private String nickName;
    private String appName;
    private double dividedY;

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getBeforeEcpm() {
        return beforeEcpm;
    }

    public void setBeforeEcpm(String beforeEcpm) {
        this.beforeEcpm = beforeEcpm;
    }

    public String getAfterEcpm() {
        return afterEcpm;
    }

    public void setAfterEcpm(String afterEcpm) {
        this.afterEcpm = afterEcpm;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public double getDividedY() {
        return dividedY;
    }

    public void setDividedY(double dividedY) {
        this.dividedY = dividedY;
    }

    public Long getStatisticsId() {
        return statisticsId;
    }

    public void setStatisticsId(Long statisticsId) {
        this.statisticsId = statisticsId;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public String getUpstreamName() {
        return upstreamName;
    }

    public void setUpstreamName(String upstreamName) {
        this.upstreamName = upstreamName;
    }

    public String getSlotId() {
        return slotId;
    }

    public void setSlotId(String slotId) {
        this.slotId = slotId;
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

    public String getCreate_Time() {
        return create_Time;
    }

    public void setCreate_Time(String create_Time) {
        this.create_Time = create_Time;
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

    public double getEcpm() {
        return ecpm;
    }

    public void setEcpm(double ecpm) {
        this.ecpm = ecpm;
    }

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
}
