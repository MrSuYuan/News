package com.news.entity.youku.uploadad;

import java.util.List;

public class Native {

    private List<String> native_template_ids;
    private String crid;
    private String title;
    private String image_url;
    private String video_url;
    private String logo_url;
    private String brand;
    private String advertiser;
    private String startdate;
    private String enddate;
    private String landingpage;
    private List<String> monitor;
    private int ldptype;

    public List<String> getNative_template_ids() {
        return native_template_ids;
    }

    public void setNative_template_ids(List<String> native_template_ids) {
        this.native_template_ids = native_template_ids;
    }

    public String getCrid() {
        return crid;
    }

    public void setCrid(String crid) {
        this.crid = crid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getVideo_url() {
        return video_url;
    }

    public void setVideo_url(String video_url) {
        this.video_url = video_url;
    }

    public String getLogo_url() {
        return logo_url;
    }

    public void setLogo_url(String logo_url) {
        this.logo_url = logo_url;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
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

    public String getLandingpage() {
        return landingpage;
    }

    public void setLandingpage(String landingpage) {
        this.landingpage = landingpage;
    }

    public List<String> getMonitor() {
        return monitor;
    }

    public void setMonitor(List<String> monitor) {
        this.monitor = monitor;
    }

    public int getLdptype() {
        return ldptype;
    }

    public void setLdptype(int ldptype) {
        this.ldptype = ldptype;
    }
}
