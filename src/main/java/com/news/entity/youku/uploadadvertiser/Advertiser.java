package com.news.entity.youku.uploadadvertiser;

import java.util.List;

/**
 * 对象元素说明
 */
public class Advertiser {

    private String name;
    private String brand;
    private String address;
    private String contacts;
    private String tel;
    private int firstindustry;
    private int secondindustry;
    private List<Qualifications> qualifications;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContacts() {
        return contacts;
    }

    public void setContacts(String contacts) {
        this.contacts = contacts;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public int getFirstindustry() {
        return firstindustry;
    }

    public void setFirstindustry(int firstindustry) {
        this.firstindustry = firstindustry;
    }

    public int getSecondindustry() {
        return secondindustry;
    }

    public void setSecondindustry(int secondindustry) {
        this.secondindustry = secondindustry;
    }

    public List<Qualifications> getQualifications() {
        return qualifications;
    }

    public void setQualifications(List<Qualifications> qualifications) {
        this.qualifications = qualifications;
    }
}
