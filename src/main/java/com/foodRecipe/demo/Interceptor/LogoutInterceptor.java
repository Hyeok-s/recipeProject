package com.foodRecipe.demo.Interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.foodRecipe.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LogoutInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("memberId") == null) {
        	response.setContentType("text/html; charset=UTF-8");
        	response.getWriter().append(Util.jsReturn("로그인 후 이용해주세요.", "/member/loginForm"));
        	response.getWriter().flush();
        	response.getWriter().close();
            return false;
        }
        return true;
    }

}
