package com.utils.MD5;

import org.apache.commons.codec.digest.DigestUtils;

public class MD5 {

	public static String md5(String content) {
		if (content == null) {
			return null;
		} else {
			return DigestUtils.md5Hex(content);
		}
	}

	public static String sha1(String content){
		if (content == null) {
			return null;
		} else {
			return DigestUtils.sha1Hex(content);
		}
	}
}
