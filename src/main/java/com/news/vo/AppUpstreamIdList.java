package com.news.vo;

/**
 * 上游广告位id列表
 */
public class AppUpstreamIdList {

    /**
     *
     */
    private String upstreamId;
    /**
     *
     */
    private String upstreamAppId;
    /**
     *
     */
    private String name;
    /**
     *
     */
    private String appId;
    /**
     *
     */
    private String slotId;
    /**
     *
     */
    private String slotName;
    /**
     *
     */
    private String appName;
    private int probability;
    private String upstreamPackageName;
    private String vendorDivision;

    public String getVendorDivision() {
        return vendorDivision;
    }

    public void setVendorDivision(String vendorDivision) {
        this.vendorDivision = vendorDivision;
    }

    public String getUpstreamPackageName() {
        return upstreamPackageName;
    }

    public void setUpstreamPackageName(String upstreamPackageName) {
        this.upstreamPackageName = upstreamPackageName;
    }

    public int getProbability() {
        return probability;
    }

    public void setProbability(int probability) {
        this.probability = probability;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public String getUpstreamAppId() {
        return upstreamAppId;
    }

    public void setUpstreamAppId(String upstreamAppId) {
        this.upstreamAppId = upstreamAppId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getSlotId() {
        return slotId;
    }

    public void setSlotId(String slotId) {
        this.slotId = slotId;
    }

    public String getSlotName() {
        return slotName;
    }

    public void setSlotName(String slotName) {
        this.slotName = slotName;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }
}
