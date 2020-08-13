package com.news.vo;

/**
 * 渠道分时统计-详情列表
 */
public class ChannelStatisticsListVo {

    private String upstreamId;
    private int hour;
    private int request;
    private int response;
    private int look;
    private int click;
    private int deeplink;

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public String getUpstreamId() {
        return upstreamId;
    }

    public void setUpstreamId(String upstreamId) {
        this.upstreamId = upstreamId;
    }

    public int getRequest() {
        return request;
    }

    public void setRequest(int request) {
        this.request = request;
    }

    public int getResponse() {
        return response;
    }

    public void setResponse(int response) {
        this.response = response;
    }

    public int getLook() {
        return look;
    }

    public void setLook(int look) {
        this.look = look;
    }

    public int getClick() {
        return click;
    }

    public void setClick(int click) {
        this.click = click;
    }

    public int getDeeplink() {
        return deeplink;
    }

    public void setDeeplink(int deeplink) {
        this.deeplink = deeplink;
    }
}
