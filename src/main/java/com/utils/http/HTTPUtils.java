package com.utils.http;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;

import java.io.ByteArrayOutputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Http工具类
 * 
 * @author jianfeihit
 * 
 */
public class HTTPUtils {
	
	public final static String PARAM_SIG = "sig";

	public final static String[] NOT_ENCRYPTED_PARAMS = { PARAM_SIG };
	

	public static String getResponseAsStringByGetMethod(String url,int timeout,Map<String, Object> params) throws Exception{
		CloseableHttpResponse response = null;
		CloseableHttpClient httpclient = null;
		try {
			httpclient = HttpClients.createDefault();
			HttpPost httpGet = new HttpPost(url);
			httpGet.addHeader("Content-Type","application/x-www-form-urlencoded");
			RequestConfig config = RequestConfig.custom().setSocketTimeout(timeout).setConnectTimeout(timeout).build();
			httpGet.setConfig(config);
			
			 List<NameValuePair> pairList = new ArrayList<NameValuePair>(params.size());
	            for (Map.Entry<String, Object> entry : params.entrySet()) {
	                NameValuePair pair = new BasicNameValuePair(entry.getKey(), entry
	                        .getValue().toString());
	                pairList.add(pair);
	            }
	        httpGet.setEntity(new UrlEncodedFormEntity(pairList, Charset.forName("UTF-8")));
			response = httpclient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			ByteArrayOutputStream buf = new ByteArrayOutputStream();
			entity.writeTo(buf);
			return new String(buf.toByteArray(),"utf-8");
		} catch (Exception e) {
			throw e;
		}
	}



	 
}
