package com.news.vo;

public class AppListVo {

    /**
     * appId
     */
    private Long appId;
    /**
     * app名称
     */
    private String appName;
    /**
     * 下载地址
     */
    private String downloadlink;
    /**
     * 上架时间
     */
    private String createTime;
    /**
     * 所属用户
     */
    private String nickName;
    /**
     * 认证状态
     */
    private int appStatus;
    /**
     * 适用系统(1安卓 2ios 3win)
     */
    private int platform;
    /**
     * 适用终端(1手机 2平板 3电脑)
     */
    private int terminal;

    public Long getAppId() {
        return appId;
    }

    public void setAppId(Long appId) {
        this.appId = appId;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getDownloadlink() {
        return downloadlink;
    }

    public void setDownloadlink(String downloadlink) {
        this.downloadlink = downloadlink;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public int getAppStatus() {
        return appStatus;
    }

    public void setAppStatus(int appStatus) {
        this.appStatus = appStatus;
    }

    public int getPlatform() {
        return platform;
    }

    public void setPlatform(int platform) {
        this.platform = platform;
    }

    public int getTerminal() {
        return terminal;
    }

    public void setTerminal(int terminal) {
        this.terminal = terminal;
    }
}
