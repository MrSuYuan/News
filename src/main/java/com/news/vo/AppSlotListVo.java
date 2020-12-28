package com.news.vo;

/**
 * 广告位返回信息
 */
public class AppSlotListVo {

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
    private String createTime;
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
     * APP名称
     */
    private String appName;
    /**
     * 所属用户名称
     */
    private String nickName;
    /**
     * 分成比例
     */
    private double dividedY;
    private double dividedZ;
    private int request;
    private int flowStatus;

    public int getFlowStatus() {
        return flowStatus;
    }

    public void setFlowStatus(int flowStatus) {
        this.flowStatus = flowStatus;
    }

    public int getRequest() {
        return request;
    }

    public void setRequest(int request) {
        this.request = request;
    }

    public double getDividedY() {
        return dividedY;
    }

    public void setDividedY(double dividedY) {
        this.dividedY = dividedY;
    }

    public double getDividedZ() {
        return dividedZ;
    }

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

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getSlotName() {
        return slotName;
    }

    public void setSlotName(String slotName) {
        this.slotName = slotName;
    }

    public void setDividedZ(double dividedZ) {
        this.dividedZ = dividedZ;
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

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
}
