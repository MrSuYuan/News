package com.news.vo;

/**
 * 广告位统计列表返回信息
 */
public class AppStatisticsListVo {

    private Long spaceId;
    private String spaceName;
    private String appName;
    private String createTime;
    private int lookPV;
    private int clickNum;
    private double clickProbability;
    private double income;
    private double ecmp;

    public Long getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(Long spaceId) {
        this.spaceId = spaceId;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
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
