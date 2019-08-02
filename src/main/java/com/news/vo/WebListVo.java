package com.news.vo;

/**
 * web列表返回信息
 */
public class WebListVo {

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
     * 创建时间
     */
    private String createTime;
    /**
     * 认证状态(1未审核 2审核驳回 3正常  4禁用)
     */
    private int webStatus;
    /**
     * 所属用户
     */
    private String nickName;

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

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getWebStatus() {
        return webStatus;
    }

    public void setWebStatus(int webStatus) {
        this.webStatus = webStatus;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
}
