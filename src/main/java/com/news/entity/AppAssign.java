package com.news.entity;

/**
 * app调度分配
 */
public class AppAssign {

    /**
     * id
     */
    private Long id;
    /**
     * 广告位id
     */
    private String spaceId;
    /**
     * 上游类型 1东方 2万咖 3极光 4余梁 5一点通
     */
    private int upstreamType;
    /**
     * 概率
     */
    private int probability;
    /**
     * 类型 1测试 2正式
     */
    private int type;
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

    public String getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(String spaceId) {
        this.spaceId = spaceId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
