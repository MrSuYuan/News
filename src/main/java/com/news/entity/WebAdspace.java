package com.news.entity;

import java.util.Date;

/**
 * web端广告位信息
 */
public class WebAdspace {
    /**
     * 广告位id
     */
    private String spaceId;
    /**
     * webId
     */
    private Long webId;
    /**
     * 终端类型(1pc 2wap)
     */
    private int terminal;
    /**
     * 上游类型
     * 1东方 2万咖 3极光 4余梁 5一点通 6百度
     */
    private int upstreamType;
    /**
     * 广告位类型(1固定块 2右下浮 3对联)
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
    /**
     * 备注
     */
    private String remark;

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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getTerminal() {
        return terminal;
    }

    public void setTerminal(int terminal) {
        this.terminal = terminal;
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
