package com.news.entity;

import java.util.Date;

/**
 * web端广告位信息
 */
public class WebAdspace {
    /**
     * 广告位id
     */
    private Long spaceId;
    /**
     * webId
     */
    private Long webId;
    /**
     * 广告位类型(1横幅 2开屏 3插屏 4信息流)
     */
    private int spaceType;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 广告位名称
     */
    private String spaceName;
    /**
     * 宽度
     */
    private int width;
    /**
     * 高度
     */
    private int height;

    public Long getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(Long spaceId) {
        this.spaceId = spaceId;
    }

    public Long getWebId() {
        return webId;
    }

    public void setWebId(Long webId) {
        this.webId = webId;
    }

    public int getSpaceType() {
        return spaceType;
    }

    public void setSpaceType(int spaceType) {
        this.spaceType = spaceType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }
}
