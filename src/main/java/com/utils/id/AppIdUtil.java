package com.utils.id;

/**
 * 生成6位字符串随机appId
 */
public class AppIdUtil {

    public static String getAppId() {
        String linkNo = "";
        // 用字符数组的方式随机
        String model = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        char[] m = model.toCharArray();
        for (int j = 0; j < 6; j++) {
            char c = m[(int) (Math.random() * 36)];
            // 保证六位随机数之间没有重复的
            if (linkNo.contains(String.valueOf(c))) {
                j--;
                continue;
            }
            linkNo = linkNo + c;
        }
        return linkNo;
    }

    public static String getSlotId() {
        String linkNo = "";
        // 用字符数组的方式随机
        String model = "0123456789abcdefghijklmnopqrstuvwxyz";
        char[] m = model.toCharArray();
        for (int j = 0; j < 8; j++) {
            char c = m[(int) (Math.random() * 36)];
            // 保证六位随机数之间没有重复的
            if (linkNo.contains(String.valueOf(c))) {
                j--;
                continue;
            }
            linkNo = linkNo + c;
        }
        return linkNo;
    }
}
