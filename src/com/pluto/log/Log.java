package com.pluto.log;

import org.springframework.aop.MethodBeforeAdvice;

import java.lang.reflect.Method;

public class Log {
    public void afterAdvice(){
        System.out.println("Logging:after... ");
    }
}
