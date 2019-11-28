package com.news.entity;

import java.util.Date;

/**
 * 上游信息
 */
public class AppUpstreamType {

    /**
     * id
     */
    private int id;
    /**
     * 名称
     */
    private String name;
    /**
     * 类型(按顺序排)
     */
    private int type;
    /**
     * 字母简称
     */
    private String shortName;
    /**
     * 创建时间
     */
    private Date createTime;
    private String create_time;
    /**
     * 启用状态
     */
    private int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
