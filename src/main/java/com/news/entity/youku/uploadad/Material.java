package com.news.entity.youku.uploadad;

import java.util.List;

public class Material {

    private String crid;
    private String url;
    private String landingpage;
    private String deeplink;
    private String advertiser;
    private String startdate;
    private String enddate;
    private List<String> monitor;
    private List<String> tmonitor;
    private List<String> emonitor;
    private List<String> cmonitor;
    private int ldptype;
    private List<Integer> orderid;
    private List<Integer> dealid;

    public String getCrid() {
        return crid;
    }

    public void setCrid(String crid) {
        this.crid = crid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLandingpage() {
        return landingpage;
    }

    public void setLandingpage(String landingpage) {
        this.landingpage = landingpage;
    }

    public String getDeeplink() {
        return deeplink;
    }

    public void setDeeplink(String deeplink) {
        this.deeplink = deeplink;
    }

    public String getAdvertiser() {
        return advertiser;
    }

    public void setAdvertiser(String advertiser) {
        this.advertiser = advertiser;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public List<String> getMonitor() {
        return monitor;
    }

    public void setMonitor(List<String> monitor) {
        this.monitor = monitor;
    }

    public List<String> getTmonitor() {
        return tmonitor;
    }

    public void setTmonitor(List<String> tmonitor) {
        this.tmonitor = tmonitor;
    }

    public List<String> getEmonitor() {
        return emonitor;
    }

    public void setEmonitor(List<String> emonitor) {
        this.emonitor = emonitor;
    }

    public List<String> getCmonitor() {
        return cmonitor;
    }

    public void setCmonitor(List<String> cmonitor) {
        this.cmonitor = cmonitor;
    }

    public int getLdptype() {
        return ldptype;
    }

    public void setLdptype(int ldptype) {
        this.ldptype = ldptype;
    }

    public List<Integer> getOrderid() {
        return orderid;
    }

    public void setOrderid(List<Integer> orderid) {
        this.orderid = orderid;
    }

    public List<Integer> getDealid() {
        return dealid;
    }

    public void setDealid(List<Integer> dealid) {
        this.dealid = dealid;
    }
}
