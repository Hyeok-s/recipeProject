package com.foodRecipe.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.foodRecipe.demo.Interceptor.LoginInterceptor;
import com.foodRecipe.demo.Interceptor.LogoutInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final LoginInterceptor loginInterceptor;
    private final LogoutInterceptor logoutInterceptor;
    
    public WebConfig(LoginInterceptor loginInterceptor, LogoutInterceptor logoutInterceptor) {
    	this.logoutInterceptor = logoutInterceptor;
        this.loginInterceptor = loginInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/member/loginForm");
        
        registry.addInterceptor(logoutInterceptor)
        .addPathPatterns("/member/logout", "/community/addComment", "/community/writeForm", 
        		"/community/write", "/community/deleteComment", "/community/editComment");
    }
}