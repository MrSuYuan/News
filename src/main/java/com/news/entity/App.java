package com.news.entity;

import java.util.Date;

/**
 * App信息
 */
public class App {

    /**
     * appId
     */
    private String appId;
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
    private Date createTime;
    /**
     * 所属用户
     */
    private Long userId;
    /**
     * 接入方式
     */
    private int accessMethod;
    /**
     * 认证状态
     */
    private int appStatus;
    /**
     * 分类大类
     */
    private Long rootType;
    /**
     * 分类小类
     */
    private Long subType;
    /**
     * 适用系统
     */
    private int platform;
    /**
     * 适用终端
     */
    private int terminal;
    /**
     * 主包名
     */
    private String packageName;
    /**
     * 应用版本
     */
    private String version;
    /**
     * app简介
     */
    private String description;
    /**
     * 关键字
     */
    private String keyWords;
    /**
     * 审核状态
     */
    private int auditStatus;

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public int getAccessMethod() {
        return accessMethod;
    }

    public void setAccessMethod(int accessMethod) {
        this.accessMethod = accessMethod;
    }

    public int getAppStatus() {
        return appStatus;
    }

    public void setAppStatus(int appStatus) {
        this.appStatus = appStatus;
    }

    public Long getRootType() {
        return rootType;
    }

    public void setRootType(Long rootType) {
        this.rootType = rootType;
    }

    public Long getSubType() {
        return subType;
    }

    public void setSubType(Long subType) {
        this.subType = subType;
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

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getKeyWords() {
        return keyWords;
    }

    public void setKeyWords(String keyWords) {
        this.keyWords = keyWords;
    }

    public int getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(int auditStatus) {
        this.auditStatus = auditStatus;
    }
}
