package com.news.vo;

import java.util.Date;

/**
 * web端广告位列表信息
 */
public class WebAdSpaceListVo {

    /**
     * 上游id
     */
    private String upstreamId;
    /**
     * 使用状态
     */
    private int status;
    /**
     * 广告位id
     */
    private int spaceId;
    /**
     * 上游类型
     * 1东方 2万咖 3极光 4余梁 5一点通 6百度
     */
    private int upstreamType;
    /**
     * web网站名称
     */
    private String webName;
    /**
     * 终端类型(1pc 2wap)
     */
    private int terminal;
    /**
     * 广告位类型(1固定块 2右下浮 3对联)
     */
    private int spaceType;
    /**
     * 创建时间
     */
    private String createTime;
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

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(int spaceId) {
        this.spaceId = spaceId;
    }

    public int getUpstreamType() {
        return upstreamType;
    }

    public void setUpstreamType(int upstreamType) {
        this.upstreamType = upstreamType;
    }

    public String getWebName() {
        return webName;
    }

    public void setWebName(String webName) {
        this.webName = webName;
    }

    public int getTerminal() {
        return terminal;
    }

    public void setTerminal(int terminal) {
        this.terminal = terminal;
    }

    public int getSpaceType() {
        return spaceType;
    }

    public void setSpaceType(int spaceType) {
        this.spaceType = spaceType;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
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
