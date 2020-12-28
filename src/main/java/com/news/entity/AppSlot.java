package com.news.entity;

import java.util.Date;

/**
 * app广告位信息
 */
public class AppSlot {

    /**
     * 广告位id
     */
    private String slotId;
    /**
     * appId
     */
    private String appId;
    /**
     * 广告位类型(1横幅 2开屏 3插屏 4信息流 5激励视频)
     */
    private int slotType;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 广告位名称
     */
    private String slotName;
    /**
     * 宽度
     */
    private int width;
    /**
     * 高度
     */
    private int height;
    /**
     * 放量状态
     */
    private int flowStatus;

    public String getSlotId() {
        return slotId;
    }

    public void setSlotId(String slotId) {
        this.slotId = slotId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public int getSlotType() {
        return slotType;
    }

    public void setSlotType(int slotType) {
        this.slotType = slotType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getSlotName() {
        return slotName;
    }

    public void setSlotName(String slotName) {
        this.slotName = slotName;
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

    public int getFlowStatus() {
        return flowStatus;
    }

    public void setFlowStatus(int flowStatus) {
        this.flowStatus = flowStatus;
    }
}
