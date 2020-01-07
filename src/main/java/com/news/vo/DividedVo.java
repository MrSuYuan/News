package com.news.vo;

/**
 * 分润参数
 */
public class DividedVo {

    private int spaceId;
    private String upstreamId;
    private double dividedY;
    private double dividedZ;
    private double upstreamDivided;

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

    public int getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(int spaceId) {
        this.spaceId = spaceId;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public double getUpstreamDivided() {
        return upstreamDivided;
    }

    public void setUpstreamDivided(double upstreamDivided) {
        this.upstreamDivided = upstreamDivided;
    }
}
