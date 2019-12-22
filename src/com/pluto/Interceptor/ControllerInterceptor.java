package com.pluto.Interceptor;

import com.pluto.controller.Pluto_Controller;
import com.pluto.service.Pluto_LcController;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ControllerInterceptor implements HandlerInterceptor {

    @Resource
    Pluto_LcController services;

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        boolean flag = false;
        String uri = httpServletRequest.getRequestURI();
        System.out.println("uri==="+uri);
        uri = uri.substring(5,uri.length());
        System.out.println("截取完以后的uri---"+uri);
        Object obj = httpServletRequest.getSession().getAttribute("admin");
        EmpVo emp = null;
        if("/login".equals(uri) || "/controller/toNo".equals(uri) || "/toPage/login".equals(uri)){
            return true;
        }
        if(obj!=null){
            emp= (EmpVo) obj;
            List nList = services.getControllerList(emp.getEmpId());
            for (int i = 0; i < nList.size(); i++) {
                Map m = (Map) nList.get(i);
                if(m==null){
                    continue;
                }
                Object aa = m.get("controller");
                if(aa==null){
                    continue;
                }
                String s = aa.toString();
                if(s.equals(uri)){
                    httpServletRequest.getRequestDispatcher("controller/toNo").forward(httpServletRequest,httpServletResponse);
                    return false;
                }
            }
        }else {
            httpServletRequest.getRequestDispatcher("controller/toNo").forward(httpServletRequest,httpServletResponse);
            return false;
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
