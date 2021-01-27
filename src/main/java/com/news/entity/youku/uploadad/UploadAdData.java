package com.news.entity.youku.uploadad;

import java.util.List;

public class UploadAdData {

    private String type;
    private List<Material> material;
    private List<Native> aNative;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Material> getMaterial() {
        return material;
    }

    public void setMaterial(List<Material> material) {
        this.material = material;
    }

    public List<Native> getaNative() {
        return aNative;
    }

    public void setaNative(List<Native> aNative) {
        this.aNative = aNative;
    }
}
