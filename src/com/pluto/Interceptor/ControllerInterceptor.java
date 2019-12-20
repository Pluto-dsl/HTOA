package com.pluto.Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerInterceptor implements HandlerInterceptor {
    private String[] whiteList = {"/toPage/login","/toPage/oamain"};
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        boolean flag = false;
        String uri = httpServletRequest.getRequestURI();
        for (String s : whiteList) {
            if(uri.equals(s)){
                flag=true;
            }
        }

        if(!flag){
            Object obj = httpServletRequest.getSession().getAttribute("admin");
            if(obj==null){
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/toPage/login");
                return false;
            }
        }

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
