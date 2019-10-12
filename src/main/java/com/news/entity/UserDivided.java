package com.news.entity;

/**
 * 分成比例
 */
public class UserDivided {

    /**
     * 分润id
     */
    private Long dividedId;
    /**
     * 用户id
     */
    private Long userId;
    /**
     * 展现比例
     */
    private double lookProportion;
    /**
     * 点击比例
     */
    private double clickProportion;
    /**
     * 上游设置分润比例
     */
    private double upstreamProportion;
    /**
     * 当前用户设置分润比例
     */
    private double userProportion;
    /**
     * 类型 1app端 2web端
     */
    private int type;

    public Long getDividedId() {
        return dividedId;
    }

    public void setDividedId(Long dividedId) {
        this.dividedId = dividedId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public double getLookProportion() {
        return lookProportion;
    }

    public void setLookProportion(double lookProportion) {
        this.lookProportion = lookProportion;
    }

    public double getClickProportion() {
        return clickProportion;
    }

    public void setClickProportion(double clickProportion) {
        this.clickProportion = clickProportion;
    }

    public double getUpstreamProportion() {
        return upstreamProportion;
    }

    public void setUpstreamProportion(double upstreamProportion) {
        this.upstreamProportion = upstreamProportion;
    }

    public double getUserProportion() {
        return userProportion;
    }

    public void setUserProportion(double userProportion) {
        this.userProportion = userProportion;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
