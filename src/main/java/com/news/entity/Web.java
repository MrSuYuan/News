package com.news.entity;

import java.util.Date;

/**
 * web信息
 */
public class Web {

    /**
     * webId
     */
    private Long webId;
    /**
     * 网站域名
     */
    private String webUrl;
    /**
     * 网站名称
     */
    private String webName;
    /**
     * 所属用户
     */
    private Long userId;
    /**
     * 大类
     */
    private Long rootType;
    /**
     * 小类
     */
    private Long subType;
    /**
     * 备案信息
     */
    private String recordInfo;
    /**
     * 访问量(1万 2十万 3百万 4千万 5千万+)
     */
    private int accessLevel;
    /**
     * 网站描述
     */
    private String webDescription;
    /**
     * 备注
     */
    private String remark;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 认证状态(1未审核 2审核驳回 3正常  4禁用)
     */
    private int webStatus;

    public int getWebStatus() {
        return webStatus;
    }

    public void setWebStatus(int webStatus) {
        this.webStatus = webStatus;
    }

    public Long getWebId() {
        return webId;
    }

    public void setWebId(Long webId) {
        this.webId = webId;
    }

    public String getWebUrl() {
        return webUrl;
    }

    public void setWebUrl(String webUrl) {
        this.webUrl = webUrl;
    }

    public String getWebName() {
        return webName;
    }

    public void setWebName(String webName) {
        this.webName = webName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public String getRecordInfo() {
        return recordInfo;
    }

    public void setRecordInfo(String recordInfo) {
        this.recordInfo = recordInfo;
    }

    public int getAccessLevel() {
        return accessLevel;
    }

    public void setAccessLevel(int accessLevel) {
        this.accessLevel = accessLevel;
    }

    public String getWebDescription() {
        return webDescription;
    }

    public void setWebDescription(String webDescription) {
        this.webDescription = webDescription;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
