package com.news.entity.pengtai;

public class PtRequest {

    private String token;
    private PtApp app;
    private PtDevice device;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public PtApp getApp() {
        return app;
    }

    public void setApp(PtApp app) {
        this.app = app;
    }

    public PtDevice getDevice() {
        return device;
    }

    public void setDevice(PtDevice device) {
        this.device = device;
    }
}
