package com.news.vo;

/**
 * web统计-管理
 */
public class WebStatisticsManage {

    private int statisticsId;
    private String spaceId;
    private String spaceName;
    private String webName;
    private String createTime;
    private int lookPV;
    private int clickNum;
    private double clickProbability;
    private double income;
    private double ecmp;
    private int status;
    private int beforeLookPV;
    private int beforeClickNum;
    private double beforeIncome;
    private double dividedY;
    private double dividedZ;

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

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public String getWebName() {
        return webName;
    }

    public void setWebName(String webName) {
        this.webName = webName;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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
