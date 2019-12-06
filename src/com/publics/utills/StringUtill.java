package com.publics.utills;

import java.io.UnsupportedEncodingException;

public class StringUtill {
    //字符串乱码
    public static  String tostring(String s) throws UnsupportedEncodingException {
        return new String(s.getBytes("ISO-8859-1"),"utf-8");
    };
}
