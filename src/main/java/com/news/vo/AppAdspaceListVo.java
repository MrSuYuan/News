package com.news.vo;

/**
 * 广告位返回信息
 */
public class AppAdspaceListVo {

    /**
     * 广告位id
     */
    private String spaceId;
    /**
     * appId
     */
    private String appId;
    /**
     * 广告位类型(1横幅 2开屏 3插屏 4信息流 5激励视频)
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

    public String getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(String spaceId) {
        this.spaceId = spaceId;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
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
