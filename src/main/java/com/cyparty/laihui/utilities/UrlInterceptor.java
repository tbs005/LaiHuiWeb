package com.cyparty.laihui.utilities;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Shadow on 2016/7/21.
 */
public class UrlInterceptor extends HandlerInterceptorAdapter {
    public boolean is_success = true;
    List<String> unCheckUrl;

    public List<String> getUnCheckUrl() {
        return unCheckUrl;
    }

    public void setUnCheckUrl(List<String> unCheckUrl) {
        this.unCheckUrl = unCheckUrl;
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (unCheckUrl.contains(request.getRequestURI())||request.getRequestURI().startsWith("/resource")){
            return true;
        }else
        {
            response.sendRedirect("404");
            return false;
        }

    }

    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object o, ModelAndView mav)
            throws Exception {
        System.out.println("postHandle");
    }

    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object o, Exception excptn)
            throws Exception {
        System.out.println("afterCompletion");
    }
}
