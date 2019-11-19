package com.news.entity;

import java.util.Date;

/**
 * app上游信息
 */
public class AppUpstream {

    /**
     * 上游广告位id
     */
    private String upstreamId;
    /**
     * 平台广告位ID
     */
    private String spaceId;
    /**
     * 上游类型(1东方 2万咖 3极光 4余梁 5一点通)
     */
    private int upstreamType;
    /**
     * 上游appId
     */
    private String upstreamAppId;
    /**
     * 上游包名
     */
    private String upstreamPackageName;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建时间
     */
    private String create_Time;

    public String getCreate_Time() {
        return create_Time;
    }

    public void setCreate_Time(String create_Time) {
        this.create_Time = create_Time;
    }

    public String getUpstreamPackageName() {
        return upstreamPackageName;
    }

    public void setUpstreamPackageName(String upstreamPackageName) {
        this.upstreamPackageName = upstreamPackageName;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public String getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(String spaceId) {
        this.spaceId = spaceId;
    }

    public int getUpstreamType() {
        return upstreamType;
    }

    public void setUpstreamType(int upstreamType) {
        this.upstreamType = upstreamType;
    }

    public String getUpstreamAppId() {
        return upstreamAppId;
    }

    public void setUpstreamAppId(String upstreamAppId) {
        this.upstreamAppId = upstreamAppId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
