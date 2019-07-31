package com.news.entity;

import java.util.List;

/**
 * 新闻数据载体
 */
public class News {

    private long newsId;
    /**
     * 新闻标题
     */
    private String title;
    /**
     * 时间作者出处
     */
    private String author;
    /**
     * 内容,html代码
     */
    private String content;
    /**
     * 图片路径,多张分号拼接
     */
    private String url;
    /**
     * 图片类型  0无图新闻 1单图 2三图
     */
    private int type;
    /**
     * 内容类型  1推荐 2热点 3娱乐 4科技 5探索 6趣闻 7历史
     */
    private int contentType;
    /**
     * 图片拆分
     */
    private List<String> pictureUrl;

    public int getContentType() {
        return contentType;
    }

    public void setContentType(int contentType) {
        this.contentType = contentType;
    }

    public List<String> getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(List<String> pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public long getNewsId() {
        return newsId;
    }

    public void setNewsId(long newsId) {
        this.newsId = newsId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
