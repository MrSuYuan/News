package com.news.entity;

/**
 * app调度分配
 */
public class AppAssign {

    /**
     * 广告位id
     */
    private String slotId;
    /**
     * 上游类型 1东方 2万咖 3极光 4余梁 5一点通
     */
    private int upstreamType;
    /**
     * 概率
     */
    private int probability;
    private String name;
    private String shortName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getSlotId() {
        return slotId;
    }

    public void setSlotId(String slotId) {
        this.slotId = slotId;
    }

    public int getUpstreamType() {
        return upstreamType;
    }

    public void setUpstreamType(int upstreamType) {
        this.upstreamType = upstreamType;
    }

    public int getProbability() {
        return probability;
    }

    public void setProbability(int probability) {
        this.probability = probability;
    }

}
