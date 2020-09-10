package com.news.vo;

import java.util.Date;

/**
 * web统计-管理
 */
public class WebStatisticsManage {

    //数据库表字段
    private int statisticsId;
    private String spaceId;
    private Date createTime;
    private int lookPV;
    private int clickNum;
    private double clickProbability;
    private double income;
    private double ecpm;
    private int beforeLookPV;
    private int beforeClickNum;
    private double beforeIncome;
    private int status;
    //页面查询辅助字段
    private String upstreamId;
    private String webName;
    private String spaceName;
    private String create_Time;
    private double beforeEcpm;
    private double dividedX;
    private double dividedY;
    private double dividedZ;
    private Date startTime;
    private Date endTime;

    public int getStatisticsId() {
        return statisticsId;
    }

    public void setStatisticsId(int statisticsId) {
        this.statisticsId = statisticsId;
    }

    public String getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(String spaceId) {
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public String getWebName() {
        return webName;
    }

    public void setWebName(String webName) {
        this.webName = webName;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public String getCreate_Time() {
        return create_Time;
    }

    public void setCreate_Time(String create_Time) {
        this.create_Time = create_Time;
    }

    public double getBeforeEcpm() {
        return beforeEcpm;
    }

    public void setBeforeEcpm(double beforeEcpm) {
        this.beforeEcpm = beforeEcpm;
    }

    public double getDividedX() {
        return dividedX;
    }

    public void setDividedX(double dividedX) {
        this.dividedX = dividedX;
    }

    public double getDividedY() {
        return dividedY;
    }

    public void setDividedY(double dividedY) {
        this.dividedY = dividedY;
    }

    public double getDividedZ() {
        return dividedZ;
    }

    public void setDividedZ(double dividedZ) {
        this.dividedZ = dividedZ;
    }

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
}
