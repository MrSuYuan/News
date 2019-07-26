package com.utils.jsoup;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Test {
    public static void main(String[] args) throws Exception {
        getNews();
    }

    // 获取http://www.ltaaa.com/
    public static void getNews() {
        String url = "http://www.cnqiang.com/";
        try {
            //获取整个网页内容
            Document doc = Jsoup.connect(url).get();
            //取得网页的li标签
            Elements liList = doc.select("li");
            for (Element element : liList) {
                //获取a标签
                Elements aList = element.getElementsByTag("a");
                //获取a标签的链接
                String hrefUrl = aList.attr("href");
                //判断hrefUrl的页面是以2开头的
                if(hrefUrl.indexOf("2")==0){
                    String newsUrl = url + hrefUrl;
                    //获取整个网页内容
                    Document d = Jsoup.connect(newsUrl).get();
                    //获取页面的标题
                    String title = d.select("h1").get(0).text();
                    //页面新闻内容
                    Element content = d.getElementById("article_content");
                    //时间和作者信息
                    String author = d.getElementsByClass("xg1").text();
                    //内容图片需要拼接url路径
                    Elements imgs = content.getElementsByTag("img");
                    for(Element img : imgs){
                        String src = img.attr("src");
                        if(src.indexOf("/")==0){
                            String imageUrl = "http://www.cnqiang.com" + img.attr("src");
                            img.attr("src",imageUrl);
                        }
                    }

                }
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
