package com.news.vo;

/**
 * 广告位分时统计
 */
public class PlatformStatisticsListVo {

    private String appId;
    private String slotId;
    private int hour;
    private int downstreamRequest;
    private int request;
    private int response;
    private int look;
    private int click;
    private int deeplink;
    private int t200;
    private int t250;
    private int t300;
    private int t400;
    private int t500;
    private int t1000;

    public int getT200() {
        return t200;
    }

    public void setT200(int t200) {
        this.t200 = t200;
    }

    public int getT250() {
        return t250;
    }

    public void setT250(int t250) {
        this.t250 = t250;
    }

    public int getT300() {
        return t300;
    }

    public void setT300(int t300) {
        this.t300 = t300;
    }

    public int getT400() {
        return t400;
    }

    public void setT400(int t400) {
        this.t400 = t400;
    }

    public int getT500() {
        return t500;
    }

    public void setT500(int t500) {
        this.t500 = t500;
    }

    public int getT1000() {
        return t1000;
    }

    public void setT1000(int t1000) {
        this.t1000 = t1000;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getSlotId() {
        return slotId;
    }

    public void setSlotId(String slotId) {
        this.slotId = slotId;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public int getDownstreamRequest() {
        return downstreamRequest;
    }

    public void setDownstreamRequest(int downstreamRequest) {
        this.downstreamRequest = downstreamRequest;
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
