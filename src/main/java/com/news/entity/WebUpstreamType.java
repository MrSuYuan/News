package com.news.entity;

import java.util.Date;

public class WebUpstreamType {

    private String name;
    private int upstreamType;
    private Date createTime;
    private String time;
    private int status;
    private double upstreamDivided;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUpstreamType() {
        return upstreamType;
    }

    public void setUpstreamType(int upstreamType) {
        this.upstreamType = upstreamType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getUpstreamDivided() {
        return upstreamDivided;
    }

    public void setUpstreamDivided(double upstreamDivided) {
        this.upstreamDivided = upstreamDivided;
    }
}
